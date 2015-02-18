From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Feb 2015 16:59:42 +0100
Subject: [PATCH 01/11] mfd: add the Berlin controller driver
In-Reply-To: <5101633.XnBqLvsiGQ@wuerfel>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <20150218115853.GB22296@x1> <54E48EF0.4050807@gmail.com>
 <5101633.XnBqLvsiGQ@wuerfel>
Message-ID: <54E4B6EE.9030304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2015 04:06 PM, Arnd Bergmann wrote:
> On Wednesday 18 February 2015 14:09:04 Sebastian Hesselbarth wrote:
>> I fundamentally disagree that either this registers or syscon in general
>> should in any way be seen as a bus. The chip control registers is an
>> highly unsorted bunch of bits that we try to match with cleanly
>> separated subsystems. This makes it a resource but no bus of any sort.
>
> It really depends on what you mean by 'bus'. It's certainly not a bus_type
> in Linux, but if you have a node in DT with multiple children, we
> sometimes think of that as a bus. I believe it makes sense to have
> the child devices under the syscon node here, at least the ones that
> have no other registers.

Arnd, Lee,

First of all, I think I get the points of both of you.

With 'bus' I was referring to anything that implies a fixed number to
address any of the sub-units. As the register is more or less unsorted
and unordered, I'd see it as a resource - but that isn't important
really.

>> The problem that we try to solve here is not a DT problem but solely
>> driven by the fact that we need something to register platform_devices
>> for pinctrl and reset. The unit we describe in DT is a pinctrl-clock-
>> power-reset-unit - or short chip control.
>
> There are two problems here that we need to look at separately,
> even though there is some interaction:
>
> * For the DT representation, we need to make it something that
> corresponds to the hardware. We could either have a single device
> node for the set of registers, or we could have one node for each
> child. With syscon, we could also put the functional device nodes
> somewhere else, which we have to do if any device uses multiple
> syscon parents.

Well, during the discussion, I think we can also get along with a
single node for the whole chip-registers - even in DT. Clock and
reset just require corresponding #foo-cells and pinctrl will have
its pinmux sub-nodes right in that single node. If we have separate
sub-nodes for each of the subsystems is mainly a matter of taste,
right?

> * For the driver code, we need a way to fit into the kernel model
> while at the same time using the information that is in DT.
> I agree with Lee that your current driver is not a good solution
> here: you create a driver for the parent device that knows what
> child devices there are, which is not a good abstraction. Instead
> we should have a way for the child devices to get probed automatically,
> just like we do for simple-bus, whether we use simple-bus or not.

With no sub-nodes, we'd have to have a driver that knows the linux
subsystem platform_devices. With sub-nodes, you are proposing a
"syscon-bus"-like compatible hook to populate sub-devices. Ok, I
get this.

>> If you argue that mfd is not the right place for this "driver" we'll
>> have to find a different place for it. I remember Mike has no problem
>> with extending early probed clock drivers to register additional
>> platform_devices - so I guess we end up putting it in there ignoring
>> mfd's ability to do it for us.
>
> If you have a driver that is responsible for the entire register
> area, I think it would be best to make that driver just register
> to all the subsystems itself rather than creating child devices.

Hmm. That would create a beast of a driver wouldn't it? We could
get along with a library-like structure we each of foo-related
code resides in drivers/foo but still we'd need some common include
to reference to the sub-driver.

> The alternative is to come up with a way to probe all the child
> devices automatically, but then we should make that parent device
> have a generic driver that does not need to know about the children
> and that can work on any platform with similar requirements.

Ok, this is most likely the part that Lee doesn't like on the current
driver: a platform_device for registering platform_devices *only* and
only for Berlin.

So, out of the two options:

(a) Go for syscon_of_populate_devices() with a new compatible (I guess)
     and having sub-nodes for each Linux subsystem that we want to have
     a platform_device for. I fear that this will clash with early
     registration of clk and we still have to find a way, i.e. device
     naming policy, to match the drivers with their devices.

(b) Join clk, pinctrl, reset into a single chip/soc-control node and
     rewrite the sub-drivers to not directly rely on DT compatible.
     With this, joining all sub-drivers into drivers/soc/berlin would
     be a sane approach, right? Also, I have the strong feeling, that
     we will encounter situations later that will require the clk driver
     to pull a reset before changing a specific clk rate, e.g. for GPU.

Anyway, I appreciate your discussion but still I am a little lost
between the two options. I thought that Antoine's mfd approach is
good, but I understand your concerns.

Any direction we should go for?

Sebastian
