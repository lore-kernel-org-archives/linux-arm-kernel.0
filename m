From: liwei213@huawei.com (liwei (CM))
Date: Fri, 1 Dec 2017 03:17:11 +0000
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCB2NSAyLzVdIGR0LWJpbmRpbmdzOiBz?=
 =?utf-8?Q?csi:_ufs:_add_document_for_hisi-ufs?=
References: <20171020085259.8093-1-liwei213@huawei.com>
 <20171020085259.8093-3-liwei213@huawei.com>
 <CAK8P3a0z_q-GNc-vSPbovu8yrEQyCGDccoDe16rycW+uOwO4Dw@mail.gmail.com>
 <1699CE87DE933F49876AD744B5DC140FA321D1@DGGEMM506-MBX.china.huawei.com>
 <CAK8P3a37yYDQZpZxmunCdSO83qkqywTME5Xo0k56nWEs2k+=dg@mail.gmail.com>
Message-ID: <1699CE87DE933F49876AD744B5DC140FA4637F@DGGEMM506-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd
Sorry to bother you, some questions about this patch will trouble you to give some advice:
+	ufs: ufs at ff3b0000 {
+		compatible = "hisilicon,hi3660-ufs", "jedec,ufs-1.1";
+		/* 0: HCI standard */
+		/* 1: UFS SYS CTRL */
+		reg = <0x0 0xff3b0000 0x0 0x1000>,
+			<0x0 0xff3b1000 0x0 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
+			<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
+		clock-names = "clk_ref", "clk_phy";
+		freq-table-hz = <0 0>, <0 0>;
+		/* offset: 0x84; bit: 12 */
+		/* offset: 0x84; bit: 7  */
+		resets = <&crg_rst 0x84 12>,
+			<&crg_rst 0x84 7>;
+		reset-names = "rst", "assert";
+	};

1. our UFS host soc implementation can be divided into two parts: UFS controller and related peripheral circuit, that "HCI standard"<-> UFS controller,  "UFS SYS CTRL"<-> related peripheral circuit, and PHY is part of the peripheral circuit. So the "UFS SYS CTRL" area does not correspond completely to what Qualcomm have described as their PHY implementation. In fact, we do not have an independent register space to control the PHY. 

2. From our soc chip colleague, "rst", "assert" is not generic and related with our soc implementation. In fact?it is not just a rst and assert of the UFS controller, but for the entire UFS IP ,so I don't think it's very helpful for others.

I think the above places will be reserved, do you have any better advices.

Thank you very much.


-----????-----
???: liwei (CM) 
????: 2017?10?31? 20:35
???: 'Arnd Bergmann'
??: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; Vinayak Holikatti; James E.J. Bottomley; Martin K. Petersen; Kevin Hilman; Gregory CLEMENT; Thomas Petazzoni; Masahiro Yamada; Riku Voipio; Thierry Reding; Krzysztof Kozlowski; Eric Anholt; DTML; Linux Kernel Mailing List; Linux ARM; linux-scsi; Guodong Xu; Fengbaopeng (kevin, Kirin Solution Dept); lihuan (Z); wangyupeng (A); zangleigang
??: ??: ??: [PATCH v5 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

Hi, Arnd
Thank you for your reply.
-----????-----
???: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] ?? Arnd Bergmann
????: 2017?10?30? 23:22
???: liwei (CM)
??: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; Vinayak Holikatti; James E.J. Bottomley; Martin K. Petersen; Kevin Hilman; Gregory CLEMENT; Thomas Petazzoni; Masahiro Yamada; Riku Voipio; Thierry Reding; Krzysztof Kozlowski; Eric Anholt; DTML; Linux Kernel Mailing List; Linux ARM; linux-scsi; Guodong Xu; Fengbaopeng (kevin, Kirin Solution Dept); lihuan (Z); wangyupeng (A)
??: Re: ??: [PATCH v5 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

On Tue, Oct 24, 2017 at 11:06 AM, liwei (CM) <liwei213@huawei.com> wrote:
> what's your opinion about my explanation and revision method?
> I am looking forward to your reply, thanks!

Sorry for the delay, I was travelling last week.
> ???: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] ?? Arnd 
> Bergmann On Fri, Oct 20, 2017 at 10:52 AM, Li Wei <liwei213@huawei.com> wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>> @@ -0,0 +1,46 @@
>> +* Hisilicon Universal Flash Storage (UFS) Host Controller
>> +
>> +UFS nodes are defined to describe on-chip UFS hardware macro.
>> +Each UFS Host Controller should have its own node.
>> +
>> +Required properties:
>> +- compatible        : compatible list, contains one of the following -
>> +                       "hisilicon,hi3660-ufs" for hisi ufs host controller
>> +                        present on Hi3660 chipset.

One more thing I just noticed: you don't describe the device as compatible with the ufshcd spec as defined in the generic binding. Shouldn't we have both compatible strings listed here?

Ok, I will fix it in patch v6;

> In particular, I wonder if what you describe as the "UFS SYS CTRL"
> area corresponds to what Qualcomm have described as their PHY implementation. It certainly seems to driver some of the properties that would normally be associated with a PHY.
>
> Liwei:Yes, a part of "UFS SYS CTRL" is associated with a PHY, but from our chip colleague that we assure "UFS SYS CTRL" is associated with clk/reset/power on/power off and so on.
> In fact, in addition to the controller itself, the controller related periphery are all in this area. So it's not appropriate to put this into a separate phy node.

I'm not sure I understand here. Do you mean the reset handle is for resetting the PHY rather than the UFS HCD?

Maybe my description is not clear enough, our UFS host soc implementation can be divided into two parts: UFS controller and related peripheral circuit, that "HCI standard"<-> UFS controller,  "UFS SYS CTRL"<-> related peripheral circuit, and PHY is part of the peripheral circuit. So the "UFS SYS CTRL" area does not correspond completely to what Qualcomm have described as their PHY implementation.
The root reason is that our UFS host had not divided into UFS controller and PHY?


> > For the "clock-names" property, you specify "clk_ref", which I assume is the same as what Qualcomm call "ref_clk". I'd suggest you use the existing name and add that as the default name in the ufshcd-pltfrm.txt binding document.
>
> Liwei:" ref_clk " is already in the ufshcd-pltfrm.txt binding 
> document, and parse in ufshcd.c, so we will replace "clk_ref" with 
> "ref_clk". I will fix it in patch v6;

ok

> > The "clk_phy" property appears to be related to the PHY, so it might be better to have a separate phy node with either just the clk, or with the clk plus the "UFS SYS CTRL" register area, whichever matches your hardware better, and then use teh "phys/phy-names" property to refer to that.
>
> Liwei: OK, I will add a separate phy node and fix it in patch v6;

Thanks.

>> The reset handling you describe here (both resets and reset-gpios) appears to be completely generic, so I'd suggest adding those to ufshcd-pltfrm.txt instead of your own binding, to ensure that future drivers use the same identifiers.
>
> Liwei: From our soc chip colleague, reset include "rst", "assert" is 
> not generic and related with our soc implementation, you can see
> ufs_hisi_soc_init() in drivers/scsi/ufs/ufs-hisi.c, the position of 
> rst and assert is very special, it's hard to put it in a generic 
> process;

It seems odd that the ability to reset a device is specific to your implementation. What I meant is that other implementations may also require a reset, so describing the way you refer to this into the generic binding would be helpful, to prevent others from adding another incompatible way to do the same thing.

A lot of generic bindings have a reference to a reset controller that if present needs to be used before first accessing the device itself.

I mean our reset process is really special, but there is no parse of this "reset" in generic driver code like ufshcd.c or ufshcd-pltfrm.c; Even if I add those to ufshcd-pltfrm.txt and implement the common parsing code, but our special requirements are difficult to satisfy; What do you think about if I put all the implementations of reset in our driver code, and remove "reset" property here?

> reset-gpios is used to solve a defect of the SOC chip reset function 
> and it is not generic , but our chip has been updated, so this is no 
> longer needed, and I will remove it in the patch v6;

Ok.

      Arnd
