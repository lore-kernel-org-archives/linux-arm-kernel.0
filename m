From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 May 2015 10:33:35 +0900
Subject: [PATCH v2] clocksource: exynos_mct: fix for sleeping in atomic
 ctx handling cpu hotplug notif.
In-Reply-To: <1426151496-5509-1-git-send-email-d.eppel@samsung.com>
References: <1426151496-5509-1-git-send-email-d.eppel@samsung.com>
Message-ID: <CAJKOXPcXk+xiYUoy6QnfRC2bPsNpTqLYp6-0X1xgCvZ4s5nGGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-12 18:11 GMT+09:00 Damian Eppel <d.eppel@samsung.com>:
> This is to fix an issue of sleeping in atomic context when processing
> hotplug notifications in Exynos MCT(Multi-Core Timer).
> The issue was reproducible on Exynos 3250 (Rinato board) and Exynos 5420
> (Arndale Octa board).
>
> Whilst testing cpu hotplug events on kernel configured with DEBUG_PREEMPT
> and DEBUG_ATOMIC_SLEEP we get following BUG message, caused by calling
> request_irq() and free_irq() in the context of hotplug notification
> (which is in this case atomic context).
>
> root at target:~# echo 0 > /sys/devices/system/cpu/cpu1/online
>
> [   25.157867] IRQ18 no longer affine to CPU1
> ...
> [   25.158445] CPU1: shutdown
>
> root at target:~# echo 1 > /sys/devices/system/cpu/cpu1/online
>
> [   40.785859] CPU1: Software reset
> [   40.786660] BUG: sleeping function called from invalid context at mm/slub.c:1241
> [   40.786668] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/1
> [   40.786678] Preemption disabled at:[<  (null)>]   (null)
> [   40.786681]
> [   40.786692] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.19.0-rc4-00024-g7dca860 #36
> [   40.786698] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   40.786728] [<c0014a00>] (unwind_backtrace) from [<c0011980>] (show_stack+0x10/0x14)
> [   40.786747] [<c0011980>] (show_stack) from [<c0449ba0>] (dump_stack+0x70/0xbc)
> [   40.786767] [<c0449ba0>] (dump_stack) from [<c00c6124>] (kmem_cache_alloc+0xd8/0x170)
> [   40.786785] [<c00c6124>] (kmem_cache_alloc) from [<c005d6f8>] (request_threaded_irq+0x64/0x128)
> [   40.786804] [<c005d6f8>] (request_threaded_irq) from [<c0350b8c>] (exynos4_local_timer_setup+0xc0/0x13c)
> [   40.786820] [<c0350b8c>] (exynos4_local_timer_setup) from [<c0350ca8>] (exynos4_mct_cpu_notify+0x30/0xa8)
> [   40.786838] [<c0350ca8>] (exynos4_mct_cpu_notify) from [<c003b330>] (notifier_call_chain+0x44/0x84)
> [   40.786857] [<c003b330>] (notifier_call_chain) from [<c0022fd4>] (__cpu_notify+0x28/0x44)
> [   40.786873] [<c0022fd4>] (__cpu_notify) from [<c0013714>] (secondary_start_kernel+0xec/0x150)
> [   40.786886] [<c0013714>] (secondary_start_kernel) from [<40008764>] (0x40008764)
>
> Solution:
> Clockevent irqs cannot be requested/freed every time cpu is
> hot-plugged/unplugged as CPU_STARTING/CPU_DYING notifications
> that signals hotplug or unplug events are sent with both preemption
> and local interrupts disabled. Since request_irq() may sleep it is
> moved to the initialization stage and performed for all possible
> cpus prior putting them online. Then, in the case of hotplug event
> the irq asociated with the given cpu will simply be enabled.
> Similarly on cpu unplug event the interrupt is not freed but just
> disabled.
>
> Note that after successful request_irq() call for a clockevent device
> associated to given cpu the requested irq is disabled (via disable_irq()).
> That is to make things symmetric as we expect hotplug event as a next
> thing (which will enable irq again). This should not pose any problems
> because at the time of requesting irq the clockevent device is not
> fully initialized yet, therefore should not produce interrupts at that point.
>
> For disabling an irq at cpu unplug notification disable_irq_nosync() is
> chosen which is a non-blocking function. This again shouldn't be a problem as
> prior sending CPU_DYING notification interrupts are migrated away
> from the cpu.
>
> Fixes: 7114cd749a12 ("clocksource: exynos_mct: use (request/free)_irq calls for local timer registration")
> Signed-off-by: Damian Eppel <d.eppel@samsung.com>
> Cc: <stable@vger.kernel.org>
> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> (Tested on Arndale Octa Board)
> Tested-by: Marcin Jabrzyk <m.jabrzyk@samsung.com>
> (Tested on Rinato B2 (Exynos 3250) board)

Hi Daniel and Thomas,

Do you have any comments on this patch? Could you pick it up?

Best regards,
Krzysztof
