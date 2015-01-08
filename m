From: moon.linux@yahoo.com (Anand Moon)
Date: Thu, 8 Jan 2015 14:21:53 +0000 (UTC)
Subject: [PATCH v2] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <1420706948.6075.17.camel@collabora.co.uk>
References: <1417721269-19342-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <54AA48E6.3040404@samsung.com> <1420470469.15910.134.camel@collabora.co.uk>
 <69242715.30115.1420655868687.JavaMail.yahoo@jws10659.mail.bf1.yahoo.com>
 <1420670333.6075.2.camel@collabora.co.uk>
 <6203C077F070A646AA0FCB4B5F1795D248114CA6@sisaex01sj>
 <1420706948.6075.17.camel@collabora.co.uk>
Message-ID: <1381088902.6390475.1420726913802.JavaMail.yahoo@jws10667.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sjoerd,

Thanks for all the inputs.
I would like to point out another issue.

I have pulled the changes from "git://git.collabora.co.uk/git/user/javier/linux.git" branch "wip/exynos/dp-integ"


And now Hdmi output to monitor flickers and then black screen.

odroid at odroid-xu3:~$ dmesg | grep hdmi
[    2.442286] hdmi-en: no parameters
[    2.443185] reg-fixed-voltage regulators:regulator at 1: hdmi-en supplying 0uV
[   10.199757] samsung-pinctrl 13400000.pinctrl: request pin 39 (gpx3-7) for 14530000.hdmi
[   10.208086] of_get_named_gpiod_flags: parsed 'hpd-gpio' property of node '/hdmi at 14530000[0]' - status (0)
[   10.217849] exynos-hdmi 14530000.hdmi: Looking up vdd-supply from device tree
[   10.224403] exynos-hdmi 14530000.hdmi: Failed to get supply 'vdd': -517
[   10.230935] [drm:hdmi_resources_init] *ERROR* failed to get regulators
[   10.237472] [drm:hdmi_probe] *ERROR* hdmi_resources_init failed
[   10.243860] platform 14530000.hdmi: Driver exynos-hdmi requests probe deferral
[   14.290745] samsung-pinctrl 13400000.pinctrl: request pin 39 (gpx3-7) for 14530000.hdmi
[   14.299134] of_get_named_gpiod_flags: parsed 'hpd-gpio' property of node '/hdmi at 14530000[0]' - status (0)
[   14.308644] exynos-hdmi 14530000.hdmi: Looking up vdd-supply from device tree
[   14.316894] exynos-hdmi 14530000.hdmi: Looking up vdd_osc-supply from device tree
[   14.324316] exynos-hdmi 14530000.hdmi: Looking up vdd_pll-supply from device tree
[   14.331728] exynos-hdmi 14530000.hdmi: Looking up hdmi-en-supply from device tree
[   14.337943] exynos-hdmi 14530000.hdmi: Looking up hdmi-en-supply property in node /hdmi at 14530000 failed
[   14.399118] exynos-drm exynos-drm: bound 14530000.hdmi (ops hdmi_component_ops)


I am now observing the kernel bug bellow.
----------------------------------------------------------------------------

[  164.155699] init: plymouth-stop pre-start process (3934) terminated with status 1
[  654.961143] ------------[ cut here ]------------
[  654.964305] kernel BUG at drivers/gpu/drm/drm_irq.c:1032!
[  654.969673] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[  654.975475] Modules linked in: cpufreq_ondemand cpufreq_conservative cpufreq_userspace cpufreq_powersave ipv6 rfcomm bnep bluetooth
[  654.987267] CPU: 0 PID: 4075 Comm: Xorg Not tainted 3.18.0-armv71 #24
[  654.993678] task: ddbfc300 ti: ddbd6000 task.ti: ddbd6000
[  654.999055] PC is at drm_vblank_put+0xcc/0xe4
[  655.003386] LR is at mixer_wait_for_vblank+0x11c/0x148
[  655.008493] pc : [<c03eb608>]    lr : [<c040ee4c>]    psr: 60030013
[  655.008493] sp : ddbd7ce8  ip : ddbd7d00  fp : ddbd7cfc
[  655.019930] r10: c0710a78  r9 : ddbd7e50  r8 : dda5f680
[  655.025129] r7 : 00000008  r6 : c0bd7aec  r5 : eb958724  r4 : eb958590
[  655.031627] r3 : eb97d680  r2 : 00000000  r1 : 00000000  r0 : c23f9a40
[  655.038127] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  655.045233] Control: 10c5387d  Table: 5b87806a  DAC: 00000015
[  655.050954] Process Xorg (pid: 4075, stack limit = 0xddbd6238)
[  655.056759] Stack: (0xddbd7ce8 to 0xddbd8000)
[  655.061096] 7ce0:                   eb958590 eb958724 ddbd7d34 ddbd7d00 c040ee4c c03eb548
[  655.069242] 7d00: ddbd7e50 00000000 ddbfc300 c006fba0 ddbd7d10 ddbd7d10 eb955f00 c23f9ed0
[  655.077389] 7d20: c23f9a40 dda5f6e4 ddbd7d4c ddbd7d38 c04045a4 c040ed3c dda5f684 c23f9e40
[  655.085535] 7d40: ddbd7d7c ddbd7d50 c0404ddc c040456c c0404dbc dda5f684 c23f9e40 c23f9a40
[  655.093679] 7d60: dda5f680 dda5f680 ddbd7e50 c0710a78 ddbd7d9c ddbd7d80 c03f2c30 c0404dc8
[  655.101824] 7d80: dda5f680 dda5f680 c23f9a40 c23f9a40 ddbd7dbc ddbd7da0 c03f2c94 c03f2bdc
[  655.109971] 7da0: ddbd6008 600f0013 ddbd7dc4 e9b92f5c ddbd7dfc ddbd7dc0 c03f304c c03f2c40
[  655.118116] 7dc0: c06bc8dc c007ae2c e9b92f5c c23f9e40 dda5f6d8 c23f9a40 dda5f680 ddbd7e50
[  655.126260] 7de0: e9b92f5c c23f9e40 dda5f6d8 c23f9a40 ddbd7e24 ddbd7e00 c03f77f0 c03f2fa0
[  655.134407] 7e00: ddbd7e50 c23f9a40 c1450544 000000af e9b92ec0 ddbd7e50 ddbd7efc ddbd7e28
[  655.142553] 7e20: c03e9bcc c03f7728 600f0013 ed401200 00070001 ddab10c0 ddbd7e5c ddbd7e48
[  655.150697] 7e40: c03f771c 00000004 c00464af bed28bbc 0000001a 00000001 00000001 00000004
[  655.158842] 7e60: 00000020 00000018 00000001 00000000 00000000 00000002 00000002 00000002
[  655.166989] 7e80: 00000000 00001000 00000000 00001000 c007c7a4 c033daa8 00000000 ed4efcc0
[  655.175132] 7ea0: c0160204 ddab53c0 ddab53c0 ddbd6018 00070000 c0160258 ddbd6000 2d068000
[  655.183277] 7ec0: edbe6ce8 c0b85c40 ddbd7ef4 ed4efcc0 c0b7ece8 eb86de18 bed28bbc db83b200
[  655.191422] 7ee0: c017d4f4 00000008 ddbd6000 00000000 ddbd7f7c ddbd7f00 c017d270 c03e99e4
[  655.199568] 7f00: c0179b14 eea4d0c0 ddbd7f3c ddab53c0 db83b200 ddab53c0 eb86de18 db83b208
[  655.207713] 7f20: 00000020 00000000 ddbd7f4c ddbd7f38 c0179b14 00000001 c000ee84 b6fc41a8
[  655.215859] 7f40: ddbd7f6c ddbd7f50 c01896ac c00965f4 b6fc41a8 db83b200 00000008 db83b200
[  655.224005] 7f60: c00464af bed28bbc ddbd6000 00000000 ddbd7fa4 ddbd7f80 c017d4f4 c017ce58
[  655.232150] 7f80: b6fc41a8 bed28bbc c00464af 00000036 c000f0e4 ddbd6000 00000000 ddbd7fa8
[  655.240295] 7fa0: c000ee60 c017d4bc b6fc41a8 bed28bbc 00000008 c00464af bed28bbc 0000001a
[  655.248441] 7fc0: b6fc41a8 bed28bbc c00464af 00000036 bed28c24 00000020 b6fa18c4 00000003
[  655.256586] 7fe0: b6d38044 bed28b9c b6d2b80f b6b7fa36 800f0030 00000008 aaaaaaaa aaaaaaaa
[  655.264744] [<c03eb608>] (drm_vblank_put) from [<c040ee4c>] (mixer_wait_for_vblank+0x11c/0x148)
[  655.273403] [<c040ee4c>] (mixer_wait_for_vblank) from [<c04045a4>] (exynos_drm_crtc_complete_scanout+0x44/0x58)
[  655.283452] [<c04045a4>] (exynos_drm_crtc_complete_scanout) from [<c0404ddc>] (exynos_drm_fb_destroy+0x20/0xd4)
[  655.293509] [<c0404ddc>] (exynos_drm_fb_destroy) from [<c03f2c30>] (drm_framebuffer_free+0x60/0x64)
[  655.302518] [<c03f2c30>] (drm_framebuffer_free) from [<c03f2c94>] (drm_framebuffer_unreference+0x60/0x90)
[  655.312050] [<c03f2c94>] (drm_framebuffer_unreference) from [<c03f304c>] (drm_framebuffer_remove+0xb8/0x124)
[  655.321840] [<c03f304c>] (drm_framebuffer_remove) from [<c03f77f0>] (drm_mode_rmfb+0xd4/0xfc)
[  655.330330] [<c03f77f0>] (drm_mode_rmfb) from [<c03e9bcc>] (drm_ioctl+0x1f4/0x51c)
[  655.337872] [<c03e9bcc>] (drm_ioctl) from [<c017d270>] (do_vfs_ioctl+0x424/0x664)
[  655.345322] [<c017d270>] (do_vfs_ioctl) from [<c017d4f4>] (SyS_ioctl+0x44/0x6c)
[  655.352606] [<c017d4f4>] (SyS_ioctl) from [<c000ee60>] (ret_fast_syscall+0x0/0x48)
[  655.360139] Code: e89da830 e1a00003 ebfffc03 e89da830 (e7f001f2)
[  655.366212] ---[ end trace b3ff27e5920c0972 ]---
[  655.370795] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:41
[  655.379110] in_atomic(): 0, irqs_disabled(): 128, pid: 4075, name: Xorg
[  655.385693] INFO: lockdep is turned off.
[  655.389592] irq event stamp: 0
[  655.392625] hardirqs last  enabled at (0): [<  (null)>]   (null)
[  655.398604] hardirqs last disabled at (0): [<c0029e00>] copy_process.part.50+0x3a8/0x1778
[  655.406750] softirqs last  enabled at (0): [<c0029e00>] copy_process.part.50+0x3a8/0x1778
[  655.414895] softirqs last disabled at (0): [<  (null)>]   (null)
[  655.420881] CPU: 0 PID: 4075 Comm: Xorg Tainted: G      D        3.18.0-armv71 #24
[  655.428429] [<c0017610>] (unwind_backtrace) from [<c0013360>] (show_stack+0x20/0x24)
[  655.436144] [<c0013360>] (show_stack) from [<c06b8240>] (dump_stack+0x8c/0xcc)
[  655.443338] [<c06b8240>] (dump_stack) from [<c0056bd4>] (__might_sleep+0x180/0x248)
[  655.450957] [<c0056bd4>] (__might_sleep) from [<c06bdf2c>] (down_read+0x38/0xe8)
[  655.458323] [<c06bdf2c>] (down_read) from [<c003e28c>] (exit_signals+0x28/0x158)
[  655.465688] [<c003e28c>] (exit_signals) from [<c002e780>] (do_exit+0xb0/0xc2c)
[  655.472877] [<c002e780>] (do_exit) from [<c00135a4>] (die+0x240/0x2fc)
[  655.479374] [<c00135a4>] (die) from [<c0013688>] (arm_notify_die+0x28/0x60)
[  655.486307] [<c0013688>] (arm_notify_die) from [<c0008338>] (do_undefinstr+0xb8/0x214)
[  655.494194] [<c0008338>] (do_undefinstr) from [<c0013fd0>] (__und_svc_finish+0x0/0x30)
[  655.502071] Exception stack(0xddbd7ca0 to 0xddbd7ce8)
[  655.507103] 7ca0: c23f9a40 00000000 00000000 eb97d680 eb958590 eb958724 c0bd7aec 00000008
[  655.515249] 7cc0: dda5f680 ddbd7e50 c0710a78 ddbd7cfc ddbd7d00 ddbd7ce8 c040ee4c c03eb608
[  655.523388] 7ce0: 60030013 ffffffff
[  655.526863] [<c0013fd0>] (__und_svc_finish) from [<c03eb608>] (drm_vblank_put+0xcc/0xe4)
[  655.534923] [<c03eb608>] (drm_vblank_put) from [<c040ee4c>] (mixer_wait_for_vblank+0x11c/0x148)
[  655.543587] [<c040ee4c>] (mixer_wait_for_vblank) from [<c04045a4>] (exynos_drm_crtc_complete_scanout+0x44/0x58)
[  655.553638] [<c04045a4>] (exynos_drm_crtc_complete_scanout) from [<c0404ddc>] (exynos_drm_fb_destroy+0x20/0xd4)
[  655.563693] [<c0404ddc>] (exynos_drm_fb_destroy) from [<c03f2c30>] (drm_framebuffer_free+0x60/0x64)
[  655.572705] [<c03f2c30>] (drm_framebuffer_free) from [<c03f2c94>] (drm_framebuffer_unreference+0x60/0x90)
[  655.582237] [<c03f2c94>] (drm_framebuffer_unreference) from [<c03f304c>] (drm_framebuffer_remove+0xb8/0x124)
[  655.592027] [<c03f304c>] (drm_framebuffer_remove) from [<c03f77f0>] (drm_mode_rmfb+0xd4/0xfc)
[  655.600517] [<c03f77f0>] (drm_mode_rmfb) from [<c03e9bcc>] (drm_ioctl+0x1f4/0x51c)
[  655.608056] [<c03e9bcc>] (drm_ioctl) from [<c017d270>] (do_vfs_ioctl+0x424/0x664)
[  655.615509] [<c017d270>] (do_vfs_ioctl) from [<c017d4f4>] (SyS_ioctl+0x44/0x6c)
[  655.622789] [<c017d4f4>] (SyS_ioctl) from [<c000ee60>] (ret_fast_syscall+0x0/0x48)


----------------------------------------------------------------------------
Also the regulators seems not getting populated in the device tree.

odroid at odroid-xu3:~$ ls /proc/device-tree/ | grep regulators
regulators
odroid at odroid-xu3:~$ ksrc8

-Anand Moon




On Thursday, January 8, 2015 6:14 PM, Sjoerd Simons <sjoerd.simons@collabora.co.uk> wrote:
On Wed, 2015-01-07 at 23:49 +0000, Jonathan Stone -SISA wrote:
> 
> On On Wed, 2015-01-07 at 18:37 +0000, Sjoerd Simons writes wrote:
> >On Wed, 2015-01-07 at 18:37 +0000, Anand Moon wrote:>
> [...]
> 
> >> Only 4 core cpu's are on my board. Also CpuFreq is not working.
> > 
> > Can you share some point on this.
> 
> >The defconfig is using the bL switcher, which pairs up big and little cores to make them appear as one core.. So for 8 real cores, you'll get
> >4 "virtual cores".
> 
> That configuration is appropriate for the 5420, which allegedly has a hardware bug in the cache-coherence between the Cortex-A7 block and the Cortex-A15 block.
> Newer Exynos 5 SoCs -- 5422/5800, 5620, etc -- don't have that bug. The scheduler should configured to  do HMP on all 8 (or 6) cores.
> I don't have a 5410, but I assume it has the same bug as the 5420.

Yes the kernel/scheduler could be configured like that, but
exynos_defconfig turns on bL rather then HMP. 

Now it's not unthinkable to add code/dts properties to select the
right/preferred scheduling strategy depending on the board (HMP vs. bL).
But proper HMP scheduling is still a work in progress in mainline and
iirc specifically on the XU3 there are open issue wrt. MCPM and its
secure firmware. I've added Kevin to the CC as he's been working on this
topic so should know the status a lot better then i do.

> The XU3 kernel supplied by HardKernel shows all 8 cores, and does HMP scheduling across all 8.

Yes, that's independant of the dts though as mentioned above. Also there
are still opne issues to booting up all cores on an XU3 afaik. See 
  http://www.spinics.net/lists/linux-samsung-soc/msg39523.html

> I tried v1.0 of the Odroid-XU3 DTB patch, applied to linux-next
> 20150107.  I'm only seeing 1 core running on my Odroid-XU3.  The USB
> 3.0 port works (great!) but I'm not getting any HDMI output. I didn't
> try DisplayPort.   I'll gladly try v2 of the patch on an XU3; is there
> a better base to apply the patch to?

HDMI output is broken on all exynos boards in mainline atm. For exynos
5, see the thread here:
http://www.spinics.net/lists/linux-samsung-soc/msg40708.html

As far as a i know with the DTS as posted (just posted v3 with a small
improvement), all base functionality that can work on mainline (MMC/SD,
network, USB2, USB3) works. Some less important bits (fan control &
power sensors) are outstanding, but that really shouldn't block the
merge of the DTS.

--
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
