From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 01 Apr 2014 12:43:21 +0200
Subject: exynos4: cpu hotplug + cpuidle/AFTR broken
Message-ID: <533A9849.1080402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all,

I tried the v3.14 kernel and unplugged the cpu1. That leads to a kernel 
hang without any trace.

If I disable the cpuidle AFTR state through sysfs before unplugging 
cpu1, it works well.

I reproduced the issue on v3.14, v3.13, v3.12, v3.11

v3.10 works fine.

I tried to git bisect but I finally gave up due to too much kernel 
hanging at boot.

The git bisect log below.

Thanks
   -- Daniel


git bisect start
# bad: [6e4664525b1db28f8c4e1130957f70a94c19213e] Linux 3.11
git bisect bad 6e4664525b1db28f8c4e1130957f70a94c19213e
# good: [8bb495e3f02401ee6f76d1b1d77f3ac9f079e376] Linux 3.10
git bisect good 8bb495e3f02401ee6f76d1b1d77f3ac9f079e376
# good: [8b70a90cabafb6a6e1a0d3f838b38355fe48337e] Merge branch 
'for-v3.11' of git://git.linaro.org/people/mszyprowski/linux-dma-mapping
git bisect good 8b70a90cabafb6a6e1a0d3f838b38355fe48337e
# bad: [b41e6a51d57e231d2ed237f17f002cc536c0987c] sh_eth: SH_ETH should 
depend on HAS_DMA
git bisect bad b41e6a51d57e231d2ed237f17f002cc536c0987c
# bad: [2e17c5a97e231f3cb426f4b7895eab5be5c5442e] Merge branch 
'drm-next' of git://people.freedesktop.org/~airlied/linux
git bisect bad 2e17c5a97e231f3cb426f4b7895eab5be5c5442e
# good: [e631227f698f39969eb476d297f3ac65b43b51a5] drm/radeon: fix 
endian bug in radeon_atom_get_mclk_range_table()
git bisect good e631227f698f39969eb476d297f3ac65b43b51a5
# bad: [9a5889ae1ce41f376e6a5b56e17e0c5a755fda80] Merge branch 
'for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client
git bisect bad 9a5889ae1ce41f376e6a5b56e17e0c5a755fda80
# bad: [be0c5d8c0bb0023e11f5c6d38e90f7b0f24edb64] Merge tag 
'nfs-for-3.11-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
git bisect bad be0c5d8c0bb0023e11f5c6d38e90f7b0f24edb64
# bad: [d2b4a646717153a1a180b64d4a8464054dbd700e] Merge branch 
'for-linus' of git://git.infradead.org/users/vkoul/slave-dma
git bisect bad d2b4a646717153a1a180b64d4a8464054dbd700e
# skip: [07bd1172902e782f288e4d44b1fde7dec0f08b6f] tick: Sanitize 
broadcast control logic
git bisect skip 07bd1172902e782f288e4d44b1fde7dec0f08b6f
# good: [757f4e51b74f7fb19251020e742a78111fdea194] MIPS: jz4740: Correct 
clock gate bit for DMA controller
git bisect good 757f4e51b74f7fb19251020e742a78111fdea194
# skip: [064706514ec3fea740c2656e03c4f01f6a551ac4] clocksource: Add 
generic dummy timer driver
git bisect skip 064706514ec3fea740c2656e03c4f01f6a551ac4
# skip: [55a68c23e0a675b2b8ac2656fd6edbf98b78e4c6] dw_apb_timer_of.c: 
Remove parts that were picoxcell-specific
git bisect skip 55a68c23e0a675b2b8ac2656fd6edbf98b78e4c6
# skip: [fc1f7d5606487ae28d6c84e95401952927d7379e] clocksource: 
apb_timer: Remove unsused function
git bisect skip fc1f7d5606487ae28d6c84e95401952927d7379e
# skip: [6cffe00f7d4e24679eae6b7aae4caaf915288256] alarmtimer: Add 
functions for timerfd support
git bisect skip 6cffe00f7d4e24679eae6b7aae4caaf915288256
# good: [e24f6628811e2d4531b443684b598f7050932012] modpost: remove all 
traces of cpuinit/cpuexit sections
git bisect good e24f6628811e2d4531b443684b598f7050932012
# skip: [629a6a2b7762a474177d08043bea094dd27e0a54] sched_clock: Add 
temporary asm/sched_clock.h
git bisect skip 629a6a2b7762a474177d08043bea094dd27e0a54
# skip: [5c83545f24ab3dd67e0ae0e2b795fea750f08c34] power: Add option to 
log time spent in suspend
git bisect skip 5c83545f24ab3dd67e0ae0e2b795fea750f08c34
# good: [2473f3e7a97ce8bc0fe7596cdb361b21221418eb] posix_cpu_timers: 
consolidate expired timers check
git bisect good 2473f3e7a97ce8bc0fe7596cdb361b21221418eb
# skip: [336ae1180df5f69b9e0fb6561bec01c5f64361cf] ARM: sched_clock: 
Load cycle count after epoch stabilizes
git bisect skip 336ae1180df5f69b9e0fb6561bec01c5f64361cf
# skip: [f5a2e34375a5e2b711aea488ac3ae50eeba6d57c] clocksource: Allow 
clocksource select to skip current clocksource
git bisect skip f5a2e34375a5e2b711aea488ac3ae50eeba6d57c
# skip: [ce0b098981544d9f4e910ea48f3af3e726ca6d6b] x86: Fix 
vrtc_get_time/set_mmss to use new timespec interface
git bisect skip ce0b098981544d9f4e910ea48f3af3e726ca6d6b
# skip: [d0951a23383d09276f7976ed34d8f1cede629b48] DMA: shdma: 
shdma_chan_filter() has to be in shdma-base.h
git bisect skip d0951a23383d09276f7976ed34d8f1cede629b48
# skip: [7c4c3a0f18ba57ea2a2985034532303d2929902a] hrtimers: Support 
resuming with two or more CPUs online (but stopped)
git bisect skip 7c4c3a0f18ba57ea2a2985034532303d2929902a
# skip: [a89c7edbe7d7aa80f507915f3dd801211b116b79] clocksource: Let 
clocksource_unregister() return success/error
git bisect skip a89c7edbe7d7aa80f507915f3dd801211b116b79
# skip: [2699339361a9bacb3fa663e6b8981a040cfca4ee] clocksource: 
vf_pit_timer: Use linux/sched_clock.h
git bisect skip 2699339361a9bacb3fa663e6b8981a040cfca4ee
# skip: [7172a286ced0c1f4f239a0fa09db54ed37d3ead2] clockevents: Get rid 
of the notifier chain
git bisect skip 7172a286ced0c1f4f239a0fa09db54ed37d3ead2
# skip: [762cf9695d714d312ef7369bed1b9f9467c9e64e] Merge branch 
'timers/clockevents' of git://git.linaro.org/people/dlezcano/clockevents 
into timers/core
git bisect skip 762cf9695d714d312ef7369bed1b9f9467c9e64e
# bad: [21884a83b2192a00885d7244a1dda32debd2fbc7] Merge branch 
'timers-core-for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 21884a83b2192a00885d7244a1dda32debd2fbc7
# skip: [5a9b5855c248d0298eac4d5490c7bc11c2f1983b] ARM: sched_clock: 
Remove unused needs_suspend member
git bisect skip 5a9b5855c248d0298eac4d5490c7bc11c2f1983b
# skip: [45cb8e01b2ecef1c2afb18333e95793fa1a90281] clockevents: Split 
out selection logic
git bisect skip 45cb8e01b2ecef1c2afb18333e95793fa1a90281
# skip: [ffbfb5e316f0db486798ccf1db36a577ffe79637] ARM: sched_clock: 
Return suspended count earlier
git bisect skip ffbfb5e316f0db486798ccf1db36a577ffe79637
# skip: [04397fe94ad65289884b9862b6a0c722ececaadf] timekeeping: Pass 
flags instead of multiple bools to timekeeping_update()
git bisect skip 04397fe94ad65289884b9862b6a0c722ececaadf
# skip: [11682a41618f8094cb7a9330b4b6a12ffaef5774] alarmtimer: Export 
symbols of functions declared in linux/alarmtimer.h
git bisect skip 11682a41618f8094cb7a9330b4b6a12ffaef5774
# skip: [fc1f7d5606487ae28d6c84e95401952927d7379e] clocksource: 
apb_timer: Remove unsused function
git bisect skip fc1f7d5606487ae28d6c84e95401952927d7379e


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
