From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 18 Dec 2012 18:18:44 +0000
Subject: [Xen-devel] [PATCH v2 5/6] ARM: Dummy Virtual Machine platform
 support
In-Reply-To: <50D0AF5C.1070605@codeaurora.org>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
 <1355762141-29616-6-git-send-email-will.deacon@arm.com>
 <alpine.DEB.2.02.1212181202310.17523@kaball.uk.xensource.com>
 <20121218131401.GB22139@mudshark.cambridge.arm.com>
 <50D0AF5C.1070605@codeaurora.org>
Message-ID: <50D0B384.40605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On 18/12/12 18:01, Christopher Covington wrote:
> Hi Will,
> 
> On 12/18/2012 08:14 AM, Will Deacon wrote:
>> Hi Stefano,
>>
>> On Tue, Dec 18, 2012 at 12:04:38PM +0000, Stefano Stabellini wrote:
>>> On Mon, 17 Dec 2012, Will Deacon wrote:
>>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>>
>>>> Add support for the smallest, dumbest possible platform, to be
>>>> used as a guest for KVM or other hypervisors.
> 
> [...]
> 
>>> Should it come along with a DTS?
>>
>> The only things the platform needs are GIC, timers, memory and a CPU.
> 
> I assume multiple virtio-mmio peripherals are hiding behind what you seem to
> advertising here as plain old memory?

No. Memory is memory. Virtio peripherals are created outside of the 
memory range. They end up having rings and descriptor in memory, but 
that's not any different from what you have with an fairly complicated 
DMA capable hardware device.

Furthermore, even if virtio-mmio is what we use with KVM, it could be 
something radically different. Xen uses something somewhat different.
It is not even required to boot the platform!

>> Furthermore, the location, size, frequency etc properties of these aren't
>> fixed, so a dts would be fairly useless because it will probably not match
>> the particular mach-virt instance you're targetting.
> 
> I disagree. I think an example DTS would be fairly useful, if only for the
> full list of peripherals you're using on the platform.

That's the whole point: we do not want to to specify anything, because 
there is no need to. You could have anything there, depending on your hypervisor.

>> For kvmtool, I've been generating the device-tree at runtime based on how
>> kvmtool is invoked and it's been working pretty well so far.
> 
> If you'd much prefer to post the command line, tools version, etc. that you're
> using to generate the DTB, rather than the DTS, that'd be better than nothing.

Here's what kvmtool has been seen to generate, with the parameters I used
a few minutes ago:

/dts-v1/;

/memreserve/	0x000000008fff0000 0x0000000000001000;
/ {
	interrupt-parent = <0x1>;
	compatible = "linux,dummy-virt";
	#address-cells = <0x2>;
	#size-cells = <0x2>;

	chosen {
		bootargs = "console=hvc0,38400 root=/dev/vda1";
	};

	memory {
		device_type = "memory";
		reg = <0x0 0x80000000 0x0 0x40000000>;
	};

	cpus {
		#address-cells = <0x1>;
		#size-cells = <0x0>;

		cpu at 0 {
			device_type = "cpu";
			compatible = "arm,cortex-a15";
			enable-method = "psci";
			reg = <0x0>;
		};

		cpu at 1 {
			device_type = "cpu";
			compatible = "arm,cortex-a15";
			enable-method = "psci";
			reg = <0x1>;
		};
	};

	intc {
		compatible = "arm,cortex-a15-gic";
		#interrupt-cells = <0x3>;
		interrupt-controller;
		reg = <0x0 0x3ffff000 0x0 0x1000 0x0 0x3fffd000 0x0 0x2000>;
		phandle = <0x1>;
	};

	timer {
		compatible = "arm,armv7-timer";
		interrupts = <0x1 0xd 0x301 0x1 0xe 0x301 0x1 0xb 0x301 0x1 0xa 0x301>;
	};

	virtio at 0 {
		compatible = "virtio,mmio";
		reg = <0x0 0x0 0x0 0x200>;
		interrupts = <0x0 0x0 0x1>;
	};

	virtio at 200 {
		compatible = "virtio,mmio";
		reg = <0x0 0x200 0x0 0x200>;
		interrupts = <0x0 0x1 0x1>;
	};

	virtio at 400 {
		compatible = "virtio,mmio";
		reg = <0x0 0x400 0x0 0x200>;
		interrupts = <0x0 0x2 0x1>;
	};

	virtio at 600 {
		compatible = "virtio,mmio";
		reg = <0x0 0x600 0x0 0x200>;
		interrupts = <0x0 0x3 0x1>;
	};

	psci {
		compatible = "arm,psci";
		method = "hvc";
		cpu_suspend = <0x95c1ba5e>;
		cpu_off = <0x95c1ba5f>;
		cpu_on = <0x95c1ba60>;
		migrate = <0x95c1ba61>;
	};
};

Does it help?

> It seems like Rob Herring's earlier question about whether the dummy platform
> is really justified never got answered. I think sending a sample DTS out with
> the patchset would help "highlight where we need to do more work on DT driving
> the initialization."
> 
> Lastly, I'm somewhat curious, why virtio-mmio console rather than DCC?

What would be the point of using DCC? We would have to trap on each access, and
then we'd have to invent yet another mechanism to channel the console to userspace.
Not to mention that I like to be able to actually input something on a console,
not just read from it.

	M.
-- 
Jazz is not dead. It just smells funny...
