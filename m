From: monstr@monstr.eu (Michal Simek)
Date: Wed, 02 Apr 2014 10:08:13 +0200
Subject: [PATCH 63/75] ARM: l2c: zynq: remove cache size override
In-Reply-To: <E1WTYZQ-0007H7-L6@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYZQ-0007H7-L6@rmk-PC.arm.linux.org.uk>
Message-ID: <533BC56D.4010600@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 03/28/2014 04:19 PM, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-zynq/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 8c09a8393fb6..b58f17178006 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -67,7 +67,7 @@ static void __init zynq_init_machine(void)
>  	/*
>  	 * 64KB way size, 8-way associativity, parity disabled
>  	 */
> -	l2x0_of_init(0x02060000, 0xF0F0FFFF);
> +	l2x0_of_init(0x02000000, 0xf0ffffff);
>  
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  

We have done one fix some days/weeks ago which is here.
https://github.com/Xilinx/linux-xlnx/commit/1a85939af40acca2bf963407b497cc31c303ff3e
(Feel free to ignore L2_PREFETCH config option)

There are 2 things there.
1. Extending macros in cache-l2x0.h which I believe can go to the mainline
(when we align with changes you have done in 49/75)
2. Set L2X0_AUX_CTRL_SHARE_OVERRIDE_EN_MASK bit  which is what vexpress did.
The reason was problem with gem driver with iperf testing.

Regarding your post about bits 19:17
> Bits 19:17 are the way size, bit 16 (for the PL310) is the associativity
> (8 or 16 ways.)  It seems many people have the impression that they have
> to set these values according to the size of the cache and they can't
> rely on the value already initialised by hardware from synthesis the
> options.

Reset values are correctly setup by bootrom to 0x02060000
That's why we can even use full mask.
For current mainline code just like this
	l2x0_of_init(0x00000000, 0xffffffff);
and we will submit the code which change this to
	l2x0_of_init(0x00400000, 0xffffffff);

Please let me know if this is aligned with your goal what you want to reach.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140402/f4056b1c/attachment.sig>
