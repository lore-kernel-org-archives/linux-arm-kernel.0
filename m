From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Sep 2010 13:55:07 +0900
Subject: [PATCH v2] ARM: MM: bugfix: initialize spinlock for
	init_mm.context
In-Reply-To: <1285635990-3036-1-git-send-email-myungjoo.ham@samsung.com>
References: <1285635990-3036-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <004401cb5ec9$55032ce0$ff0986a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> init_mm used at kernel/sched.c:idle_task_exit() has spin_lock
> (init_mm.context.id_lock) that is not initialized when spin_lock/unlock
> is called at an ARM machine. Note that mm_struct.context.id_lock is
usually
> initialized except for the instance of init_mm at
linux/arch/arm/mm/context.c
> 
> Not initializing this spinlock incurs "BUG: pinlock bad magic" warning
when

spinlock?

> spinlock debug is enabled. We have observed such instances when testing PM
in
> S5PC210 machines.
> 
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> --
> changes
> 	v2: fixed incorrect initializer parameter (list_lock -> id_lock)
> ---
>  arch/arm/include/asm/mmu.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
> index 68870c7..c18540b 100644
> --- a/arch/arm/include/asm/mmu.h
> +++ b/arch/arm/include/asm/mmu.h
> @@ -13,6 +13,10 @@ typedef struct {
> 
>  #ifdef CONFIG_CPU_HAS_ASID
>  #define ASID(mm)	((mm)->context.id & 255)
> +
> +/* init_mm.context.id_lock should be initialized. */
> +#define INIT_MM_CONTEXT(name)
> \
> +	.context.id_lock    = __SPIN_LOCK_UNLOCKED(name.context.id_lock),
>  #else
>  #define ASID(mm)	(0)
>  #endif
> --

Also, happened following warning without this patch when hotplug.

[root at Samsung ~]# echo 0 > /sys/devices/system/cpu/cpu1/online
BUG: spinlock bad magic on CPU#1, swapper/0
 lock: 802fee10, .magic: 00000000, .owner: swapper/0, .owner_cpu: 1
[<8002e250>] (unwind_backtrace+0x0/0xec) from [<80163038>]
(do_raw_spin_unlock+0x20/0xc0)
[<80163038>] (do_raw_spin_unlock+0x20/0xc0) from [<80219420>]
(_raw_spin_unlock_irqrestore+0xc/0x38)
[<80219420>] (_raw_spin_unlock_irqrestore+0xc/0x38) from [<800319a8>]
(set_mm_context+0x94/0xb4)
[<800319a8>] (set_mm_context+0x94/0xb4) from [<80031ac4>]
(__new_context+0x9c/0xb4)
[<80031ac4>] (__new_context+0x9c/0xb4) from [<800443dc>]
(idle_task_exit+0xe0/0x140)
[<800443dc>] (idle_task_exit+0xe0/0x140) from [<80211dd8>]
(cpu_die+0x14/0x44)
[<80211dd8>] (cpu_die+0x14/0x44) from [<80029878>] (cpu_idle+0x54/0xd0)
[<80029878>] (cpu_idle+0x54/0xd0) from [<40008080>] (0x40008080)
CPU1: shutdown
[root at Samsung ~]# OK

In my opinion, this stuff should be sent to Russell's tree with Catalin's
ack.

Catalin, is still valid your ack?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
