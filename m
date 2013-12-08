From: broonie@kernel.org (Mark Brown)
Date: Sun, 8 Dec 2013 21:50:26 +0000
Subject: [PATCH] ARM: cpu: Document and tweak clock-frequency property
In-Reply-To: <CAFEAcA9oCPi0dj89NJ0k2wOsbVBCV=3=7FBrn=xuYdouJWc98Q@mail.gmail.com>
References: <1386331027-26065-1-git-send-email-broonie@kernel.org>
 <52A36AB3.6060102@gmail.com> <20131208161922.GK29268@sirena.org.uk>
 <CAFEAcA8qsb0f_5dVbytCD3fGQdT+W4=PJudCY1f-ee4Pwm=0=Q@mail.gmail.com>
 <20131208192237.GM29268@sirena.org.uk>
 <CAFEAcA9oCPi0dj89NJ0k2wOsbVBCV=3=7FBrn=xuYdouJWc98Q@mail.gmail.com>
Message-ID: <20131208215026.GO29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 08, 2013 at 07:51:59PM +0000, Peter Maydell wrote:
> On 8 December 2013 19:22, Mark Brown <broonie@kernel.org> wrote:
> > On Sun, Dec 08, 2013 at 04:38:58PM +0000, Peter Maydell wrote:

> >> "The ARM architecture, in accordance with the ePAPR, requires
> >> the cpus and cpu nodes to be present and contain the properties
> >> described below."

> >> not "must contain the properties described below and also
> >> any others that the ePAPR spec says are mandatory".

> > I think that's a fairly tortured way of reading the language there to be
> > honest

> It's the way that I read it, and presumably also the way it was read
> by  Marc Z when he wrote the kvmtool device tree writing code, and
> also I would assume the way it was read by the people who wrote the
> random three or four dts files in arch/arm/boot/dts that I checked,
> since none of them include clock-frequency properties as far as I
> can see. If half a dozen different people all produced device
> trees with cpu nodes without a clock-frequency property then
> I think it's a bit hard to claim that it requires a tortured reading
> of the documentation to decide that it's not mandatory.

I think you're assuming that people are reading the binding documents at
all when they write things and that should they look at them they will
follow any references to ePAPR (which requires a signup to download) and
then pay attention to the requirements annotations (this is done a lot
more clearly in most of the in-tree documentation) all without making
any mistakes.  I think each of these assumptions is optimistic.

> > (and doesn't reflect the actual deployed code reading the binding
> > which does use this property without documentation outside ePAPR and does
> > warn if it's absent)

> This code should be fixed, then... (I'm pretty sure the kernel
> has not always warned about the absence of this property,
> or there would not be such a wide prevalence of DTs and
> DT generating code which omitted it.)

Too late for that, it's shipping in stable kernels.

> > being released regardless of spec conformance.  Kernels should be
> > liberal in what they accept, DTs should be conservative in what they
> > contain and both need to understand that the other is going to get it
> > wrong some of the time.

> I agree generally with this, and I think I would also include that
> the kernel should not start warning about things which it has
> not warned about in the past, because this basically manifests
> as "user experiences warning which they can't do much about";
> it's directed at the wrong target and much too late.

I think it's reasonable to warn on things, especially in cases where
it's risky or difficult to try to figure out what to do without the
property.  At this point most people can update their DTs and obviously
there's an awful lot of cases where the only people who would ever see
warnings are definitely people in a position to do so (things like
consumer electronics for example).

There does come a point where it's just nitpicking and not helpful but
if it has a substantial effect on functionality then it's useful.  In
this case suppressing the warning for non-asymmetric systems might be
sensible.

> If you want to make properties mandatory then you should
> have some sort of setup for validating an entire device tree
> including all the properties which the kernel doesn't happen
> to use yet or doesn't use in every configuration. That can
> then feel free to warn copiously about any missing mandatory
> properties, obviously.

That's one of the goals with the DT validation software that people like
Tomasz are working on.  Sadly it doesn't exist yet, it would definitely
make life a lot easier.

> >> (It's also not at all clear what a virtual machine's devicetree
> >> should set the clock-frequency properties to anyway...)

> > Yes, it's a poorly considered property all round.  Most currently
> > available silicon has variable clocks for the cores which is an issue
> > with a fixed DT like FDT provides and like you say for simulators and so
> > on it's meaningless.

> So what would we lose by making it genuinely optional and
> just silently doing something reasonable if it's not set?

For all practical purposes it is currently optional but the spec says
it is mandatory.  I would rather err on the side of not changing the
documentation in case someone does work based on ePAPR and/or an old
kernel and since doing that keeps the spec more stable even if we do
implement in a more tolerant fashion within Linux (as we should).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131208/4887bbb5/attachment.sig>
