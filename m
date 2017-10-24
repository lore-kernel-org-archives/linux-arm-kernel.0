From: liwei213@huawei.com (liwei (CM))
Date: Tue, 24 Oct 2017 09:06:11 +0000
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjUgMi81XSBkdC1iaW5kaW5nczogc2NzaTogdWZz?=
 =?utf-8?Q?:_add_document_for_hisi-ufs?=
References: <20171020085259.8093-1-liwei213@huawei.com>
 <20171020085259.8093-3-liwei213@huawei.com>
 <CAK8P3a0z_q-GNc-vSPbovu8yrEQyCGDccoDe16rycW+uOwO4Dw@mail.gmail.com>
Message-ID: <1699CE87DE933F49876AD744B5DC140FA321D1@DGGEMM506-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd
Sorry to bother you, what's your opinion about my explanation and revision method?
I am looking forward to your reply, thanks!


-----????-----
???: liwei (CM) 
????: 2017?10?21? 17:59
???: 'Arnd Bergmann'
??: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; Vinayak Holikatti; James E.J. Bottomley; Martin K. Petersen; Kevin Hilman; Gregory CLEMENT; Thomas Petazzoni; Masahiro Yamada; Riku Voipio; Thierry Reding; Krzysztof Kozlowski; Eric Anholt; DTML; Linux Kernel Mailing List; Linux ARM; linux-scsi; Guodong Xu; Fengbaopeng (kevin, Kirin Solution Dept); lihuan (Z); wangyupeng (A)
??: ??: [PATCH v5 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

Hi, Bergmann
Sorry late for the reply,and thank you very much for your patience.
My reply is as follows. I look forward to your further reply.


-----????-----
???: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] ?? Arnd Bergmann
????: 2017?10?20? 17:16
???: liwei (CM)
??: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; Vinayak Holikatti; James E.J. Bottomley; Martin K. Petersen; Kevin Hilman; Gregory CLEMENT; Thomas Petazzoni; Masahiro Yamada; Riku Voipio; Thierry Reding; Krzysztof Kozlowski; Eric Anholt; DTML; Linux Kernel Mailing List; Linux ARM; linux-scsi; Guodong Xu; Fengbaopeng (kevin, Kirin Solution Dept); lihuan (Z); wangyupeng (A)
??: Re: [PATCH v5 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

On Fri, Oct 20, 2017 at 10:52 AM, Li Wei <liwei213@huawei.com> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> @@ -0,0 +1,46 @@
> +* Hisilicon Universal Flash Storage (UFS) Host Controller
> +
> +UFS nodes are defined to describe on-chip UFS hardware macro.
> +Each UFS Host Controller should have its own node.
> +
> +Required properties:
> +- compatible        : compatible list, contains one of the following -
> +                       "hisilicon,hi3660-ufs" for hisi ufs host controller
> +                        present on Hi3660 chipset.
> +- reg               : should contain UFS register address space & UFS SYS CTRL register address,
> +- interrupt-parent  : interrupt device
> +- interrupts        : interrupt number
> +- clocks               : List of phandle and clock specifier pairs
> +- clock-names       : List of clock input name strings sorted in the same
> +                     order as the clocks property. "clk_ref", "clk_phy" is optional
> +- resets            : reset node register, one reset the clk and the other reset the controller
> +- reset-names       : describe reset node register

I think I've asked about this before, but I think this should be done more consistently with the other UFS bindings.

In particular, I wonder if what you describe as the "UFS SYS CTRL"
area corresponds to what Qualcomm have described as their PHY implementation. It certainly seems to driver some of the properties that would normally be associated with a PHY.

Liwei:Yes, a part of "UFS SYS CTRL" is associated with a PHY, but from our chip colleague that we assure "UFS SYS CTRL" is associated with clk/reset/power on/power off and so on. 
In fact, in addition to the controller itself, the controller related periphery are all in this area. So it's not appropriate to put this into a separate phy node.

For the "clock-names" property, you specify "clk_ref", which I assume is the same as what Qualcomm call "ref_clk". I'd suggest you use the existing name and add that as the default name in the ufshcd-pltfrm.txt binding document.

Liwei:" ref_clk " is already in the ufshcd-pltfrm.txt binding document, and parse in ufshcd.c, so we will replace "clk_ref" with "ref_clk". I will fix it in patch v6;

The "clk_phy" property appears to be related to the PHY, so it might be better to have a separate phy node with either just the clk, or with the clk plus the "UFS SYS CTRL" register area, whichever matches your hardware better, and then use teh "phys/phy-names" property to refer to that.

Liwei: OK, I will add a separate phy node and fix it in patch v6;

The reset handling you describe here (both resets and reset-gpios) appears to be completely generic, so I'd suggest adding those to ufshcd-pltfrm.txt instead of your own binding, to ensure that future drivers use the same identifiers.

Liwei: From our soc chip colleague, reset include "rst", "assert" is not generic and related with our soc implementation, you can see ufs_hisi_soc_init() in drivers/scsi/ufs/ufs-hisi.c, the position of rst and assert is very special, it's hard to put it in a generic process; reset-gpios is used to solve a defect of the SOC chip reset function and it is not generic , but our chip has been updated, so this is no longer needed, and I will remove it in the patch v6;

Thanks!

      Arnd
