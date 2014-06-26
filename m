From: rabin@rab.in (Rabin Vincent)
Date: Thu, 26 Jun 2014 21:39:38 +0200
Subject: [PATCH] ARM: integrator: fix OF-related regression
In-Reply-To: <CACRpkdZr6T65zOmxy9mQdeapMfu=nwfcXRtufb5DU5NO+vwU7A@mail.gmail.com>
References: <1403611687-23512-1-git-send-email-linus.walleij@linaro.org>
 <CAL_Jsq+Us51c-6+kP5Y+aML-HPV-=9SooPepD6u13xyrvDfcKw@mail.gmail.com>
 <CACRpkdZr6T65zOmxy9mQdeapMfu=nwfcXRtufb5DU5NO+vwU7A@mail.gmail.com>
Message-ID: <20140626193938.GA16226@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 02:15:42PM +0200, Linus Walleij wrote:
> On Wed, Jun 25, 2014 at 3:06 PM, Rob Herring <robherring2@gmail.com> wrote:
> > On Tue, Jun 24, 2014 at 7:08 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> >> Commit 07e461cd7e73a84f0e3757932b93cc80976fd749
> >> "of: Ensure unique names without sacrificing determinism"
> >> caused a boot failure regression on the Integrator machines.
> >>
> >> The problem is probably caused by fiddling too much with
> >> the device tree population in the OF init function, such
> >> as passing the SoC bus device as parent when populating
> >> the device tree.
> >>
> >> This patch fixes the problem by:
> >>
> >> - Avoiding to explicitly look up the tree root
> >> - Look up devices needed before device population from
> >>   the match only, passing NULL as root
> >> - Passing NULL as root and parent when calling
> >>   of_platform_populate()
> >
> > Just curious, I don't see how this fixes booting for Integrator. Where
> > exactly does boot fail?
> 
> It fails by failing to populate the devicetree somehow. I don't
> have the proper debugging needs, I just trial-and-horror-fixed
> it by making the board init similar to other platforms :-/

earlyprintk doesn't work on Integrator hardware?  It does on QEMU's
integratorcp so it's trivial to debug there.

The problem is that integrator_init_sysfs() adds a device attribute
called "fpga" to the soc0 bus, and the soc0 bus device is also used as
the root of the device tree, and the device tree has a node called "fpga".

Before 07e461cd7e73a84f0e3757932b93cc80976fd749 this node directory and
attribute file had unique paths:

	sysfs: creating file '/devices/soc0/fpga'
	sysfs: creating dir '/devices/soc0/fpga.0'

07e461cd7e73a84f0e3757932b93cc80976fd749 removed the .0 from the fpga node's
directory, leading to that node (and its subnodes) failing to register due to a
filename conflict with the fpga attribute's file:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at /home/rabin/dev/linux/fs/sysfs/dir.c:31 sysfs_warn_dup+0x54/0x74()
sysfs: cannot create duplicate filename '/devices/soc0/fpga'
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 3.15.0-rc5-00030-g244fb0a #17
[<c000ea34>] (unwind_backtrace) from [<c000c18c>] (show_stack+0x10/0x14)
[<c000c18c>] (show_stack) from [<c00193f0>] (warn_slowpath_common+0x64/0x84)
[<c00193f0>] (warn_slowpath_common) from [<c0019440>] (warn_slowpath_fmt+0x30/0x40)
[<c0019440>] (warn_slowpath_fmt) from [<c0104008>] (sysfs_warn_dup+0x54/0x74)
[<c0104008>] (sysfs_warn_dup) from [<c01040b0>] (sysfs_create_dir_ns+0x88/0x98)
[<c01040b0>] (sysfs_create_dir_ns) from [<c0188410>] (kobject_add_internal+0xac/0x2fc)
[<c0188410>] (kobject_add_internal) from [<c0188820>] (kobject_add+0x4c/0x98)
[<c0188820>] (kobject_add) from [<c01edacc>] (device_add+0xe0/0x4f0)
[<c01edacc>] (device_add) from [<c02559b0>] (of_platform_device_create_pdata+0x6c/0x8c)
[<c02559b0>] (of_platform_device_create_pdata) from [<c0255aac>] (of_platform_bus_create+0xd0/0x2b4)
[<c0255aac>] (of_platform_bus_create) from [<c0255db8>] (of_platform_populate+0x5c/0xa0)
[<c0255db8>] (of_platform_populate) from [<c0415fdc>] (customize_machine+0x20/0x44)
[<c0415fdc>] (customize_machine) from [<c0008b6c>] (do_one_initcall+0xfc/0x160)
[<c0008b6c>] (do_one_initcall) from [<c0413b40>] (kernel_init_freeable+0xf4/0x1ac)
[<c0413b40>] (kernel_init_freeable) from [<c0312b60>] (kernel_init+0x8/0xec)
[<c0312b60>] (kernel_init) from [<c0009830>] (ret_from_fork+0x14/0x24)
---[ end trace b6f453d64d825b4b ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at /home/rabin/dev/linux/lib/kobject.c:240 kobject_add_internal+0x274/0x2fc()
kobject_add_internal failed for fpga with -EEXIST, don't try to register things with the same name in the same directory.
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Tainted: G        W     3.15.0-rc5-00030-g244fb0a #17
[<c000ea34>] (unwind_backtrace) from [<c000c18c>] (show_stack+0x10/0x14)
[<c000c18c>] (show_stack) from [<c00193f0>] (warn_slowpath_common+0x64/0x84)
[<c00193f0>] (warn_slowpath_common) from [<c0019440>] (warn_slowpath_fmt+0x30/0x40)
[<c0019440>] (warn_slowpath_fmt) from [<c01885d8>] (kobject_add_internal+0x274/0x2fc)
[<c01885d8>] (kobject_add_internal) from [<c0188820>] (kobject_add+0x4c/0x98)
[<c0188820>] (kobject_add) from [<c01edacc>] (device_add+0xe0/0x4f0)
[<c01edacc>] (device_add) from [<c02559b0>] (of_platform_device_create_pdata+0x6c/0x8c)
[<c02559b0>] (of_platform_device_create_pdata) from [<c0255aac>] (of_platform_bus_create+0xd0/0x2b4)
[<c0255aac>] (of_platform_bus_create) from [<c0255db8>] (of_platform_populate+0x5c/0xa0)
[<c0255db8>] (of_platform_populate) from [<c0415fdc>] (customize_machine+0x20/0x44)
[<c0415fdc>] (customize_machine) from [<c0008b6c>] (do_one_initcall+0xfc/0x160)
[<c0008b6c>] (do_one_initcall) from [<c0413b40>] (kernel_init_freeable+0xf4/0x1ac)
[<c0413b40>] (kernel_init_freeable) from [<c0312b60>] (kernel_init+0x8/0xec)
[<c0312b60>] (kernel_init) from [<c0009830>] (ret_from_fork+0x14/0x24)
---[ end trace b6f453d64d825b4c ]---

After Linus' patch, the root is no longer soc0 so the fpga node's directory
becomes /devices/fpga while the attribute file remains at /devices/soc0/fpga.
