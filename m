From: john.stultz@linaro.org (John Stultz)
Date: Fri, 15 Apr 2016 13:17:48 -0700
Subject: [PATCH v2 4/9] remoteproc: Introduce Qualcomm WCNSS firmware
 loader
In-Reply-To: <1459222625-11440-5-git-send-email-bjorn.andersson@linaro.org>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
 <1459222625-11440-5-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <CALAqxLU1wo1kX752q6tx1j+2b5VR7DnFBKGPm23D5c-gdLTd7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 8:37 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>
> This introduces the peripheral image loader, for loading WCNSS firmware
> and boot the core on e.g. MSM8974. The firmware is verified and booted
> with the help of the Peripheral Authentication System (PAS) in
> TrustZone.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v1:
> - Split iris definition into separate driver/dt-node
> - Move constants from DT to code
> - Make stop-state and some of interrupts optional to properly work on 8064
> - Cleaned up and made mdt loader support relocation, which is needed on 8016.

Hey Bjorn,
    As you know,  I've been successfully using this patchset along
with a number of other patches in your trees to get wifi working on
the 2013 Nexus7. So for that, this can get a Tested-by: John Stultz
<john.stultz@linaro.org> :)

Though while I don't have much feedback on this specific driver, I am
a little curious about how the bigger integrated picture should look.

Currently, after bootup, one must "echo start >
/sys/kernel/debug/remoteproc/remoteproc0/state" to actually boot the
remote processor.

One issue is that if I try to integrate that line into some of the
bootup scripts, the system will hard hang. No panic, no OOPs, no
watchdog reboot, just a full device lockup. So it seems like there
needs to be some checks to ensure that whatever clks or otherhardware
is needed are up and running.

Second, after booting when I do "echo start..." manually, on occasion
I run into the case where while we're waiting for the firmware to
finish loading and the remote proc to come up, wpa_supplicant kicks in
and starts the wcnss driver, which tries to load the configuration
firmware before the remoteproc is all the way up. This fails, and then
usually a few seconds later there's a bad pointer traversal that
Oopses the machine (dmesg log below)

This is clearly racy, and I wonder if the starting of the remoteproc
is something that should be done by the wcnss driver which depends on
it?  Though I'm not sure how this would be integrated.

thanks
-john


"echo start..." happened here...

[   46.719340]  remoteproc0: powering up 3204000.wcnss-rproc
[   46.719486]  remoteproc0: Booting fw image wcnss.mdt, size 6804
[   47.307160] qcom_wcnss_ctrl riva.wcnss: WCNSS Version 1.4 1.2
[   47.321853] wcn36xx: mac address: 18:00:2d:88:9c:a9

But, before loading is finished, wpa_supplicant starts up...

[   47.403815] init: Starting service 'wpa_supplicant'...
[   47.749631] wcn36xx smd:riva at 6:wcnss:wifi: loading
/system/vendor/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin failed with
error -13
[   47.749824] wcn36xx smd:riva at 6:wcnss:wifi: Direct firmware load for
wlan/prima/WCNSS_qcom_wlan_nv.bin failed with error -2
[   47.749841] wcn36xx smd:riva at 6:wcnss:wifi: Falling back to user helper

(Note, this firmware load error above happens normally, and the
userhelper usually has to save the day, this is probably a separate
issue with the wcn36xx patches I'm using, and not an issue  with the
remoteproc code)

[   48.246701] wcn36xx: ERROR Timeout! No SMD response in 500ms
[   48.246752] wcn36xx: ERROR Failed to push NV to chip
[   48.268973] init: Service 'wpa_supplicant' (pid 1170) exited with status 255
[   51.858442]  remoteproc0: remote processor 3204000.wcnss-rproc is now up
[   67.543147] init: Starting service 'wpa_supplicant'...
[   67.877434] wcn36xx: ERROR hal_load_nv response failed err=5
[   67.877443] wcn36xx: ERROR Failed to push NV to chip
[   67.891921] init: Service 'wpa_supplicant' (pid 1175) exited with status 255
[   87.682962] Unable to handle kernel NULL pointer dereference at
virtual address 00000038
[   87.683324] pgd = e7d2c000
[   87.691595] [00000038] *pgd=00000000
[   87.697486] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[   87.697658] CPU: 3 PID: 159 Comm: lmkd Not tainted
4.6.0-rc3-00095-ga08f5eb #1252
[   87.703041] Hardware name: Qualcomm (Flattened Device Tree)
[   87.710413] task: e7c69a00 ti: e7d30000 task.ti: e7d30000
[   87.715798] PC is at kmem_cache_alloc+0x80/0x234
[   87.721347] LR is at kmem_cache_alloc+0x40/0x234
[   87.726037] pc : [<c04160c0>]    lr : [<c0416080>]    psr: 200f0013
[   87.726037] sp : e7d31f20  ip : 00000001  fp : 7f5c5004
[   87.730679] r10: 0001025f  r9 : e7d30000  r8 : c0e04538
[   87.741832] r7 : c0425d30  r6 : 024000c0  r5 : c0201b80  r4 : 00000038
[   87.747047] r3 : 00000000  r2 : 28665000  r1 : 0001025f  r0 : 00000000
[   87.753653] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   87.760159] Control: 10c5787d  Table: a7d2c06a  DAC: 00000051
[   87.767358] Process lmkd (pid: 159, stack limit = 0xe7d30210)
[   87.773085] Stack: (0xe7d31f20 to 0xe7d32000)
[   87.778832] 1f20: e5c92488 00000000 00020001 bea9ea04 00000000
00000000 c0e04594 e7d30000
[   87.783195] 1f40: 00000000 c0425d30 00020001 00000002 ffffff9c
00000142 c03081c4 e7d30000
[   87.791355] 1f60: 00000000 c041bb94 00000000 e5c92480 e5c92480
00020001 bea90000 00000002
[   87.799515] 1f80: 00000100 00000001 00000000 00000000 bea9ea04
000003e8 00000142 c03081c4
[   87.807675] 1fa0: 00000000 c0308000 00000000 bea9ea04 ffffff9c
bea9ea04 00020001 00000000
[   87.815834] 1fc0: 00000000 bea9ea04 000003e8 00000142 bea9e984
bea9ea04 7f5c2668 7f5c5004
[   87.823997] 1fe0: bea9e984 bea9e8e0 b6e7ca45 b6ea1a30 600f0010
ffffff9c 00000000 00000000
[   87.832171] [<c04160c0>] (kmem_cache_alloc) from [<c0425d30>]
(getname_flags+0x4c/0x1b4)
[   87.840320] [<c0425d30>] (getname_flags) from [<c041bb94>]
(do_sys_open+0xe4/0x1c0)
[   87.848471] [<c041bb94>] (do_sys_open) from [<c0308000>]
(ret_fast_syscall+0x0/0x3c)
[   87.855845] Code: e7924003 e3540000 0a000029 e5953014 (e7940003)
[   87.863985] ---[ end trace b3cfb7dc9f426996 ]---
[   87.869888] Kernel panic - not syncing: Fatal exception
[   87.874477] CPU2: stopping
[   87.879405] CPU: 2 PID: 1179 Comm: wpa_supplicant Tainted: G      D
        4.6.0-rc3-00095-ga08f5eb #1252
[   87.882217] Hardware name: Qualcomm (Flattened Device Tree)
[   87.891866] [<c030ea58>] (unwind_backtrace) from [<c030b838>]
(show_stack+0x10/0x14)
[   87.897346] [<c030b838>] (show_stack) from [<c056a56c>]
(dump_stack+0x74/0x94)
[   87.905311] [<c056a56c>] (dump_stack) from [<c030da78>]
(handle_IPI+0x19c/0x344)
[   87.912346] [<c030da78>] (handle_IPI) from [<c0301444>]
(gic_handle_irq+0x80/0x8c)
[   87.919894] [<c0301444>] (gic_handle_irq) from [<c030c650>]
(__irq_usr+0x50/0x80)
[   87.927257] Exception stack(0xe036ffb0 to 0xe036fff8)
[   87.934805] ffa0:                                     beb678b0
beb678c8 00000040 98badcfe
[   87.939879] ffc0: b6eca03c beb678b0 beb678c8 00000000 b6f6aec0
beb678e0 beb678c8 7f6f1890
[   87.948031] ffe0: b6ed337c beb67760 b6e8b31f b6e807b4 80070030 ffffffff
[   87.956158] CPU0: stopping
[   87.962549] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D
4.6.0-rc3-00095-ga08f5eb #1252
[   87.965367] Hardware name: Qualcomm (Flattened Device Tree)
[   87.974301] [<c030ea58>] (unwind_backtrace) from [<c030b838>]
(show_stack+0x10/0x14)
[   87.979780] [<c030b838>] (show_stack) from [<c056a56c>]
(dump_stack+0x74/0x94)
[   87.987760] [<c056a56c>] (dump_stack) from [<c030da78>]
(handle_IPI+0x19c/0x344)
[   87.994791] [<c030da78>] (handle_IPI) from [<c0301444>]
(gic_handle_irq+0x80/0x8c)
[   88.002339] [<c0301444>] (gic_handle_irq) from [<c030c314>]
(__irq_svc+0x54/0x90)
[   88.009718] Exception stack(0xc0e01f58 to 0xc0e01fa0)
[   88.017252] 1f40:
    00000001 00000000
[   88.022326] 1f60: c0e01fb0 c0317cc0 c0e80b80 c0e038dc 00000000
00000000 c0e80b80 c0e03938
[   88.030486] 1f80: c0d6b610 c0e03930 00000001 c0e01fa8 c0308ad4
c0308ad8 600f0013 ffffffff
[   88.038637] [<c030c314>] (__irq_svc) from [<c0308ad8>]
(arch_cpu_idle+0x30/0x3c)
[   88.046791] [<c0308ad8>] (arch_cpu_idle) from [<c035a018>]
(cpu_startup_entry+0x1d0/0x3b4)
[   88.054267] [<c035a018>] (cpu_startup_entry) from [<c0d00c14>]
(start_kernel+0x334/0x39c)
[   88.062328] CPU1: stopping
[   88.070544] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D
4.6.0-rc3-00095-ga08f5eb #1252
[   88.073183] Hardware name: Qualcomm (Flattened Device Tree)
[   88.082128] [<c030ea58>] (unwind_backtrace) from [<c030b838>]
(show_stack+0x10/0x14)
[   88.087612] [<c030b838>] (show_stack) from [<c056a56c>]
(dump_stack+0x74/0x94)
[   88.095584] [<c056a56c>] (dump_stack) from [<c030da78>]
(handle_IPI+0x19c/0x344)
[   88.102618] [<c030da78>] (handle_IPI) from [<c0301444>]
(gic_handle_irq+0x80/0x8c)
[   88.110168] [<c0301444>] (gic_handle_irq) from [<c030c314>]
(__irq_svc+0x54/0x90)
[   88.117535] Exception stack(0xc02e5f90 to 0xc02e5fd8)
[   88.125081] 5f80:                                     00000001
00000000 c02e5fe8 c0317cc0
[   88.130155] 5fa0: c0e80b80 c0e038dc 00000000 00000000 c0e80b80
c0e03938 c0d6b610 c0e03930
[   88.138307] 5fc0: 00000001 c02e5fe0 c0308ad4 c0308ad8 60070013 ffffffff
[   88.146452] [<c030c314>] (__irq_svc) from [<c0308ad8>]
(arch_cpu_idle+0x30/0x3c)
[   88.152884] [<c0308ad8>] (arch_cpu_idle) from [<c035a018>]
(cpu_startup_entry+0x1d0/0x3b4)
[   88.160523] [<c035a018>] (cpu_startup_entry) from [<803014ec>] (0x803014ec)
