From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 12 May 2015 10:37:13 +0100
Subject: [PATCH] arm: Don't use memblock limit for the lowmem bound
In-Reply-To: <1431399221-25337-1-git-send-email-labbott@fedoraproject.org>
References: <1431399221-25337-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <20150512093713.GB16907@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 03:53:41AM +0100, Laura Abbott wrote:
> From: Laura Abbott <labbott@redhat.com>
> 
> The memblock limit is currently used in find_limits
> to find the bounds for ZONE_NORMAL. The memblock
> limit may need to be rounded down a PMD size to ensure
> allocations are fully mapped though. This has the side
> effect of reducing the amount of memory in ZONE_NORMAL.
> Since we generally want to optimize for more lowmem, fix
> this by using arm_lowmem_limit to calculate the bounds.
> This what is used for actually mapping lowmem anyway.
> 
> Before:
> # cat /proc/zoneinfo | grep managed
>         managed  62920
> 
> After:
> # cat /proc/zoneinfo | grep managed
>         managed  63336
> 
> 
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

I just gave this a spin on TC2, with the memory node hacked to provide
0x3ffffc00 bytes of RAM.

Before:
Memory: 1030380K/1046528K available (4828K kernel code, 154K rwdata, 1376K rodata, 264K init, 147K bss, 16148K reserved, 0K cma-reserved)
$ cat /proc/zoneinfo | grep managed
        managed  257661

After:
Memory: 1032424K/1048572K available (4828K kernel code, 154K rwdata, 1376K rodata, 264K init, 147K bss, 16148K reserved, 0K cma-reserved)
$ cat /proc/zoneinfo | grep managed
        managed  258172

The patch itself looks sane to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index be92fa0..b4f9513 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -89,7 +89,7 @@ __tagtable(ATAG_INITRD2, parse_tag_initrd2);
>  static void __init find_limits(unsigned long *min, unsigned long *max_low,
>  			       unsigned long *max_high)
>  {
> -	*max_low = PFN_DOWN(memblock_get_current_limit());
> +	*max_low = PFN_DOWN(arm_lowmem_limit);
>  	*min = PFN_UP(memblock_start_of_DRAM());
>  	*max_high = PFN_DOWN(memblock_end_of_DRAM());
>  }
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
