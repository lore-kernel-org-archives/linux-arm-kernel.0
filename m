From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 29 Sep 2015 18:25:44 +0800
Subject: [PATCH] soc: mediatek: Fix random hang up issue while kernel init
In-Reply-To: <5607D224.4050801@gmail.com>
References: <1443162717-64831-1-git-send-email-jamesjj.liao@mediatek.com>
 <1443169573.3135.9.camel@pengutronix.de> <5607D224.4050801@gmail.com>
Message-ID: <CAGS+omCXMRf4bxWancSJSq2a1pc38TYYY46Os9ASWWCRp95_ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias & Lucas,

On Sun, Sep 27, 2015 at 7:25 PM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 25/09/15 10:26, Lucas Stach wrote:
>>
>> Am Freitag, den 25.09.2015, 14:31 +0800 schrieb James Liao:
>>>
>>> In kernel late init, it turns off all unused clocks, which
>>> needs to access subsystem registers such as VENC and VENC_LT.
>>>
>>> Accessing MT8173 VENC registers needs two top clocks, mm_sel and
>>> venc_sel. Accessing VENC_LT registers needs mm_sel and venclt_sel.
>>> So we need to keep these clocks on before accessing their registers.
>>>
>>> This patch keeps venc_sel / venclt_sel clock on when
>>> VENC / VENC_LT's power is on, to prevent system hang up while
>>> accessing its registeres.
>>>
>> This changes the binding of an existing driver, so it needs some more
>> consideration. Are VENC_SEL and VENC_LT_SEL really direct clock inputs
>> to the VENC module, or are they some kind of parent clock for one of the
>> existing clocks used by the old VENC binding?
>>
>> If they are direct clock inputs to the VENC module, changing the binding
>> might be still ok at that point, as there shouldn't be many users of
>> that yet.

The MT8173 VENC subsystem clock registers are modeled by the vencsys
clock-controller node:

vencsys: clock-controller at 18000000 {
  compatible = "mediatek,mt8173-vencsys", "syscon";
  reg = <0 0x18000000 0 0x1000>;
  #clock-cells = <1>;
};

These registers, however, are only accessible if:
  (a) the VENC power domain is enabled, and
  (b) the "venc_sel" clock is enabled.

According to James, venc_sel is a direct clock input the VENC module,
and it is an ancestor to some, but not all, of the subsystem clocks, in
particular it is not an ancestor to "venc_cke0":

 static const struct mtk_gate venc_clks[] __initconst = {
         GATE_VENC(CLK_VENC_CKE0, "venc_cke0", "mm_sel", 0),
         GATE_VENC(CLK_VENC_CKE1, "venc_cke1", "venc_sel", 4),
         GATE_VENC(CLK_VENC_CKE2, "venc_cke2", "venc_sel", 8),
         GATE_VENC(CLK_VENC_CKE3, "venc_cke3", "venc_sel", 12),
 };

If the VENC power domain is disabled, then accesses to the vencsys
registers just silently fail (i.e., reads probably
return all 0s).  However, if the power domain is ON but venc_sel is
disabled, then accessing the clock-controller registers results in a
system hang (until the power domain is disabled).

At boot the VENC power domain is forced on by scpsys (like all other
power domains).  Later both unused clocks and power domains get
disabled. If clocks are disabled first, and venc_sel is disabled
before venc_cke0, then when unused_clock tries to disable venc_cke0,
the system will hang when it reads the vencsys "is clock enabled" bit
since:
  (a) VENC power domain is still enabled, and
  (b) venc_sel is already disabled

In theory, we could add "clocks=<&topckgen CLK_TOP_VENC_SEL>;" to the
vencsys clock-controller node.  On initialization, mtk_vencsys_init()
could then pass venc_sel to the generic MT8173 gate clock driver, and
it would then clk_enable(venc_sel)/_disable(venc_sel) around any
access to the clock-controller registers.  James, however, thinks
this is a lot of extra overhead, and instead has proposed the fix in this patch,
where venc_sel is forced on whenever the VENC power domain is enabled.

So, this patch is a bit of a hack, but the mtk scpsys driver already
does something similar for the MM & MFG clocks - these clocks are
always enabled whenever certain power domains are enabled, and they
are only disabled when all such power domains are disabled.  I'm not
100% why these clocks must always be kept on whenever these power
domains are enabled, but probably to solve a similar problem where
these clocks are needed to access some registers at a time when these
clocks would not otherwise be explicitly enabled.

Is the above clear?

>> But then we at least need a corresponding change to the binding documentation.

Agreed.

> Yes, we will need a really good reason to change the bindings.

There is a race where the system can sometimes hang at boot with the
existing implementation & bindings.
This seems like a really good reason to change the bindings, if the
proposed solution is acceptable (it may be possible to fix the hang
without changing the bindings).

> Apart from that we would need to find a solution which works with the old (and wrong bindings) as well.

Why do we need to support the old bindings?
This patch fixes a problem in MT8173, for which the mainline kernel is
still under active bringup.
If the existing bindings are not used anywhere yet (*), it seems like
unnecessary overhead to enforce backwards compatibility at this stage.

(*) I don't actually know if this is true, perhaps only Mediatek can
answer this.

> Apart from that, please send the dtsi part as a seperate patch.

Agreed.

Thanks,
-Dan

>
> Thanks,
> Matthias
>
>
>> Regards,
>> Lucas
