From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Oct 2013 01:04:34 +0100
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131016183107.GC18050@kroah.com>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
 <20131015131038.GB25034@n2100.arm.linux.org.uk>
 <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
 <20131016170341.GH25034@n2100.arm.linux.org.uk>
 <20131016180735.GI25034@n2100.arm.linux.org.uk>
 <20131016183107.GC18050@kroah.com>
Message-ID: <20131020000434.GL25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 11:31:07AM -0700, Greg Kroah-Hartman wrote:
> On Wed, Oct 16, 2013 at 07:07:35PM +0100, Russell King - ARM Linux wrote:
> > Sorry, but I don't think imx-drm is driving the hardware correctly, and
> > I know that Greg wants it moved out of drivers/staging, but frankly it
> > seems to be far from ready for that.  Certainly the HDMI parts seems to
> > be especially problematical.
> 
> I want it out of staging if it's working properly.  Yours is the first
> report of it not working properly, and in fact, probably one of the
> first users of the driver, as I haven't gotten any reports of it working
> or not at all over the years.

Next problem... unbinding, rebinding, and then unbinding the imx-drm
device produces the nice oops below.  I've not debugged this yet.

Alignment trap: not handling instruction e1932f9f at [<c00758ec>]
Unhandled fault: alignment exception (0x001) at 0x6e72666f
Internal error: : 1 [#1] SMP ARM
Modules linked in: fuse bnep rfcomm bluetooth
CPU: 0 PID: 1125 Comm: bash Tainted: G        W    3.12.0-rc4+ #123
task: d0d6ec00 ti: d7ff2000 task.ti: d7ff2000
PC is at __lock_acquire+0x1a8/0x1e14
LR is at lock_acquire+0x68/0x7c
pc : [<c00758f0>]    lr : [<c0077aa8>]    psr: 20070093
sp : d7ff3cc8  ip : 00000000  fp : d7ff3d54
r10: db2a6334  r9 : 00000000  r8 : 6e72656b
r7 : c0846208  r6 : c08852cc  r5 : d0d6ec00  r4 : 00000002
r3 : 6e72666f  r2 : db2a6334  r1 : 00000001  r0 : d7ff2000
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 20df804a  DAC: 00000015
Process bash (pid: 1125, stack limit = 0xd7ff2240)
Stack: (0xd7ff3cc8 to 0xd7ff4000)
3cc0:                   00000006 00000007 c0cd22f0 00000006 d7ff3d1c d7ff3ce8
3ce0: c00782f8 c0075050 00000001 00000000 db801f00 d7ff2000 c0078648 d7ff2000
3d00: 00000001 d7ff3e08 d7ff3e60 d7ff3dd8 d7ff3d3c d7ff3d20 00000000 d7ff3e08
3d20: d7ff3d7c d7ff3d30 c0072a58 00000000 d7ff2000 60070013 d0d6ec00 d7ff2000
3d40: c06679c8 d0d6ec00 d7ff3d8c d7ff3d58 c0077aa8 c0075754 00000002 00000000
3d60: 00000000 c02ff27c 00000000 00000002 db2a62fc c02ff27c c08852cc 00000000
3d80: d7ff3de4 d7ff3d90 c05f80c4 c0077a4c 00000002 00000000 c02ff27c c0072a20
3da0: dad64000 d7ff3e24 d7ff3df8 d7ff3e04 d7ff3e5c d0d6f000 c013f1c8 db322880
3dc0: db2a6440 db2a6000 c0872568 00000008 c06679c8 db286000 d7ff3e04 d7ff3de8
3de0: c02ff27c c05f8074 db280f00 db322880 db2a6000 db29b810 d7ff3e1c d7ff3e08
3e00: c02f13ac c02ff268 d0e55000 c087265c d7ff3e2c d7ff3e20 c0464d7c c02f1398
3e20: d7ff3e54 d7ff3e30 c02f506c c0464d68 d0e55000 c087265c db29b810 c0872568
3e40: 00000008 db286000 d7ff3e74 d7ff3e58 c02fa284 c02f503c c087265c c087265c
3e60: db29b810 00000008 d7ff3e8c d7ff3e78 c02fb900 c02fa258 db29b810 c0872678
3e80: d7ff3e9c d7ff3e90 c0464d54 c02fb8d4 d7ff3eac d7ff3ea0 c0312bfc c0464d44
3ea0: d7ff3ec4 d7ff3eb0 c03113b0 c0312be8 db29b844 db29b810 d7ff3edc d7ff3ec8
3ec0: c0311434 c0311344 c0872678 c085b588 d7ff3efc d7ff3ee0 c03103ac c0311418
3ee0: c941b300 c941b318 d7ff3f70 db28c280 d7ff3f0c d7ff3f00 c030f934 c0310338
3f00: d7ff3f3c d7ff3f10 c013d7d0 c030f918 d7ff3f70 dbb5e600 00000008 003ba408
3f20: d7ff3f70 00000000 00000000 00000008 d7ff3f6c d7ff3f40 c00db77c c013d6d4
3f40: 00000001 c000eb44 dbb5e600 00000000 d7ff3f70 003ba408 00000000 00000008
3f60: d7ff3fa4 d7ff3f70 c00dbb58 c00db6b8 00000000 00000000 d7ff3f94 b6f7fa78
3f80: 00000008 003ba408 00000004 c000eb44 d7ff2000 00000000 00000000 d7ff3fa8
3fa0: c000e980 c00dbb18 b6f7fa78 00000008 00000001 003ba408 00000008 00000000
3fc0: b6f7fa78 00000008 003ba408 00000004 bee5c9ec 000a6094 00000000 003f7f08
3fe0: 00000000 bee5c96c b6eee747 b6f2611c 40070010 00000001 00000138 00000020
Backtrace: 
[<c0075748>] (__lock_acquire+0x0/0x1e14) from [<c0077aa8>] (lock_acquire+0x68/0x7c)
[<c0077a40>] (lock_acquire+0x0/0x7c) from [<c05f80c4>] (mutex_lock_nested+0x5c/0x394)
 r7:00000000 r6:c08852cc r5:c02ff27c r4:db2a62fc
[<c05f8068>] (mutex_lock_nested+0x0/0x394) from [<c02ff27c>] (drm_modeset_lock_all+0x20/0x58)
[<c02ff25c>] (drm_modeset_lock_all+0x0/0x58) from [<c02f13ac>] (drm_fbdev_cma_restore_mode+0x20/0x34)
 r6:db29b810 r5:db2a6000 r4:db322880 r3:db280f00
[<c02f138c>] (drm_fbdev_cma_restore_mode+0x0/0x34) from [<c0464d7c>] (imx_drm_driver_lastclose+0x20/0x24)
 r5:c087265c r4:d0e55000
[<c0464d5c>] (imx_drm_driver_lastclose+0x0/0x24) from [<c02f506c>] (drm_lastclose+0x3c/0x174)
[<c02f5030>] (drm_lastclose+0x0/0x174) from [<c02fa284>] (drm_put_dev+0x38/0x154)
[<c02fa24c>] (drm_put_dev+0x0/0x154) from [<c02fb900>] (drm_platform_exit+0x38/0x5c)
 r7:00000008 r6:db29b810 r5:c087265c r4:c087265c
[<c02fb8c8>] (drm_platform_exit+0x0/0x5c) from [<c0464d54>] (imx_drm_platform_remove+0x1c/0x24)
 r5:c0872678 r4:db29b810
[<c0464d38>] (imx_drm_platform_remove+0x0/0x24) from [<c0312bfc>] (platform_drv_remove+0x20/0x24)
[<c0312bdc>] (platform_drv_remove+0x0/0x24) from [<c03113b0>] (__device_release_driver+0x78/0xd4)
[<c0311338>] (__device_release_driver+0x0/0xd4) from [<c0311434>] (device_release_driver+0x28/0x34)
 r5:db29b810 r4:db29b844
[<c031140c>] (device_release_driver+0x0/0x34) from [<c03103ac>] (unbind_store+0x80/0x98)
 r5:c085b588 r4:c0872678
[<c031032c>] (unbind_store+0x0/0x98) from [<c030f934>] (drv_attr_store+0x28/0x34)
 r7:db28c280 r6:d7ff3f70 r5:c941b318 r4:c941b300
[<c030f90c>] (drv_attr_store+0x0/0x34) from [<c013d7d0>] (sysfs_write_file+0x108/0x188)
[<c013d6c8>] (sysfs_write_file+0x0/0x188) from [<c00db77c>] (vfs_write+0xd0/0x19c)
[<c00db6ac>] (vfs_write+0x0/0x19c) from [<c00dbb58>] (SyS_write+0x4c/0x78)
[<c00dbb0c>] (SyS_write+0x0/0x78) from [<c000e980>] (ret_fast_syscall+0x0/0x48)
Code: 0affffbd e2883f41 f593f000 e1932f9f (e2822001) 
---[ end trace f2924517b64a28f4 ]---
