From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Nov 2017 18:00:20 +0000
Subject: v4.14-rc{4,7} null pointer dereference in event_sched_out()
In-Reply-To: <20171030162314.yxi2fyli6omtphvw@lakrids.cambridge.arm.com>
References: <20171030162314.yxi2fyli6omtphvw@lakrids.cambridge.arm.com>
Message-ID: <20171115180019.GO19071@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 04:23:15PM +0000, Mark Rutland wrote:
> As a heads-up, while fuzzing arm64 v4.14-rc{4,7} with Syzkaller, I hit a
> KASAN splat in event_sched_out():
> 
> [  133.225742] ==================================================================
> [  133.229374] BUG: KASAN: null-ptr-deref in event_sched_out.isra.47+0x428/0x580
> [  133.230843] Read of size 4 at addr 0000000000000178 by task syz-executor0/6905
> [  133.233151]
> [  133.233664] CPU: 0 PID: 6905 Comm: syz-executor0 Not tainted 4.14.0-rc7-dirty #4
> [  133.235750] Hardware name: linux,dummy-virt (DT)
> [  133.236598] Call trace:
> [  133.237081] [<ffff20000808fef8>] dump_backtrace+0x0/0x658
> [  133.238073] [<ffff200008090570>] show_stack+0x20/0x30
> [  133.239002] [<ffff2000091c22ec>] dump_stack+0xd0/0x124
> [  133.239947] [<ffff200008349d1c>] kasan_report+0x104/0x310
> [  133.240940] [<ffff2000083483f8>] __asan_load4+0x58/0xb0
> [  133.242262] [<ffff200008271138>] event_sched_out.isra.47+0x428/0x580
> [  133.243686] [<ffff2000082712c8>] __perf_remove_from_context+0x38/0xe0
> [  133.244948] [<ffff200008265cf8>] event_function_call+0x1c8/0x258
> [  133.246197] [<ffff20000826ad04>] perf_remove_from_context+0x54/0xf0
> [  133.247514] [<ffff20000827f188>] SyS_perf_event_open+0x1528/0x18e0
> [  133.248831] Exception stack(0xffff800038c5fec0 to 0xffff800038c60000)
> [  133.250199] fec0: 0000000020b12f88 0000000000001af8 00000000ffffffff 0000000000000008
> [  133.251843] fee0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [  133.253503] ff00: 00000000000000f1 0000000000000000 0000000000405850 00000000003d0f00
> [  133.255132] ff20: 0000ffff94514f60 00000000004ae890 0000000000000027 0000000000000001
> [  133.256756] ff40: 0000000000000000 0000000000826000 0000000000000000 00000000004c0158
> [  133.258392] ff60: 00000000ffffffff 0000000020b12f88 0000000000001af8 000000000046d290
> [  133.260006] ff80: 00000000004aaba8 0000000000473af8 0000ffffe5360da0 0000000000000000
> [  133.261629] ffa0: 0000ffff94514f60 0000ffff94514640 00000000004020fc 0000ffff94514640
> [  133.263253] ffc0: 000000000042d034 00000000a0000000 0000000020b12f88 00000000000000f1
> [  133.264886] ffe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [  133.266535] [<ffff200008084170>] el0_svc_naked+0x24/0x28
> [  133.267648] ==================================================================
> 
> ... which is triggered by the Syzkaller repro program at the end of this
> email. I haven't yet come up with a C reproducer; sorry.
> 
> The PC seems to be the load of cpuctx->active_oncpu at the end of the
> function, so it looks like cpuctx is NULL.
> 
> The system has (homogeneous) armv8_pmuv3, breakpoint, and software PMUs.
> 
> I initially hit this on v4.14-rc4, and can reproduce the issue on
> v4.14-rc7. I haven't tried any other kernels yet.
> 
> I'll continue digging, unless someone else has already solved this.

Did you get anywhere with this?

Will
