From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 19 Dec 2012 10:25:35 -0500
Subject: [Xen-devel] [PATCH v2 5/6] ARM: Dummy Virtual Machine platform
 support
In-Reply-To: <50D0B384.40605@arm.com>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
 <1355762141-29616-6-git-send-email-will.deacon@arm.com>
 <alpine.DEB.2.02.1212181202310.17523@kaball.uk.xensource.com>
 <20121218131401.GB22139@mudshark.cambridge.arm.com>
 <50D0AF5C.1070605@codeaurora.org> <50D0B384.40605@arm.com>
Message-ID: <50D1DC6F.3010304@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2012 01:18 PM, Marc Zyngier wrote:
> Hi Christopher,
> 
> On 18/12/12 18:01, Christopher Covington wrote:
>> Hi Will,
>>
>> On 12/18/2012 08:14 AM, Will Deacon wrote:
>>> Hi Stefano,
>>>

[...]

>>
>>> The only things the platform needs are GIC, timers, memory and a CPU.
>>
>> I assume multiple virtio-mmio peripherals are hiding behind what you seem to
>> be advertising here as plain old memory?
> 
> No. Memory is memory. Virtio peripherals are created outside of the 
> memory range. They end up having rings and descriptor in memory, but 
> that's not any different from what you have with an fairly complicated 
> DMA capable hardware device.

Sure, but I would consider such a device to be part of the platform (or
perhaps there's some better name to group together the set of devices that
are expected to modify memory?), and I was trying to fish for what additional
devices might be part of the platform on a regular basis, like what
console(s) and network interface(s).

> Here's what kvmtool has been seen to generate, with the parameters I used
> a few minutes ago:
>
> /dts-v1/;
> 
> /memreserve/	0x000000008fff0000 0x0000000000001000;
> / {
> 	interrupt-parent = <0x1>;
> 	compatible = "linux,dummy-virt";

Might it make sense to call this a generic ARM platform, using something
roughly in the direction of "linux,arm-generic" here and
s/mach-virt/mach-generic/ in the paths? Then any device-tree enabled ARMv7
platform using the generic timer and interrupt controller could reuse this
definition. This machine/platform seems like it could prove useful in
simulation and hardware scenarios. Would, for example, a fully-DT-enabled
Versatile Express machine converge on this definition? I wonder if it might
also be useful as a simple example with which to test out code sharing
between arch/arm and arch/arm64.

[...]
 
> Does it help?

Yes, thanks!

[...]
 
> What would be the point of using DCC?

It seemed like ARM-Ltd.-architected peripherals were picked for the timer and
interrupt controller, so I wondered why not for the console as well. As best
I'm aware, unless one ventures into the PrimeCell line with the PL011, DCC is
the closest match for an officially architected console mechanism.

> We would have to trap on each access...

Now that you point his out, this would indeed be fundamentally different than how
the coprocessor-register-accessed generic timer is handled, because the
virtualization extensions mean the hypervisor just needs to handle setup and
switching, but not intervention during normal operation.

This is drifting a bit off-topic to this particular patchset, but while I'm
on the topic of coprocessor register accesses in a virtualized environment,
is there a plan or are there existing mechanisms for handling the performance
counters? Do ID or cache or other register accesses need to be trapped?
Perhaps there are existing threads or portions of code on the topic that I've
overlooked.

> ...and then we'd have to invent yet another mechanism to channel the
> console to userspace.

What mechanism does virtio-mmio support in KVM use to channel the console to
userspace? Would there be a fundamental difference?

It seemed like Will was trying to frame the changes as _whether_ to support
various peripheral devices, because some of them aren't "needed" for an
artificial use case. I would rather frame the implementation decisions as
_which_ devices are going to be supported in the foreseeable future by your
work. Choosing a virtio-mmio console over DCC, semihosting, ram buffer, UART,
and whatever other alternatives there might be impacts someone trying to put
together a Linux image that boots on some combination of simulation,
virtualization, and hardware.

If one puts together a Linux image that uses a UART on hardware and a
virtio-mmio console in a virtualized environment, I would argue that this
image has some incrementally higher debug and maintenance cost than an image
that has the same console mechanism across all platforms. On the other hand,
perhaps the cost of implementing a uniform mechanism across all platforms is
higher still.

> Not to mention that I like to be able to actually input something on a console,
> not just read from it.

Perhaps there's some misunderstanding here. The Debug Communications Channel
that I'm familiar with is fully capable of both input and output.

http://infocenter.arm.com/help/topic/com.arm.doc.dui0471c/BEIHGIBB.html
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/tty/hvc/hvc_dcc.c

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
