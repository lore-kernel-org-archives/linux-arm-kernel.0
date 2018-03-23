From: liwei213@huawei.com (liwei (CM))
Date: Fri, 23 Mar 2018 02:22:33 +0000
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjggMi81XSBkdC1iaW5kaW5nczogc2NzaTogdWZz?=
 =?utf-8?Q?:_add_document_for_hisi-ufs?=
In-Reply-To: <CAK8P3a2b3rLHyM+vMppCkAR3VYbhw-b0LpuWfLCqjs7z9n+hyw@mail.gmail.com>
References: <20180213101412.5717-1-liwei213@huawei.com>
 <20180213101412.5717-3-liwei213@huawei.com>
 <CAK8P3a2b3rLHyM+vMppCkAR3VYbhw-b0LpuWfLCqjs7z9n+hyw@mail.gmail.com>
Message-ID: <1699CE87DE933F49876AD744B5DC140FA584ED@DGGEMM506-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd
Sorry to bother you again, please take the time to review the patch. Are there any other suggestions?
Looking forward to your reply.

-----????-----
???: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] ?? Arnd Bergmann
????: 2018?2?19? 17:58
???: liwei (CM)
??: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; Vinayak Holikatti; James E.J. Bottomley; Martin K. Petersen; Kevin Hilman; Gregory CLEMENT; Thomas Petazzoni; Masahiro Yamada; Riku Voipio; Thierry Reding; Krzysztof Kozlowski; Eric Anholt; DTML; Linux Kernel Mailing List; Linux ARM; linux-scsi; zangleigang; Gengjianfeng; Guodong Xu; Zhangfei Gao; Fengbaopeng (kevin, Kirin Solution Dept)
??: Re: [PATCH v8 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

On Tue, Feb 13, 2018 at 11:14 AM, Li Wei <liwei213@huawei.com> wrote:
> add ufs node document for Hisilicon.
>
> Signed-off-by: Li Wei <liwei213@huawei.com>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 37 
> ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt


I'm pretty sure we've discussed it before, but can you make this so that the generic properties are part of the ufshcd binding, and you refer to it from here, only describing in what ways the hisi ufs binding differs from the standard?

> diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt 
> b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> new file mode 100644
> index 000000000000..0d21b57496cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> @@ -0,0 +1,37 @@
> +* Hisilicon Universal Flash Storage (UFS) Host Controller
> +
> +UFS nodes are defined to describe on-chip UFS hardware macro.
> +Each UFS Host Controller should have its own node.
> +
> +Required properties:
> +- compatible        : compatible list, contains one of the following -
> +                                       "hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
> +                                       host controller present on Hi36xx chipset.
> +- reg               : should contain UFS register address space & UFS SYS CTRL register address,
> +- interrupt-parent  : interrupt device
> +- interrupts        : interrupt number
> +- clocks               : List of phandle and clock specifier pairs
> +- clock-names       : List of clock input name strings sorted in the same
> +                                       order as the clocks property. 
> +"ref_clk", "phy_clk" is optional

The clock names sound generic enough, should we have both in the generic binding?

Do you mean that add a "phy_clk" to ufshcd-pltfrm 's bindings? 
At present, it seems that in the implementation of generic code, apart from "ref_clk" may have special processing, other clk will not have special processing and simply parse and enable;
Referring to ufs-qcom binding, I think "phy_clk" can be named "iface_clk", this "iface_clk" exists in ufshcd-pltfrm bindings;If so, "ref_clk", "iface_clk" are both in the generic binding,we will remove them here. Is that okay?

> +- resets            : reset node register, one reset the clk and the other reset the controller
> +- reset-names       : describe reset node register

This looks incomplete. What is the name of the reset line supposed to be?
I'd also suggest you document it in the ufshcd binding instead.

The "rst" corresponds to reset the whole UFS IP, and " arst " only reset the APB/AXI bus. Discussed with our soc colleagues that "arst" is assert by default and needs to deassert .
But I think it may be difficult to add this to common code, or it may not be necessary; 
Other manufacturers may not need to do this soc init because they probably already done in the bootloader phase. Even if they need to do it, it's probably different from us.
We need to make sure that our ufs works even if not do soc init during the bootloader phase.




      Arnd
