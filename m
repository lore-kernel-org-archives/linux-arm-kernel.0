From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 10 Jun 2017 10:49:36 +0100
Subject: [PATCH] clocksource: fix read and iounmap of incorrect variable
In-Reply-To: <1497054392-13783-1-git-send-email-frowand.list@gmail.com>
 (frowand list's message of "Fri, 9 Jun 2017 17:26:32 -0700")
References: <1497054392-13783-1-git-send-email-frowand.list@gmail.com>
Message-ID: <87r2ysgojz.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09 2017 at  5:26:32 pm BST, frowand.list at gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
>
> Fix boot warning 'Trying to vfree() nonexistent vm area'
> from arch_timer_mem_of_init().
>
> Refactored code attempts to read and iounmap using address frame
> instead of address ioremap(frame->cntbase).
>
> Fixes: c389d701dfb70 ("clocksource: arm_arch_timer: split MMIO timer probing.")
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>
> WARNING: CPU: 0 PID: 0 at mm/vmalloc.c:1514 iounmap+0x14/0x18
> Trying to vfree() nonexistent vm area (ee821000)
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.12.0-rc1-dirty #1
> Hardware name: Generic DT based system
> [<c030f574>] (unwind_backtrace) from [<c030b8e0>] (show_stack+0x10/0x14)
> [<c030b8e0>] (show_stack) from [<c05f5204>] (dump_stack+0x6c/0x8c)
> [<c05f5204>] (dump_stack) from [<c031dcdc>] (__warn+0xd0/0xf8)
> [<c031dcdc>] (__warn) from [<c031ddac>] (warn_slowpath_fmt+0x38/0x48)
> [<c031ddac>] (warn_slowpath_fmt) from [<c0315e78>] (iounmap+0x14/0x18)
> [<c0315e78>] (iounmap) from [<c0d36e98>] (arch_timer_mem_of_init+0x224/0x414)
> [<c0d36e98>] (arch_timer_mem_of_init) from [<c0d36868>] (clocksource_probe+0x44/0xa8)
> [<c0d36868>] (clocksource_probe) from [<c0d00ae8>] (start_kernel+0x228/0x3a0)
> [<c0d00ae8>] (start_kernel) from [<0020807c>] (0x20807c)
>
>  drivers/clocksource/arm_arch_timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 4bed671e490e..8b5c30062d99 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1209,9 +1209,9 @@ static int __init arch_timer_of_init(struct device_node *np)
>  		return 0;
>  	}
>  
> -	rate = readl_relaxed(frame + CNTFRQ);
> +	rate = readl_relaxed(base + CNTFRQ);
>  
> -	iounmap(frame);
> +	iounmap(base);
>  
>  	return rate;
>  }

Ah, nice find.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thomas, Daniel: Can you queue this for the next -rc please?

Thanks,

        M.
-- 
Jazz is not dead, it just smell funny.
