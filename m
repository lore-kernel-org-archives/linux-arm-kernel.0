From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Oct 2013 14:00:57 +0100
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131020000434.GL25034@n2100.arm.linux.org.uk>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
 <20131015131038.GB25034@n2100.arm.linux.org.uk>
 <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
 <20131016170341.GH25034@n2100.arm.linux.org.uk>
 <20131016180735.GI25034@n2100.arm.linux.org.uk>
 <20131016183107.GC18050@kroah.com>
 <20131020000434.GL25034@n2100.arm.linux.org.uk>
Message-ID: <20131020130057.GN25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 20, 2013 at 01:04:34AM +0100, Russell King - ARM Linux wrote:
> On Wed, Oct 16, 2013 at 11:31:07AM -0700, Greg Kroah-Hartman wrote:
> > On Wed, Oct 16, 2013 at 07:07:35PM +0100, Russell King - ARM Linux wrote:
> > > Sorry, but I don't think imx-drm is driving the hardware correctly, and
> > > I know that Greg wants it moved out of drivers/staging, but frankly it
> > > seems to be far from ready for that.  Certainly the HDMI parts seems to
> > > be especially problematical.
> > 
> > I want it out of staging if it's working properly.  Yours is the first
> > report of it not working properly, and in fact, probably one of the
> > first users of the driver, as I haven't gotten any reports of it working
> > or not at all over the years.
> 
> Next problem... unbinding, rebinding, and then unbinding the imx-drm
> device produces the nice oops below.  I've not debugged this yet.

I've been tweaking the ARM oops format slightly (I hope this isn't going
to end up breaking any tools... it's only a minor change.)  I've been
using this as a way of testing it.  The change here is using %ps instead
of %pS for the first symbolic print in each entry (it's always the start
of the function).  The other change is fixing the saved register set so
saves including r10 get printed - and its better formatted.


As for imx-drm, there was a warning which preceded that oops.  Here's the
full log, below the "---------" marker - this is from unbinding the imx-drm
module, and then trying to reboot.

imx-drm is really very broken in the way it tries to bend DRM to be
used in DT - it doesn't consider the lifetime for anything like the
CRTCs, connectors or encoders.  All these have empty .destroy functions
to them. If we unbind imx-drm, the top level drm_device tries to be
destroyed, but it leaves behind all the CRTCs, connectors and encoders,
causing the first warning because none of the framebuffers got cleaned
up through that destruction (because the functions did nothing.)

The second one is through trying to clean up the framebuffer, which is
still in use.

The third one is caused because there's still allocated memory objects
against the DRM memory manager - again, because nothing has been cleaned
up.

Finally, the oops at the end.  I thought that's a candidate for
enabling kobject debugging and release debugging, but as soon as I do,
it perversely goes away!  Eventually I managed to reproduce it, and
it's the same bug which was investigated recently wrt sysfs lifetimes.
I would test David's fix for this, but it *isn't* generated against an
-rc kernel, it rejects fairly horribly.

Since it happens without kobject debugging enabled, it would be good
to get the fix in for 3.12-rc.  David?

kobject: 'card0' (db2bfc18): kobject_add_internal: parent: 'drm', set: 'devices'
kobject: 'card0' (db2bfc18): kobject_uevent_env
kobject: 'card0' (db2bfc18): fill_kobj_path: path = '/devices/platform/imx-drm/drm/card0'
[drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[drm] No driver support for vblank timestamp query.
...
kobject: 'card0' (db2bfc18): kobject_uevent_env
kobject: 'card0' (db2bfc18): fill_kobj_path: path = '/devices/platform/imx-drm/drm/card0'
kobject: 'imx-hdmi' (db293840): kobject_uevent_env
kobject: 'imx-hdmi' (db293840): fill_kobj_path: path = '/bus/platform/drivers/imx-hdmi'
...
kobject: 'card0' (db2bfc18): kobject_uevent_env
kobject: 'card0' (db2bfc18): fill_kobj_path: path = '/devices/platform/imx-drm/drm/card0'
kobject: 'card0-HDMI-A-1' (db837020): kobject_uevent_env
kobject: 'card0-HDMI-A-1' (db837020): fill_kobj_path: path = '/devices/platform/imx-drm/drm/card0/card0-HDMI-A-1'
...
kobject: 'card0' (db2bfc18): kobject_uevent_env
kobject: 'card0' (db2bfc18): fill_kobj_path: path = '/devices/platform/imx-drm/drm/card0'
kobject: 'card0-HDMI-A-1' (db837020): kobject_uevent_env
kobject: 'card0-HDMI-A-1' (db837020): fill_kobj_path: path = '/devices/platform/imx-drm/drm/card0/card0-HDMI-A-1'
...
kobject: 'card0' (db2bfc18): kobject_uevent_env
kobject: 'card0' (db2bfc18): fill_kobj_path: path = '/devices/platform/imx-drm/drm/card0'
kobject: 'drm' (db28fb00): kobject_release, parent db2bf418 (delayed)
[drm] Module unloaded
kobject: 'controlD64' (db2bf818): kobject_cleanup, parent   (null)
kobject: 'controlD64' (db2bf818): calling ktype release
kobject: 'controlD64': free name
kobject: 'drm' (db28fb00): kobject_cleanup, parent db2bf418
kobject: 'drm' (db28fb00): auto cleanup kobject_del
kobject: 'drm' (db28fb00): calling ktype release
kobject: 'drm': free name
...
WARNING: CPU: 0 PID: 1027 at /home/rmk/git/linux-rmk/include/linux/kref.h:47 kobject_get+0x60/0x74()
Modules linked in: fuse rfcomm bnep bluetooth
CPU: 0 PID: 1027 Comm: reboot Tainted: G        W    3.12.0-rc4+ #128
Backtrace:
[<c001218c>] (dump_backtrace) from [<c0012328>] (show_stack+0x18/0x1c)
 r6:c0646298 r5:0000002f r4:00000000 r3:00000000
[<c0012310>] (show_stack) from [<c05f6a78>] (dump_stack+0x70/0x90)
[<c05f6a08>] (dump_stack) from [<c00233a0>] (warn_slowpath_common+0x6c/0x8c)
 r4:00000000 r3:db142400
[<c0023334>] (warn_slowpath_common) from [<c00233e4>] (warn_slowpath_null+0x24/0x2c)
 r8:c088361c r7:db837024 r6:c0dc7fa4 r5:c08834f2 r4:db2bfc18
                                                    ^^^^^^^^ kobject address
[<c00233c0>] (warn_slowpath_null) from [<c027fbc8>] (kobject_get+0x60/0x74)
[<c027fb68>] (kobject_get) from [<c030dbfc>] (get_device+0x1c/0x24)
 r5:00000000 r4:db837018
[<c030dbe0>] (get_device) from [<c030fb0c>] (device_shutdown+0x90/0x19c)

-------------------
WARNING: CPU: 0 PID: 997 at /home/rmk/git/linux-rmk/drivers/gpu/drm/drm_crtc.c:4036 drm_mode_config_cleanup+0x250/0x25c()
Modules linked in: fuse bnep rfcomm bluetooth
CPU: 0 PID: 997 Comm: bash Not tainted 3.12.0-rc4+ #127
Backtrace: 
[<c001218c>] (dump_backtrace) from [<c0012328>] (show_stack+0x18/0x1c)
 r6:c065dc74 r5:00000fc4 r4:00000000 r3:00000000
[<c0012310>] (show_stack) from [<c05f5f90>] (dump_stack+0x70/0x90)
[<c05f5f20>] (dump_stack) from [<c00233a0>] (warn_slowpath_common+0x6c/0x8c)
 r4:00000000 r3:d7c75a00
[<c0023334>] (warn_slowpath_common) from [<c00233e4>] (warn_slowpath_null+0x24/0x2c)
 r8:db2a64cc r7:db2a6410 r6:db2a64c0 r5:db2a6000 r4:db2a64c0
[<c00233c0>] (warn_slowpath_null) from [<c03008b0>] (drm_mode_config_cleanup+0x250/0x25c)
[<c0300660>] (drm_mode_config_cleanup) from [<c0465494>] (imx_drm_driver_unload+0x1c/0x2c)
 r10:db286000 r9:c06679c8 r8:00000008 r7:c0872568 r6:db29b810 r5:c087265c
 r4:db280f00 r3:d7c75a00
[<c0465478>] (imx_drm_driver_unload) from [<c02fa29c>] (drm_put_dev+0x50/0x154)
 r4:db2a6000 r3:c0465478
[<c02fa24c>] (drm_put_dev) from [<c02fb900>] (drm_platform_exit+0x38/0x5c)
 r7:00000008 r6:db29b810 r5:c087265c r4:c087265c
[<c02fb8c8>] (drm_platform_exit) from [<c0464d54>] (imx_drm_platform_remove+0x1c/0x24)
 r5:c0872678 r4:db29b810
[<c0464d38>] (imx_drm_platform_remove) from [<c0312bfc>] (platform_drv_remove+0x20/0x24)
[<c0312bdc>] (platform_drv_remove) from [<c03113b0>] (__device_release_driver+0x78/0xd4)
[<c0311338>] (__device_release_driver) from [<c0311434>] (device_release_driver+0x28/0x34)
 r5:db29b810 r4:db29b844
[<c031140c>] (device_release_driver) from [<c03103ac>] (unbind_store+0x80/0x98)
 r5:c085b588 r4:c0872678
[<c031032c>] (unbind_store) from [<c030f934>] (drv_attr_store+0x28/0x34)
 r7:db28c280 r6:d7d9ff70 r5:d7d9a898 r4:d7d9a880
[<c030f90c>] (drv_attr_store) from [<c013d7d0>] (sysfs_write_file+0x108/0x188)
[<c013d6c8>] (sysfs_write_file) from [<c00db77c>] (vfs_write+0xd0/0x19c)
 r10:00000008 r9:00000000 r8:00000000 r7:d7d9ff70 r6:0132f408 r5:00000008
 r4:d7df5d00 r3:d7d9ff70
[<c00db6ac>] (vfs_write) from [<c00dbb58>] (SyS_write+0x4c/0x78)
 r10:00000008 r8:00000000 r7:0132f408 r6:d7d9ff70 r5:00000000 r4:d7df5d00
[<c00dbb0c>] (SyS_write) from [<c000e980>] (ret_fast_syscall+0x0/0x48)
 r10:00000000 r9:d7d9e000 r8:c000eb44 r7:00000004 r6:0132f408 r5:00000008
 r4:b6f72a78
---[ end trace 44f221ca42d7ae54 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 997 at /home/rmk/git/linux-rmk/drivers/gpu/drm/drm_crtc.c:571 drm_framebuffer_remove+0x10c/0x118()
Modules linked in: fuse bnep rfcomm bluetooth
CPU: 0 PID: 997 Comm: bash Tainted: G        W    3.12.0-rc4+ #127
Backtrace: 
[<c001218c>] (dump_backtrace) from [<c0012328>] (show_stack+0x18/0x1c)
 r6:c065dc74 r5:0000023b r4:00000000 r3:00000000
[<c0012310>] (show_stack) from [<c05f5f90>] (dump_stack+0x70/0x90)
[<c05f5f20>] (dump_stack) from [<c00233a0>] (warn_slowpath_common+0x6c/0x8c)
 r4:00000000 r3:d7c75a00
[<c0023334>] (warn_slowpath_common) from [<c00233e4>] (warn_slowpath_null+0x24/0x2c)
 r8:db2a6000 r7:db2a6410 r6:db2a64c0 r5:dae7b280 r4:db32ea00
[<c00233c0>] (warn_slowpath_null) from [<c0300654>] (drm_framebuffer_remove+0x10c/0x118)
[<c0300548>] (drm_framebuffer_remove) from [<c0300800>] (drm_mode_config_cleanup+0x1a0/0x25c)
 r10:00200200 r9:00100100 r8:db2a64cc r7:db2a6410 r6:db2a64c0 r5:db2a6000
 r4:db32ea00
[<c0300660>] (drm_mode_config_cleanup) from [<c0465494>] (imx_drm_driver_unload+0x1c/0x2c)
 r10:db286000 r9:c06679c8 r8:00000008 r7:c0872568 r6:db29b810 r5:c087265c
 r4:db280f00 r3:d7c75a00
[<c0465478>] (imx_drm_driver_unload) from [<c02fa29c>] (drm_put_dev+0x50/0x154)
 r4:db2a6000 r3:c0465478
[<c02fa24c>] (drm_put_dev) from [<c02fb900>] (drm_platform_exit+0x38/0x5c)
 r7:00000008 r6:db29b810 r5:c087265c r4:c087265c
[<c02fb8c8>] (drm_platform_exit) from [<c0464d54>] (imx_drm_platform_remove+0x1c/0x24)
 r5:c0872678 r4:db29b810
[<c0464d38>] (imx_drm_platform_remove) from [<c0312bfc>] (platform_drv_remove+0x20/0x24)
[<c0312bdc>] (platform_drv_remove) from [<c03113b0>] (__device_release_driver+0x78/0xd4)
[<c0311338>] (__device_release_driver) from [<c0311434>] (device_release_driver+0x28/0x34)
 r5:db29b810 r4:db29b844
[<c031140c>] (device_release_driver) from [<c03103ac>] (unbind_store+0x80/0x98)
 r5:c085b588 r4:c0872678
[<c031032c>] (unbind_store) from [<c030f934>] (drv_attr_store+0x28/0x34)
 r7:db28c280 r6:d7d9ff70 r5:d7d9a898 r4:d7d9a880
[<c030f90c>] (drv_attr_store) from [<c013d7d0>] (sysfs_write_file+0x108/0x188)
[<c013d6c8>] (sysfs_write_file) from [<c00db77c>] (vfs_write+0xd0/0x19c)
 r10:00000008 r9:00000000 r8:00000000 r7:d7d9ff70 r6:0132f408 r5:00000008
 r4:d7df5d00 r3:d7d9ff70
[<c00db6ac>] (vfs_write) from [<c00dbb58>] (SyS_write+0x4c/0x78)
 r10:00000008 r8:00000000 r7:0132f408 r6:d7d9ff70 r5:00000000 r4:d7df5d00
[<c00dbb0c>] (SyS_write) from [<c000e980>] (ret_fast_syscall+0x0/0x48)
 r10:00000000 r9:d7d9e000 r8:c000eb44 r7:00000004 r6:0132f408 r5:00000008
 r4:b6f72a78
---[ end trace 44f221ca42d7ae55 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 997 at /home/rmk/git/linux-rmk/drivers/gpu/drm/drm_mm.c:578 drm_mm_takedown+0x2c/0x34()
Memory manager not clean during takedown.
Modules linked in: fuse bnep rfcomm bluetooth
CPU: 0 PID: 997 Comm: bash Tainted: G        W    3.12.0-rc4+ #127
Backtrace: 
[<c001218c>] (dump_backtrace) from [<c0012328>] (show_stack+0x18/0x1c)
 r6:c065dbc8 r5:00000242 r4:00000000 r3:00000000
[<c0012310>] (show_stack) from [<c05f5f90>] (dump_stack+0x70/0x90)
[<c05f5f20>] (dump_stack) from [<c00233a0>] (warn_slowpath_common+0x6c/0x8c)
 r4:d7d9fdf8 r3:d7c75a00
[<c0023334>] (warn_slowpath_common) from [<c0023464>] (warn_slowpath_fmt+0x38/0x40)
 r8:00000008 r7:c0872568 r6:db2a6110 r5:db286080 r4:db286080
[<c0023430>] (warn_slowpath_fmt) from [<c02fd5f0>] (drm_mm_takedown+0x2c/0x34)
 r3:db2860ac r2:c065dbfc
[<c02fd5c4>] (drm_mm_takedown) from [<c030b3d0>] (drm_vma_offset_manager_destroy+0x1c/0x28)
[<c030b3b4>] (drm_vma_offset_manager_destroy) from [<c02f6d94>] (drm_gem_destroy+0x1c/0x30)
 r4:db2a6000 r3:00003000
[<c02f6d78>] (drm_gem_destroy) from [<c02fa384>] (drm_put_dev+0x138/0x154)
 r5:db2a6110 r4:db2a6000
[<c02fa24c>] (drm_put_dev) from [<c02fb900>] (drm_platform_exit+0x38/0x5c)
 r7:00000008 r6:db29b810 r5:c087265c r4:c087265c
[<c02fb8c8>] (drm_platform_exit) from [<c0464d54>] (imx_drm_platform_remove+0x1c/0x24)
 r5:c0872678 r4:db29b810
[<c0464d38>] (imx_drm_platform_remove) from [<c0312bfc>] (platform_drv_remove+0x20/0x24)
[<c0312bdc>] (platform_drv_remove) from [<c03113b0>] (__device_release_driver+0x78/0xd4)
[<c0311338>] (__device_release_driver) from [<c0311434>] (device_release_driver+0x28/0x34)
 r5:db29b810 r4:db29b844
[<c031140c>] (device_release_driver) from [<c03103ac>] (unbind_store+0x80/0x98)
 r5:c085b588 r4:c0872678
[<c031032c>] (unbind_store) from [<c030f934>] (drv_attr_store+0x28/0x34)
 r7:db28c280 r6:d7d9ff70 r5:d7d9a898 r4:d7d9a880
[<c030f90c>] (drv_attr_store) from [<c013d7d0>] (sysfs_write_file+0x108/0x188)
[<c013d6c8>] (sysfs_write_file) from [<c00db77c>] (vfs_write+0xd0/0x19c)
 r10:00000008 r9:00000000 r8:00000000 r7:d7d9ff70 r6:0132f408 r5:00000008
 r4:d7df5d00 r3:d7d9ff70
[<c00db6ac>] (vfs_write) from [<c00dbb58>] (SyS_write+0x4c/0x78)
 r10:00000008 r8:00000000 r7:0132f408 r6:d7d9ff70 r5:00000000 r4:d7df5d00
[<c00dbb0c>] (SyS_write) from [<c000e980>] (ret_fast_syscall+0x0/0x48)
 r10:00000000 r9:d7d9e000 r8:c000eb44 r7:00000004 r6:0132f408 r5:00000008
 r4:b6f72a78
---[ end trace 44f221ca42d7ae56 ]---
[drm] Module unloaded
Alignment trap: not handling instruction e1932f9f at [<c00758ec>]
Unhandled fault: alignment exception (0x001) at 0x63700b11
Internal error: : 1 [#1] SMP ARM
Modules linked in: fuse bnep rfcomm bluetooth
CPU: 0 PID: 1050 Comm: reboot Tainted: G        W    3.12.0-rc4+ #127
task: d7f68000 ti: d7f4a000 task.ti: d7f4a000
PC is at __lock_acquire+0x1a8/0x1e14
LR is at lock_acquire+0x68/0x7c
pc : [<c00758f0>]    lr : [<c0077aa8>]    psr: 200f0093
sp : d7f4bd18  ip : 00000000  fp : d7f4bda4
r10: db2ac07c  r9 : 00000000  r8 : 63700a0d
r7 : c0846208  r6 : c08852cc  r5 : d7f68000  r4 : 00000002
r3 : 63700b11  r2 : db2ac07c  r1 : 00000001  r0 : d7f4a000
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 27f0404a  DAC: 00000015
Process reboot (pid: 1050, stack limit = 0xd7f4a240)
Stack: (0xd7f4bd18 to 0xd7f4c000)
bd00:                                                       d7f4bdb4 00000002
bd20: d7f68000 c08852cc 00000001 00000074 00000002 db83ac18 d7f4bdd4 00000000
bd40: c0075a50 c0075050 c00782f8 d7f4a000 8c10a086 0000000a 00000000 d7f4a000
bd60: c0cd22f0 d7f683a0 d7f4bdac 00000000 00546074 00000000 c098f118 00000000
bd80: d7f4a000 600f0013 d7f68000 d7f4a000 d7f4a000 d7f68000 d7f4bddc d7f4bda8
bda0: c0077aa8 c0075754 00000002 00000000 00000000 c030f814 00000000 c088131c
bdc0: db2ac044 c030f814 c08852cc 00000000 d7f4be34 d7f4bde0 c05f80c4 c0077a4c
bde0: 00000002 00000000 c030f814 c0dc5b64 db2acc1c db83ac08 db2ac010 c0dc5b64
be00: db2b0024 c088131c db83ac08 db2b0018 db2ac010 c0dc5b64 db2b0024 c088131c
be20: d7f4a000 00000000 d7f4be5c d7f4be38 c030f814 c05f8074 c0883788 00000000
be40: c0844cc8 00000000 00000003 c000eb44 d7f4be6c d7f4be60 c0048988 c030f74c
be60: d7f4be84 d7f4be70 c00489a0 c0048958 01234567 4321fedc d7f4bfa4 d7f4be88
be80: c0048af4 c0048998 000000a8 db3bee50 00076046 00000000 0000000e d7f4a000
bea0: d7f4bea0 db42310c d7f4bea8 00000000 00000000 00000000 db265970 00000001
bec0: d7f4bedc d7f4bed0 c00a9050 00000000 d7f4a000 600f0013 d7f68000 00000007
bee0: c084192c b6f04714 d7f4bfb0 00000000 00000000 b6f52f3c d7f4bfac d7f4bf08
bf00: c00084b0 c0019e60 00000002 db422ff0 db85d088 c0836300 c083c934 db422ff0
bf20: db422ff0 db423040 d7f4bf54 d7f4bf38 c00f47f8 d7f4a000 c000e9a4 d7f4a000
bf40: c000ea10 d7f68000 00000001 00000000 d7f4a000 b6f52f3c d7f4bf84 d7f4bf68
bf60: c00784cc c0078294 00000000 00000000 bebff7b4 00000058 d7f4bf94 d7f4bf88
bf80: c00785a4 c00783e4 00000000 00000000 bebff7b4 00000058 00000000 d7f4bfa8
bfa0: c000e980 c0048a18 00000000 00000000 fee1dead 28121969 01234567 00000003
bfc0: 00000000 00000000 bebff7b4 00000058 00000000 00000000 b6f52f3c 00000000
bfe0: 00000058 bebff624 b6ea0a1d b6e2b276 20000030 fee1dead 00222c40 002d394c
Backtrace: 
[<c0075748>] (__lock_acquire) from [<c0077aa8>] (lock_acquire+0x68/0x7c)
 r10:d7f68000 r9:d7f4a000 r8:d7f4a000 r7:d7f68000 r6:600f0013 r5:d7f4a000
 r4:00000000
[<c0077a40>] (lock_acquire) from [<c05f80c4>] (mutex_lock_nested+0x5c/0x394)
 r7:00000000 r6:c08852cc r5:c030f814 r4:db2ac044
[<c05f8068>] (mutex_lock_nested) from [<c030f814>] (device_shutdown+0xd4/0x19c)
 r10:00000000 r9:d7f4a000 r8:c088131c r7:db2b0024 r6:c0dc5b64 r5:db2ac010
 r4:db2b0018
[<c030f740>] (device_shutdown) from [<c0048988>] (kernel_restart_prepare+0x3c/0x40)
 r8:c000eb44 r7:00000003 r6:00000000 r5:c0844cc8 r4:00000000 r3:c0883788
[<c004894c>] (kernel_restart_prepare) from [<c00489a0>] (kernel_restart+0x14/0x68)
[<c004898c>] (kernel_restart) from [<c0048af4>] (SyS_reboot+0xe8/0x1cc)
 r4:4321fedc r3:01234567
[<c0048a0c>] (SyS_reboot) from [<c000e980>] (ret_fast_syscall+0x0/0x48)
 r7:00000058 r6:bebff7b4 r5:00000000 r4:00000000
Code: 0affffbd e2883f41 f593f000 e1932f9f (e2822001) 
---[ end trace 44f221ca42d7ae57 ]---
