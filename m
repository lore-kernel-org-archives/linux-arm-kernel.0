From: cjb@laptop.org (Chris Ball)
Date: Mon, 04 Jun 2012 20:08:06 -0400
Subject: [PATCH v2 8/9] ARM: dts: refresh dts file for arch mmp
In-Reply-To: <1336134626-12262-9-git-send-email-haojian.zhuang@gmail.com>
 (Haojian Zhuang's message of "Fri, 4 May 2012 20:30:25 +0800")
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
 <1336134626-12262-9-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <87d35ezkm1.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Fri, May 04 2012, Haojian Zhuang wrote:
> Append mmp2 and pxa910 dts files. Update PXA168 dts files for irq,
> timer, gpio components.

The patch I'm replying to introduced a device tree for MMP2/Brownstone
in 3.5-rc1.  We're looking at adopting the MMP2 device tree for the OLPC
XO-1.75 board, and Mitch Bradley has some corrections to the device tree
format that we'd like to make, appended below.

You can see all of the files Mitch mentions at:
http://dev.laptop.org/~wmb/mmp2-devicetree/

Here's my proposal for what to do next:
 * First, you choose one of the two forms that Mitch links to.
   (Either "mmp2.dtsi" or "mmp2-flat.dtsi"; we have a weak preference
   for mmp2-flat.dtsi.)
 * Then we'll post patches that modify the arch code to handle the new
   DT format, and ask for your testing and ACK.
 * We can try to merge the modified .dts files and .c code to 3.5/3.6.
 * We'll work on merging XO-1.75 support into mainline and adding DT
   support for new devices, too.

What do you think?

Thanks,

- Chris.

==
Mitch's DT review:

This directory (http://dev.laptop.org/~wmb/mmp2-devicetree) contains
modified versions of the MMP2 device tree files.  They are based on the
versions from:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ff290fc3ed7c4f451ea029190624cff692f028a5

I present them as complete files, rather than as patches, because
indentation depth changes cause nearly every line to be different.

The basic reason for the change is because the existing structure is an
ad-hoc and inaccurate representation of the system.  With a SoC system
where the buses are internal and largely software-transparent, there are
two basic self-consistent approaches that one can take.

One approach is to model the software view of addressing, hiding all
"transparent" details of the bus structure.

The other approach is to model the hardware structure accurately,
exposing the actual bus hierarchy.

The existing MMP2 device tree is somewhere in the middle.  It exposes
the AXI and APB buses, but the device tree hierarchy does not match the
actual bus hierarchy.  In particular, the APB bus is subordinate to the
AXI bus in the hardware, but in the device tree they are peers.

I present two different modified MMP2 device trees:

    mmp2.dtsi / mmp2-brownstone.dts :
           This is the hardware-centric view.  It models the AXI / APB
           bus hierarchy, translating address ranges accurately via the
           "ranges" proper.  APB is subordinate to AXI.  Device
           addresses are relative to their parent bus.

    mmp2-flat.dtsi / mmp2-brownstone-flat.dts :
           This is the software-centric view.  There are no bus nodes
           for AXI or APB.  The devices are just children of the root
           node "bus", with absolute addresses.

In addition to the structural changes, the following other things were
fixed:

a) Removed the "twsi2" device node.  The address that was given for that
node does not match any of the TWSI devices listed in the MMP2
documentation.  I think that it was an editing mistake, as it matches
the PXA168 TWSI2 device.

b) Removed the "soc" node and moved its "interrupt-parent" property to
the root node (for the flat version) or the axi node (for the
hierarchical version).  There is no need for a "soc" node; it has no
function.

c) Removed the "reg" property from the axi and apb nodes.  It is
incorrect to list a memory-mapped bus's pass-through address range in a
"reg" property.  The only case where a memory-mapped bus would have a
"reg" property is when the bus controller has additional control
registers (in its parent's address space) separate from the address
range that is passed through to the children.  The correct way to
specify the pass-through address range is with the "ranges" property.

d) Moved the "intcmux" nodes down a level so they are children of the
top-level interrupt-controller node.  The problem with having them as
peers of the top-level interrupt-controller is that their "reg"
properties conflict.  For example:
intcmux4 at d4282150 { ... reg = <0x150 0x4>, <0x168 0x4> ... }

This is incorrect in several ways:

   1) "@d4282150" is inconsistent with "reg = <0x150" .  The "unit
      address" after @ is supposed to be the same as the first component
      of the reg property.  d4282150 is not identical to 150.

   2) The reg property is interpreted in the parent address space.  In
      the existing MMP2 device tree addressing structure, the parent
      address space for the intcmux nodes is absolute, so address 0x150
      is part of the DRAM.  The reg property address would need to be
      0xd4282150.

   3) If the reg property were 0xd4282150, it would conflict with the
      reg property of the top-level interrupt-controller, which "claims"
      0x1000 bytes of address space starting at 0xd42082000.

The solution is to put the intcmux nodes underneath the
interrupt-controller node.  The interrupt-controller node now has
#address-cells and #size-cells properties so it can have children, but
it does not have a ranges property, so the address space is not passed
through.  The child (intcmux) reg addresses can then be interpreted
independently, without conflict.

e) The AXI bus address space is actually larger than the existing MMP2
device tree implies.  According to the MMP2 datasheet, the range from
0xD400_0000 to 0xD401_0000 is AXI (PDMA controller).  AXI space also
extends up to address 0xF800_0000, and there are some devices up above
0xF000_0000 - USB SPH, ULPI, ISP, EPD, and VMeta config.  So (in the
hierarchical version), the AXI ranges property encompasses the full
range from 0xD400_0000 up to 0xF800_0000.

f) The APB bus address space does not start at 0xD400_0000, but
rather at 0xD401_0000.

g) For the reasons mentioned in point (c), the top-level gpio node
cannot have both a ranges property (to pass through the address space)
and also a reg property claiming that address space.  The solution is to
remove its ranges property, adjusting its children's (gcb nodes)
addresses to be offsets within a private (not pass-through) address
space.

h) The "model" property in mmp2-brownstone.dts said "Aspenite".
I changed it to "Brownstone".

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
