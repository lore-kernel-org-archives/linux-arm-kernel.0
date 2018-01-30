From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Jan 2018 13:48:36 +0000
Subject: [BUG] perf, arm64, acpi: sleeping function called from invalid
 context
In-Reply-To: <20180129173054.GD794@hc>
References: <20180129173054.GD794@hc>
Message-ID: <20180130134836.GC28882@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan, [+LinusW, Lee]

On Mon, Jan 29, 2018 at 06:30:54PM +0100, Jan Glauber wrote:
> I'm seeing the following warning with 4.15 (and earlier) using ACPI & perf:
> 
> [   34.823577] BUG: sleeping function called from invalid context at mm/slab.h:419
> [   34.830881] in_atomic(): 0, irqs_disabled(): 128, pid: 14, name: cpuhp/0
> [   34.837574] 1 lock held by cpuhp/0/14:
> [   34.841314]  #0:  (cpuhp_state-up){....}, at: [<00000000f44ba116>] cpuhp_thread_fun+0x148/0x290
> [   34.850032] CPU: 0 PID: 14 Comm: cpuhp/0 Not tainted 4.15.0-rc9-jang+ #13
> [   34.856810] Hardware name: Default string Cavium ThunderX2/Default string, BIOS 5.13 12/18/2017
> [   34.865499] Call trace:
> [   34.867941]  dump_backtrace+0x0/0x160
> [   34.871595]  show_stack+0x24/0x30
> [   34.874905]  dump_stack+0x9c/0xd0
> [   34.878214]  ___might_sleep+0x140/0x1a0
> [   34.882042]  __might_sleep+0x58/0x90
> [   34.885610]  kmem_cache_alloc_trace+0x2c4/0x320
> [   34.890134]  armpmu_alloc+0x38/0x1b0
> [   34.893701]  arm_pmu_acpi_cpu_starting+0x10c/0x138
> [   34.898484]  cpuhp_invoke_callback+0x120/0xaa8
> [   34.902920]  cpuhp_thread_fun+0xec/0x290
> [   34.906834]  smpboot_thread_fn+0x21c/0x2b8
> [   34.910923]  kthread+0x10c/0x138
> [   34.914143]  ret_from_fork+0x10/0x18
> 
> Changing the allocations in arm_pmu_alloc() to GFP_ATOMIC didn't help,
> as the interrupt request is also not happy in this context.
> 
> Would it be possible to init the PMUs later?

I know that Mark's had a good go at fixing this, but we ran into problems
having the fix co-exist with the IRQ bouncing workaround we perform for the
PMU on U8500 platforms. Frustratingly, those platforms don't appear to be
available any more, so we're being held up by something that we're unable
to test and might be considered dead.

Linus, Lee: do we still need to support PMU interrupts on U8500? It's
causing us real headaches with ACPI-based arm64 systems. [the answer might
be "yes", but I have to ask!]

Cheers,

Will
