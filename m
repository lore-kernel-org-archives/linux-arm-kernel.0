From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 26 Aug 2014 14:05:17 -0400
Subject: Generic communication of boot loader state to the OS
In-Reply-To: <20140826171658.GJ4078@leverpostej>
References: <CAKON4Oz-PRgXyNKj=T9ymzOOhCMPjBMdYdE1Mr1CHWv3boskiw@mail.gmail.com>
 <20140826171658.GJ4078@leverpostej>
Message-ID: <CAKON4OzwzGjtPBN6yTCSrqX1bzpGxQwh8bU_D1MSU_XYRts65Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 1:16 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Jon,
>
> On Tue, Aug 26, 2014 at 05:10:00PM +0100, jonsmirl at gmail.com wrote:
>> New thread split off from the simple-framebuffer discussion....
>>
>> Is there a generic, underlying problem here that needs to be solved?
>> AFAIK no one has designed a general purpose mechanism for
>> communicating boot loader state to the OS. There is the existing
>> device tree <chosen> node but it is limited compared to what is
>> needed. Maybe we should step back and first design a good solution to
>> this basic problem. Then specific solutions for things like
>> framebuffers would fall out of the basic design.
>
> I think the fundamental problem here is unfortunately far too abstract
> for the general solution to be any more concrete. The solution to "we
> don't communicate boot state" is "we should communicate boot state".
>
> We can perhaps come up with general guidelines (for instance, the clock
> subsystem has assigned-* properties), but I don't think there's a
> one-size-fits-all solution.
>
>> So what are the requirements?
>> 1) Indicate that the boot loader has set up a device
>> 2) Indicate the purpose of that device
>> 3) Protect the resources in use
>> 4) Provide for a handoff to the OS specific device driver
>> 5) Communicate all of this via the device tree
>>
>> So what is a device tree syntax that would solve this general problem?
>> As a first design attempt, I would propose <boot> (or <chosen>) child
>> nodes be added to the various core devices. By core device I mean the
>> top level device, like the framebuffer, not each dependent clock and
>> regulator.
>>
>> Inside the <boot> nodes a compatible string would be used to designate
>> a device class the bootloader has assigned to the devices. For example
>> - serial, framebuffer, media, input, network.
>
> In general we should already know the class of device if we have a
> driver for said device, no?
>
> As far as I can tell all we need to have is a way of designating
> preferred devices and their preferred/current configuration. We have
> bits of that already (e.g. stdout-path, assigned-rate).
>
>> Some examples, I've deleted a lot of properties to make them smaller.
>> The boot loader could add these nodes either statically or
>> dynamically.
>>
>> uart0: uart at 01c18000 {
>>         compatible = "allwinner,sun4i-a10-uart";
>>         clocks = <&ahb_gates 20>, <&uart2_clk>;
>>         clock-names = "ahb", "mod";
>>         boot {
>>                 compatible = "boot,serial";
>>                 baud = <192000>;
>>                 console;
>>        };
>> };
>
> There's already the stdout-path (and stdin-path) binding for designating
> a serial port. I think we should improve support for those rather than
> introducing a new binding. The only painful part is describing the
> pre-configured rate if the OS needs to know.
>
>> reserved-memory {
>>         display_reserved: framebuffer at 78000000 {
>>                 reg = <0x78000000 0x800000>;
>>         };
>> };
>>
>> fb0: fb at 01c10000 {
>>         compatible = "allwinner,sun4i-a10-framebuffer";
>>         clocks = <&ahb_gates 18>, <&fb2_clk>;
>>         clock-names = "ahb", "mod";
>>         boot {
>>                 compatible = "boot,framebuffer";
>>                 memory-region = <&display_reserved>;
>>         };
>> };
>
> I was under the impression that the reserved-memory binding could be
> used for handing over the memory in use by a framebuffer, so as far as I
> can see we only new thing to communicate would be the configured mode of
> the display.
>
> Do we have any systems with multiple displays where we need to specify
> which is preferred?
>
>> spi1: spi at 01c16000 {
>>         compatible = "allwinner,sun4i-a10-spi";
>>         clocks = <&ahb_gates 22>, <&spi2_clk>;
>>         clock-names = "ahb", "mod";
>>
>>         flash0: flash at 2 {
>>         compatible = "atmel,at12345";
>>         reg = <2>;
>>         spi-max-frequency = <100000>;
>>                 boot {
>>                         compatible = "boot,media";
>>                 };
>>         };
>> };
>
> Is this a problem on existing systems? Do we need a DT property?
>
> If so, this would be better as something like /chosen/root-device (so
> you can't accidentally describe multiple devices as the boot medium).
>
>> An OS booting off from a device tree like this can then implement
>> support for boot,xxxx drivers if it chooses. If it doesn't implement
>> support for the boot tags, nothing changes from the current situation.
>>
>> The problem with clocks and regulators can be addressed by following
>> the chains of clocks/regulators in the parent nodes of the boot
>> sections. This would be implement by these frameworks providing a
>> "claim_all_xxx(DT node)" function.  A boot,framebuffer driver would
>> first call claim_all_clk(parent node) and claim_all_regulator(parent
>> node). Need to figure out exactly how these functions would work.
>
> I'm not sure I follow. What is the problem with clocks and regulators
> that this tries to solve?
>
> Are we just trying to leave them in their current configuration (rather
> than disabling)? Are we trying to prevent other drivers from fiddling
> with them? Something else?

The current problem with simple-fb is that the clock subsystem
contains code to automatically shut off clocks that aren't in use. A
similar problem exists for regulators. And I agree that code like that
makes sense.

Simplefb does not mark these items as being in use, so they get shut
off. So how can we communicate to these subsystems that these
clocks/regulators are actually in use by simple-fb? Simple-fb is
generic code and it does not know about specific devices or clocks or
regulators.

Uboot could individually mark each one.  But then how does uboot tell
the OS that a simple-fb has been set up? You could make a node like
'chosen/framebuffer'. But then how do you tell where the reserved
memory is? Making a <boot> node inside the specific device makes more
sense to me. That also makes it easy to determine what
clock/regulators apply.

Also note that things like the console are also vulnerable to this. If
I switch from a built-in serial driver over to a modprobe one, the
UART clocks will get disabled in the interval between the clk shut off
code and the loading of the module. This is the same window that makes
the framebuffer flicker during boot.  And generic ARM kernels modprobe
in all of their drivers.

>
>> Driver handoff is the OS's problem. Under Linux the device specific
>> drivers could soft-link to the boot,xxx code. After the device
>> specific driver is fully initialized it would tell the boot,xxx driver
>> to let go.
>
> I'm not sure I follow why we need the stub drivers at all. Is the idea
> to just have them hog resources until the real driver comes up?
>
>> As a side effect this will eliminate the need for kernel command line
>> parameters describing boot state. Like console="". Over time it might
>> even be able to pass a DHCP IP address from uboot into the kernel.
>
> We have a generic mechanism for communicating the MAC address of an
> ethernet adapter. I don't see a fundamental reason we can't add
> properties to communicate a DHCP lease and associated information. Is
> anyone looking into that?
>
> Thanks,
> Mark.



-- 
Jon Smirl
jonsmirl at gmail.com
