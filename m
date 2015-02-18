From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Feb 2015 16:06:04 +0100
Subject: [PATCH 01/11] mfd: add the Berlin controller driver
In-Reply-To: <54E48EF0.4050807@gmail.com>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <20150218115853.GB22296@x1> <54E48EF0.4050807@gmail.com>
Message-ID: <5101633.XnBqLvsiGQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 February 2015 14:09:04 Sebastian Hesselbarth wrote:
> On 02/18/2015 12:58 PM, Lee Jones wrote:
> > I do agree that using 'simple-bus' to describe only this IP would be
> > an abuse.  However, my foundation thought/argument is unchanged.  This
> > 'driver' is a hack.  It has no functional use besides to work around a
> > problem of semantics and as such has no place in MFD.
> 
> Lee,
> 
> sorry I don't get it. Here you say that using simple-bus is an abuse...
> 
> > Back onto the simple-bus theme, as this is a syscon device it is a bus
> > of sorts.  Have you thought about making it a child of your its syscon
> > node, then using simple-bus to get the OF framework to register the
> > child devices?
> 
> ... and here you suggest to use simple-bus to register the child
> devices?
> 
> I fundamentally disagree that either this registers or syscon in general
> should in any way be seen as a bus. The chip control registers is an
> highly unsorted bunch of bits that we try to match with cleanly
> separated subsystems. This makes it a resource but no bus of any sort.

It really depends on what you mean by 'bus'. It's certainly not a bus_type
in Linux, but if you have a node in DT with multiple children, we
sometimes think of that as a bus. I believe it makes sense to have
the child devices under the syscon node here, at least the ones that
have no other registers.

> The problem that we try to solve here is not a DT problem but solely
> driven by the fact that we need something to register platform_devices
> for pinctrl and reset. The unit we describe in DT is a pinctrl-clock-
> power-reset-unit - or short chip control.

There are two problems here that we need to look at separately,
even though there is some interaction:

* For the DT representation, we need to make it something that
corresponds to the hardware. We could either have a single device
node for the set of registers, or we could have one node for each
child. With syscon, we could also put the functional device nodes
somewhere else, which we have to do if any device uses multiple
syscon parents.

* For the driver code, we need a way to fit into the kernel model
while at the same time using the information that is in DT.
I agree with Lee that your current driver is not a good solution
here: you create a driver for the parent device that knows what
child devices there are, which is not a good abstraction. Instead
we should have a way for the child devices to get probed automatically,
just like we do for simple-bus, whether we use simple-bus or not.

> If you argue that mfd is not the right place for this "driver" we'll
> have to find a different place for it. I remember Mike has no problem
> with extending early probed clock drivers to register additional
> platform_devices - so I guess we end up putting it in there ignoring
> mfd's ability to do it for us.

If you have a driver that is responsible for the entire register
area, I think it would be best to make that driver just register
to all the subsystems itself rather than creating child devices.

The alternative is to come up with a way to probe all the child
devices automatically, but then we should make that parent device
have a generic driver that does not need to know about the children
and that can work on any platform with similar requirements.

	Arnd
