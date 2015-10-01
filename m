From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 1 Oct 2015 16:07:21 +0800
Subject: [PATCH] soc: mediatek: Fix random hang up issue while kernel init
In-Reply-To: <1443683750.1714.25.camel@mtksdaap41>
References: <1443162717-64831-1-git-send-email-jamesjj.liao@mediatek.com>
 <1443169573.3135.9.camel@pengutronix.de> <5607D224.4050801@gmail.com>
 <CAGS+omCXMRf4bxWancSJSq2a1pc38TYYY46Os9ASWWCRp95_ig@mail.gmail.com>
 <1443604022.3185.17.camel@pengutronix.de>
 <1443683750.1714.25.camel@mtksdaap41>
Message-ID: <CAGS+omCpWqtKPKoyjFb=q4BxmfUGGsfvQGEZas8g8VLZKPtKbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Thu, Oct 1, 2015 at 3:15 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> Hi Lucas,
>
> On Wed, 2015-09-30 at 11:07 +0200, Lucas Stach wrote:
>> > If the VENC power domain is disabled, then accesses to the vencsys
>> > registers just silently fail (i.e., reads probably
>> > return all 0s).
>>
>> If this ever happens it is really unfortunate and needs fixing, too. If
>> you need the power domain to be powered ON to properly read or even
>> change the clock registers, the clock driver needs to be a consumer of
>> the power domain, so any clock operations powers the domain up.
>
> A subsystem should be powered on before its clock operations. But I
> think this flow should be guaranteed by VENC driver. This patch is
> focused on the race between disabling unused clocks and power domains by
> frameworks.
>
>> > In theory, we could add "clocks=<&topckgen CLK_TOP_VENC_SEL>;" to the
>> > vencsys clock-controller node.  On initialization, mtk_vencsys_init()
>> > could then pass venc_sel to the generic MT8173 gate clock driver, and
>> > it would then clk_enable(venc_sel)/_disable(venc_sel) around any
>> > access to the clock-controller registers.  James, however, thinks
>> > this is a lot of extra overhead, and instead has proposed the fix in this patch,
>> > where venc_sel is forced on whenever the VENC power domain is enabled.
>> >
>> I would still say this is the correct solution. If the vencsys clock
>> registers are itself clocked by VENC_SEL this driver needs to make sure
>> this clock is running at the appropriate times. I understand that this
>> may be a bit of an overhead, but clock enable/disable paths are not
>> really performance critical.
>>
>> > So, this patch is a bit of a hack, but the mtk scpsys driver already
>> > does something similar for the MM & MFG clocks - these clocks are
>> > always enabled whenever certain power domains are enabled, and they
>> > are only disabled when all such power domains are disabled.  I'm not
>> > 100% why these clocks must always be kept on whenever these power
>> > domains are enabled, but probably to solve a similar problem where
>> > these clocks are needed to access some registers at a time when these
>> > clocks would not otherwise be explicitly enabled.
>> >
>> I can't really argue with this being the wrong solution if we already
>> have precedent of the same solution being used for other domains. But I
>> would still ask you to re-evaluate with the above in mind.
>
> One cause of the hang up issue is frameworks' behavior. Power domain
> framework and clock framework work independently during kernel init. So
> their control flow can't be guaranteed by a suitable driver, such as
> VENC driver.

Hmm... below is my current understanding.

In the current software architecture, we have split the "venc"
subsystem register space into two parts (two dt nodes), with each node
handled instantiated as its own  platform device, and handled by a
different platform driver:

vencsys: clock-controller at 18000000 {
  compatible = "mediatek,mt8173-vencsys", "syscon";
  reg = <0 0x18000000 0 0x1000>;
  #clock-cells = <1>;
};

/* TBD - a venc driver has not been posted to the list so I don't
really know yet what it will look like */
 venc: encoder@~18000000 {
   compatible = "mediatek,mt8173-venc?";
   reg = <0 ~0x18000000 0 ?>;
   clocks = <& <&vencsys CLK_VENC_CKE1>, <&vencsys CLK_VENC_CKE0>, ...;
   clock-names = "apb", "smi", ...;
   ...
 };

Each independent driver must take appropriate independent action to
ensure that any clock required to access its associated registers is
enabled when accessing said registers.
In other words,
 * the venc *clock-controller* driver that must enable any clocks
required to access the *clock control* registers
 * the venc *encoder* driver must enable clocks any clocks required to
access the *encoder* registers

Actually, the situation is a little worse that this, since we also
have a 'larb' node in the same register space, whose driver must also
ensure that VENC_SEL is enabled before accessing its registers:

larb3: larb at 18001000 {
  compatible = "mediatek,mt8173-smi-larb";
  reg = <0 0x18001000 0 0x1000>;
  mediatek,smi = <&smi_common>;
  power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
  clocks = <&vencsys CLK_VENC_CKE1>, <&vencsys CLK_VENC_CKE0>;
  clock-names = "apb", "smi";
};

Personally, I am not opposed to using the power-domain enable/disable
as a proxy for also enabling/disabling the "subsystem register bank"
clock as is done in this patch and by the scpsys driver in general.
However, it feels a bit like an abuse of the power domain api.

> I preferred to keep venc_sel on during VENC power on because I'm not
> sure there is any other framework may control VENC's registers during
> kernel init.

The misunderstanding here is the interpretation of "VENC's registers".
In this case, the registers in question are those owned by the
"vencsys: clock-controller at 18000000" node, and the driver accessing
them is drivers/clk/mediatek/clk-gate.c.

Best,
-Dan

>
>
> Best regards,
>
> James
>
>
