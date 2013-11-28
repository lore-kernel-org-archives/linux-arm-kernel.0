From: nm@ti.com (Nishanth Menon)
Date: Wed, 27 Nov 2013 18:49:23 -0600
Subject: [PATCHv10 00/41] ARM: TI SoC clock DT conversion
In-Reply-To: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Message-ID: <52969313.6090207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 02:05 AM, Tero Kristo wrote:
> Hi,
> 
> Changes compared to v9:
> - rebased on top of 3.13-rc1
> - modified the low level clk register API to provide SoC specific clk_readl
>   and clk_writel support which can be registered during boot, TI SoC variant
>   uses regmap on low level
> - dropped regmap parameter from clock init calls, instead a helper is used
>   for getting regmap index along with the register offset from DT
> - dropped regmap parameter from clock structs, instead platform specific
>   clk_readl / clk_writel are used to parse reg parameter according to
>   platform, for TI SoC:s, this is encoded as:
>   struct clk_omap_reg {
>     u16 offset; /* register offset */
>     u16 index; /* regmap index */
>   }
> - Nishanth's comments to v9 mostly addressed, except for the CLK_OF_DECLARE
>   tweak which I would actually want some feedback upon, basically the problem
>   is I need to return status from the clk init functions so I can see if
>   -EAGAIN is passed, in which case init will be retried later, maybe some of
>   this can be made generic, like converting all the CLK_OF_DECLARE type
>   functions to return status
> 
> Testing done:
> - omap3-beagle : boot + suspend/resume
> - omap3-beagle-xm : boot (thanks to Nishanth)
> - omap4-panda-es : boot + suspend/resume
> - omap5-uevm : boot
> - dra7-evm : boot
> - am335x-bone : boot
> 
> Separate branches available at https://github.com/t-kristo/linux-pm.git
> 
> - full: 3.13-rc1-dt-clks-v10 (should be merged last, contains everything)

More testing (boot):
(uImage + dtb combined):
http://pastebin.mozilla.org/3681899 - AM37xx-evm
http://pastebin.mozilla.org/3681900 -> AM3517-evm (not sure yet how
long this has been broken).

zImage and dtbs: (boot tests):
http://pastebin.mozilla.org/3669889 -> omap5uevm
http://pastebin.mozilla.org/3669917 -> Panda-ES
http://pastebin.mozilla.org/3669928 -> Beagle-XM
http://pastebin.mozilla.org/3669939 -> BBBlack
http://pastebin.mozilla.org/3670104 ->AM335x-EVM

Other than these, ran a quick coccicheck
http://pastebin.mozilla.org/3682339
at least the kzalloc one seems to indicate a pending fix.

-- 
Regards,
Nishanth Menon
