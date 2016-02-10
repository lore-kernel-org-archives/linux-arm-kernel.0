From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 10 Feb 2016 12:57:50 +0530
Subject: lockdep: INFO: possible irq lock inversion dependency detected on
 Odroid U3
Message-ID: <CANAwSgRgFMNWGhTe7xsHqkQQ1JS0XW6pO8LT8c6rZm=3cEBcbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I am observing following lockdep info.

[  139.806823] =========================================================
[  139.811934] [ INFO: possible irq lock inversion dependency detected ]
[  139.818362] 4.5.0-rc3-u3s #11 Tainted: G        W
[  139.823566] ---------------------------------------------------------
[  139.829990] swapper/0/0 just changed the state of lock:
[  139.835197]  (&(&substream->self_group.lock)->rlock){..-...}, at:
[<c04e03cc>] _snd_pcm_stream_lock_irqsave+0x34/0x40
[  139.845788] but this lock took another, SOFTIRQ-unsafe lock in the past:
[  139.852468]  (&(&pri_dai->spinlock)->rlock){+.+...}

and interrupts could create inverse lock ordering between them.

[  139.863319]
[  139.863319] other info that might help us debug this:
[  139.869830]  Possible interrupt unsafe locking scenario:
[  139.869830]
[  139.876599]        CPU0                    CPU1
[  139.881113]        ----                    ----
[  139.885626]   lock(&(&pri_dai->spinlock)->rlock);
[  139.890314]                                local_irq_disable();
[  139.896216]
lock(&(&substream->self_group.lock)->rlock);
[  139.904201]
lock(&(&pri_dai->spinlock)->rlock);
[  139.911405]   <Interrupt>
[  139.914009]     lock(&(&substream->self_group.lock)->rlock);
[  139.919652]
[  139.919652]  *** DEADLOCK ***
[  139.919652]
[  139.925558] 1 lock held by swapper/0/0:
[  139.929374]  #0:  (snd_pcm_link_rwlock){...-..}, at: [<c04e0330>]
snd_pcm_stream_lock+0x20/0x50
[  139.938054]
[  139.938054] the shortest dependencies between 2nd lock and 1st lock:
[  139.945893]  -> (&(&pri_dai->spinlock)->rlock){+.+...} ops: 37 {
[  139.951856]     HARDIRQ-ON-W at:
[  139.955067]                       [<c066b89c>] _raw_spin_lock+0x3c/0x74
[  139.961663]                       [<c0500558>] i2s_set_sysclk+0x40/0x464
[  139.968347]                       [<c0500e0c>]
samsung_i2s_dai_probe+0x238/0x2b0
[  139.975725]                       [<c04ed5f8>] soc_probe_dai.part.2+0x30/0x6c
[  139.982842]                       [<c04ee1b8>]
snd_soc_register_card+0x854/0xe64
[  139.990220]                       [<c04f9b0c>]
devm_snd_soc_register_card+0x38/0x70
[  139.997859]                       [<c04ff0f8>]
asoc_simple_card_probe+0x224/0x460
[  140.005323]                       [<c036da6c>] platform_drv_probe+0x4c/0xb0
[  140.012267]                       [<c036c2ac>]
driver_probe_device+0x20c/0x2b8
[  140.019472]                       [<c036a644>] bus_for_each_drv+0x60/0x94
[  140.026242]                       [<c036bfc0>] __device_attach+0xb4/0x118
[  140.033013]                       [<c036b464>] bus_probe_device+0x88/0x90
[  140.039783]                       [<c036b900>]
deferred_probe_work_func+0x6c/0x9c
[  140.047248]                       [<c0043408>] process_one_work+0x1a8/0x514
[  140.054192]                       [<c00437ac>] worker_thread+0x38/0x574
[  140.060789]                       [<c0049c0c>] kthread+0xf4/0x10c
[  140.066865]                       [<c000f890>] ret_from_fork+0x14/0x24
[  140.073376]     SOFTIRQ-ON-W at:
[  140.076587]                       [<c066b89c>] _raw_spin_lock+0x3c/0x74
[  140.083183]                       [<c0500558>] i2s_set_sysclk+0x40/0x464
[  140.089867]                       [<c0500e0c>]
samsung_i2s_dai_probe+0x238/0x2b0
[  140.097245]                       [<c04ed5f8>] soc_probe_dai.part.2+0x30/0x6c
[  140.104362]                       [<c04ee1b8>]
snd_soc_register_card+0x854/0xe64
[  140.111740]                       [<c04f9b0c>]
devm_snd_soc_register_card+0x38/0x70
[  140.119379]                       [<c04ff0f8>]
asoc_simple_card_probe+0x224/0x460
[  140.126843]                       [<c036da6c>] platform_drv_probe+0x4c/0xb0
[  140.133787]                       [<c036c2ac>]
driver_probe_device+0x20c/0x2b8
[  140.140992]                       [<c036a644>] bus_for_each_drv+0x60/0x94
[  140.147762]                       [<c036bfc0>] __device_attach+0xb4/0x118
[  140.154533]                       [<c036b464>] bus_probe_device+0x88/0x90
[  140.161303]                       [<c036b900>]
deferred_probe_work_func+0x6c/0x9c
[  140.168768]                       [<c0043408>] process_one_work+0x1a8/0x514
[  140.175712]                       [<c00437ac>] worker_thread+0x38/0x574
[  140.182309]                       [<c0049c0c>] kthread+0xf4/0x10c
[  140.188385]                       [<c000f890>] ret_from_fork+0x14/0x24
[  140.194896]     INITIAL USE at:
[  140.198020]                      [<c066bb14>]
_raw_spin_lock_irqsave+0x48/0x84
[  140.205224]                      [<c04c2d44>] clk_divider_set_rate+0x40/0xc0
[  140.212255]                      [<c04c1320>] clk_change_rate+0x17c/0x210
[  140.219025]                      [<c04c12b8>] clk_change_rate+0x114/0x210
[  140.225796]   }
[  140.227532]   ... key      at: [<c13e2f04>] __key.37532+0x0/0x8
[  140.233435]   ... acquired at:
[  140.236472]    [<c04ffb18>] i2s_trigger+0x40/0x62c
[  140.241246]    [<c04f4d14>] soc_pcm_trigger+0xd0/0x11c
[  140.246367]    [<c04dfe58>] snd_pcm_action_single+0x38/0x80
[  140.251922]    [<c04e1dac>] snd_pcm_common_ioctl1+0x3bc/0xe20
[  140.257651]    [<c04e29b4>] snd_pcm_playback_ioctl1+0x1a4/0x69c
[  140.263553]    [<c01343f8>] do_vfs_ioctl+0xa0/0x9d4
[  140.268414]    [<c0134d60>] SyS_ioctl+0x34/0x5c
[  140.272927]    [<c000f800>] ret_fast_syscall+0x0/0x1c
[  140.277962]
[  140.279438] -> (&(&substream->self_group.lock)->rlock){..-...} ops: 153 {
[  140.286209]    IN-SOFTIRQ-W at:
[  140.289333]                     [<c066b89c>] _raw_spin_lock+0x3c/0x74
[  140.295757]                     [<c04e03cc>]
_snd_pcm_stream_lock_irqsave+0x34/0x40
[  140.303395]                     [<c04e6f44>] snd_pcm_period_elapsed+0x1c/0xa0
[  140.310512]                     [<c02de5b0>] pl330_tasklet+0x198/0x518
[  140.317022]                     [<c002e424>] tasklet_action+0xac/0x164
[  140.323532]                     [<c002e6ac>] __do_softirq+0x168/0x2c0
[  140.329955]                     [<c002eba8>] irq_exit+0xec/0x128
[  140.335945]                     [<c0087314>] __handle_domain_irq+0x80/0xec
[  140.342802]                     [<c0009514>] gic_handle_irq+0x54/0x94
[  140.349225]                     [<c00144f8>] __irq_svc+0x58/0x98
[  140.355214]                     [<c00102f8>] arch_cpu_idle+0x24/0x3c
[  140.361551]                     [<c00102f8>] arch_cpu_idle+0x24/0x3c
[  140.367887]                     [<c006d5d4>] cpu_startup_entry+0x1f4/0x280
[  140.374744]                     [<c08c8ccc>] start_kernel+0x3ec/0x3f8
[  140.381169]    INITIAL USE at:
[  140.384205]                    [<c066b89c>] _raw_spin_lock+0x3c/0x74
[  140.390542]                    [<c04e0850>] snd_pcm_sync_ptr+0xf8/0x1e0
[  140.397139]                    [<c04e1e68>] snd_pcm_common_ioctl1+0x478/0xe20
[  140.404256]                    [<c04e3078>]
snd_pcm_capture_ioctl1+0x1a4/0x688
[  140.411461]                    [<c01343f8>] do_vfs_ioctl+0xa0/0x9d4
[  140.417710]                    [<c0134d60>] SyS_ioctl+0x34/0x5c
[  140.423613]                    [<c000f800>] ret_fast_syscall+0x0/0x1c
[  140.430036]  }
[  140.431685]  ... key      at: [<c13e2be8>] __key.29136+0x0/0x8
[  140.437501]  ... acquired at:
[  140.440452]    [<c0079630>] __lock_acquire+0x774/0x1ee0
[  140.445659]    [<c007b390>] lock_acquire+0xa8/0xd0
[  140.450433]    [<c066b89c>] _raw_spin_lock+0x3c/0x74
[  140.455381]    [<c04e03cc>] _snd_pcm_stream_lock_irqsave+0x34/0x40
[  140.461544]    [<c04e6f44>] snd_pcm_period_elapsed+0x1c/0xa0
[  140.467186]    [<c02de5b0>] pl330_tasklet+0x198/0x518
[  140.472220]    [<c002e424>] tasklet_action+0xac/0x164
[  140.477255]    [<c002e6ac>] __do_softirq+0x168/0x2c0
[  140.482202]    [<c002eba8>] irq_exit+0xec/0x128
[  140.486716]    [<c0087314>] __handle_domain_irq+0x80/0xec
[  140.492097]    [<c0009514>] gic_handle_irq+0x54/0x94
[  140.497044]    [<c00144f8>] __irq_svc+0x58/0x98
[  140.501559]    [<c00102f8>] arch_cpu_idle+0x24/0x3c
[  140.506420]    [<c00102f8>] arch_cpu_idle+0x24/0x3c
[  140.511280]    [<c006d5d4>] cpu_startup_entry+0x1f4/0x280
[  140.516662]    [<c08c8ccc>] start_kernel+0x3ec/0x3f8
[  140.521609]
[  140.523086]
[  140.523086] stack backtrace:
[  140.527435] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
4.5.0-rc3-u3s #11
[  140.535240] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  140.541339] [<c0016d6c>] (unwind_backtrace) from [<c00139f8>]
(show_stack+0x10/0x14)
[  140.549063] [<c00139f8>] (show_stack) from [<c0283884>]
(dump_stack+0x98/0xc4)
[  140.556263] [<c0283884>] (dump_stack) from [<c0075458>]
(print_irq_inversion_bug+0x1d4/0x21c)
[  140.564766] [<c0075458>] (print_irq_inversion_bug) from
[<c0075550>] (check_usage_forwards+0xb0/0x10c)
[  140.574051] [<c0075550>] (check_usage_forwards) from [<c00764f8>]
(mark_lock+0x370/0x81c)
[  140.582211] [<c00764f8>] (mark_lock) from [<c0079630>]
(__lock_acquire+0x774/0x1ee0)
[  140.589936] [<c0079630>] (__lock_acquire) from [<c007b390>]
(lock_acquire+0xa8/0xd0)
[  140.597665] [<c007b390>] (lock_acquire) from [<c066b89c>]
(_raw_spin_lock+0x3c/0x74)
[  140.605389] [<c066b89c>] (_raw_spin_lock) from [<c04e03cc>]
(_snd_pcm_stream_lock_irqsave+0x34/0x40)
[  140.614503] [<c04e03cc>] (_snd_pcm_stream_lock_irqsave) from
[<c04e6f44>] (snd_pcm_period_elapsed+0x1c/0xa0)
[  140.624313] [<c04e6f44>] (snd_pcm_period_elapsed) from [<c02de5b0>]
(pl330_tasklet+0x198/0x518)
[  140.632993] [<c02de5b0>] (pl330_tasklet) from [<c002e424>]
(tasklet_action+0xac/0x164)
[  140.640890] [<c002e424>] (tasklet_action) from [<c002e6ac>]
(__do_softirq+0x168/0x2c0)
[  140.648787] [<c002e6ac>] (__do_softirq) from [<c002eba8>]
(irq_exit+0xec/0x128)
[  140.656080] [<c002eba8>] (irq_exit) from [<c0087314>]
(__handle_domain_irq+0x80/0xec)
[  140.663889] [<c0087314>] (__handle_domain_irq) from [<c0009514>]
(gic_handle_irq+0x54/0x94)
[  140.672219] [<c0009514>] (gic_handle_irq) from [<c00144f8>]
(__irq_svc+0x58/0x98)
[  140.679677] Exception stack(0xc0aa5f50 to 0xc0aa5f98)
[  140.684716] 5f40:                                     00000000
2e0b1000 00000000 c0aaa540
[  140.692879] 5f60: c0aa4000 c0aa655c 00000000 00000000 c0aa5fa8
c093d49c c0aa65bc c0aa65c4
[  140.701035] 5f80: 00000000 c0aa5fa0 c0076b38 c00102f8 20030053 ffffffff
[  140.707637] [<c00144f8>] (__irq_svc) from [<c00102f8>]
(arch_cpu_idle+0x24/0x3c)
[  140.715014] [<c00102f8>] (arch_cpu_idle) from [<c006d5d4>]
(cpu_startup_entry+0x1f4/0x280)
[  140.723265] [<c006d5d4>] (cpu_startup_entry) from [<c08c8ccc>]
(start_kernel+0x3ec/0x3f8)

Best Regards
-Anand Moon
