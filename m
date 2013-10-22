From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 22 Oct 2013 09:49:22 -0700
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <232aa6e4-19fe-4460-8101-8bf1d639ff3c@email.android.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131021085420.GA21518@ulmo.nvidia.com>
 <52658C49.80400@wwwdotorg.org> <5265AFED.1040503@roeck-us.net>
 <52665314.2040904@imgtec.com>
 <232aa6e4-19fe-4460-8101-8bf1d639ff3c@email.android.com>
Message-ID: <20131022164922.GA29852@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 05:31:25PM +0100, Jonathan Cameron wrote:
> 
> 
> James Hogan <james.hogan@imgtec.com> wrote:
> >On 21/10/13 23:51, Guenter Roeck wrote:
> >> In my opinion, not being able to describe behavior (or what people
> >refer
> >> to as "describe how the hardware is used") is a severe limitation of
> >> devicetree usage in Linux. That is not a devicetree limitation per
> >se,
> >> though, it is simply a matter of choice (or, in some cases, the
> >ability
> >> of those arguing for new bindings to sell those bindings as "hardware
> >> description").
> >
> >I agree this is a real problem, and I think it hinders upstream
> >submission, since platform data was permitted to describe behaviour as
> >well as describe the hardware, and platform data is being replaced with
> >DT which is only permitted to describe the hardware. How then should we
> >specify the behaviour to the kernel?
> >
> >I've already mentioned specific examples of this on the "Clock DT
> >bindings" thread, and would be very interested if anybody has thoughts
> >about it:
> >http://lkml.kernel.org/r/520E1DF5.4030409 at imgtec.com
> 
> We have run into a kind of similar issue with IIO. We are interested in describing sensors
>  adcs,DACs etc and providing both userspace access and in kernel access to other drivers.
> 
>  Lots of sensors are used for different
>  purposes on different devices. Simple example is free fall detection vs vibration
>  analysis vs input for an accelerometer. User space expects data from different
>  subsystems. We handle that via 'bridge' drivers.  So need a way to specify which
>  bridge driver cares about which channels.
> It is not always 'wiring' but it usually is dictated by the product implementation. 
> Some aspects of this have been discussed but they only cover the is an ADC wired to an
>  accelerometer case rather than the using the same physical hardware for on or more
>  unrelated purpose.
> Perhaps this case could be pushed into user space but then we just have another board
>  specific bit of code...
> 
> Just to add that for IIO device tree mostly works pretty well.

Yes, it does, only the iio-hwmon bridge is one of those cases where we are now
told that "this describes use, not the hardware itself". But how is one supposed
to describe that an ADC on a board is used as voltage sensor ? Does that mean one
would have to have a dedicated voltage sensor (or current sensor, for that
matter) to ensure that the use case is clear ?

Another example is my recent attempt to add dt support to gpio based connectors.
Even though a connector is as much hardware as it can get (or at least one
should think so), that was rejected because it isn't generic enough and,
after all, it describes the _use_ of gpio pins which apparently is already
borderline. So now I have my own out of tree driver (where I can add as many
bindings and as much functionality as I want and see fit, so I am not too
unhappy about that).

That matches Thierry's earlier comments - one is now _forced_ to maintain
out-of-tree code simply because DT bindings are either unacceptable, not generic
enough, or not stable enough to be accepted into the upstream kernel.

So far I have been able to work around that, but I seriously consider dropping
DT use entirely and moving back to platform data ... not the very least because
DT isn't supported on x86 and I have to deal with that situation as well (and,
no, ACPI doesn't solve my problems there either).

Mission accomplished, at least if the mission is to keep the code out
of the mainstream kernel and limiting DT use cases (or to make it unusable
for practical purposes).

Guenter
