From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 22 Oct 2013 22:35:47 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131022164922.GA29852@roeck-us.net>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131021085420.GA21518@ulmo.nvidia.com>
 <52658C49.80400@wwwdotorg.org> <5265AFED.1040503@roeck-us.net>
 <52665314.2040904@imgtec.com>
 <232aa6e4-19fe-4460-8101-8bf1d639ff3c@email.android.com>
 <20131022164922.GA29852@roeck-us.net>
Message-ID: <20131022203546.GC8037@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 09:49:22AM -0700, Guenter Roeck wrote:
> On Tue, Oct 22, 2013 at 05:31:25PM +0100, Jonathan Cameron wrote:
> > 
> > 
> > James Hogan <james.hogan@imgtec.com> wrote:
> > >On 21/10/13 23:51, Guenter Roeck wrote:
> > >> In my opinion, not being able to describe behavior (or what people
> > >refer
> > >> to as "describe how the hardware is used") is a severe limitation of
> > >> devicetree usage in Linux. That is not a devicetree limitation per
> > >se,
> > >> though, it is simply a matter of choice (or, in some cases, the
> > >ability
> > >> of those arguing for new bindings to sell those bindings as "hardware
> > >> description").
> > >
> > >I agree this is a real problem, and I think it hinders upstream
> > >submission, since platform data was permitted to describe behaviour as
> > >well as describe the hardware, and platform data is being replaced with
> > >DT which is only permitted to describe the hardware. How then should we
> > >specify the behaviour to the kernel?
> > >
> > >I've already mentioned specific examples of this on the "Clock DT
> > >bindings" thread, and would be very interested if anybody has thoughts
> > >about it:
> > >http://lkml.kernel.org/r/520E1DF5.4030409 at imgtec.com
> > 
> > We have run into a kind of similar issue with IIO. We are interested in describing sensors
> >  adcs,DACs etc and providing both userspace access and in kernel access to other drivers.
> > 
> >  Lots of sensors are used for different
> >  purposes on different devices. Simple example is free fall detection vs vibration
> >  analysis vs input for an accelerometer. User space expects data from different
> >  subsystems. We handle that via 'bridge' drivers.  So need a way to specify which
> >  bridge driver cares about which channels.
> > It is not always 'wiring' but it usually is dictated by the product implementation. 
> > Some aspects of this have been discussed but they only cover the is an ADC wired to an
> >  accelerometer case rather than the using the same physical hardware for on or more
> >  unrelated purpose.
> > Perhaps this case could be pushed into user space but then we just have another board
> >  specific bit of code...
> > 
> > Just to add that for IIO device tree mostly works pretty well.
> 
> Yes, it does, only the iio-hwmon bridge is one of those cases where we are now
> told that "this describes use, not the hardware itself". But how is one supposed
> to describe that an ADC on a board is used as voltage sensor ? Does that mean one
> would have to have a dedicated voltage sensor (or current sensor, for that
> matter) to ensure that the use case is clear ?

I'm not sure I understand correctly, but it seems to me like this isn't
actually about behaviour at all. Having something like:

	adc: adc {
		...
	};

	sensor {
		adc = <&adc>;
	};

sounds like an appropriate description of the hardware. Well, I guess it
doesn't quite accurately describe the hardware if one considers the ADC
to actually be the sensor, in which case, yeah, this actually describes
what the ADC is used for.

But on the other hand we do the same with other "resources". GPIOs for
example are rather useless if you don't associate them with specific
functionality. And we actually do that quite often. They are used in
properties such as:

	foo {
		...
		enable-gpios = <&gpio 42 0>;
		...
	};

I don't see how that is different to the ADC/sensor example above.
Perhaps there's no real physical device that is the sensor, but if we
can't even represent simple yet essential things like that in DT, then
we definitely need something better.

We do pretty much the same thing with regulators. We can have fixed
regulators that control a GPIO, yet there's no physical device that one
could associate with such regulators either.

> Another example is my recent attempt to add dt support to gpio based connectors.
> Even though a connector is as much hardware as it can get (or at least one
> should think so), that was rejected because it isn't generic enough and,
> after all, it describes the _use_ of gpio pins which apparently is already
> borderline. So now I have my own out of tree driver (where I can add as many
> bindings and as much functionality as I want and see fit, so I am not too
> unhappy about that).

That's odd. This sounds exactly like a variant of the above. Would you
mind posting the binding (or a usage example here)? I'd be interested to
understand why it would be inappropriate.

> That matches Thierry's earlier comments - one is now _forced_ to maintain
> out-of-tree code simply because DT bindings are either unacceptable, not generic
> enough, or not stable enough to be accepted into the upstream kernel.
> 
> So far I have been able to work around that, but I seriously consider dropping
> DT use entirely and moving back to platform data ...

I've actually been toying with that idea myself. Unfortunately it's very
difficult to do once you run on a platform that's completely moved to DT
because you actually have to manually search the DT in order to find any
references that you need.

> not the very least because DT isn't supported on x86 and I have to deal with
> that situation as well (and, no, ACPI doesn't solve my problems there either).

Actually DT is supported very well on x86. There's at least one platform
in mainline that uses it (arch/x86/platform/ce4100/falconfalls.dts) and
I've ported a platform that I worked on in the past to use DT on x86 as
well.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/1b284c60/attachment.sig>
