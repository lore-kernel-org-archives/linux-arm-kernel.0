From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Jun 2016 16:53:23 +0200
Subject: [PATCH v3 20/20] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
In-Reply-To: <20160610140635.GC1537@dell>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-21-lee.jones@linaro.org>
 <20160608205152.GA5511@rob-hp-laptop> <20160609114107.GB1388@dell>
 <20160610131855.GG27142@ulmo.ba.sec> <20160610140635.GC1537@dell>
Message-ID: <20160610145323.GO27142@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 03:06:35PM +0100, Lee Jones wrote:
> On Fri, 10 Jun 2016, Thierry Reding wrote:
> 
> > On Thu, Jun 09, 2016 at 12:41:07PM +0100, Lee Jones wrote:
> > > On Wed, 08 Jun 2016, Rob Herring wrote:
> > > 
> > > > On Wed, Jun 08, 2016 at 10:21:35AM +0100, Lee Jones wrote:
> > > > > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
> > > > > be more inline with the naming conventions of the subsystem.  Where
> > > > > we used to treat each line as a channel, the PWM convention is to
> > > > > describe them as devices.
> > > > 
> > > > That's all linux implementation details and you are breaking 
> > > > compatibility.
> > > 
> > > Normally I'd agree with you, but I happen to know that a) this IP is
> > > currently unused and b) up until this point (and probably beyond), ST
> > > always ship the DTB with the kernel, so there will be no breakage.
> > 
> > Heh... I've long given up on trying to make that argument go anywhere.
> > The general rule is that once we support a binding in a kernel release
> > we have to support it indefinitely. If you really want to go ahead with
> > this change (I don't think you should), you'd at least have to document
> > both properties and support st,pwm-num-chan in the driver for backwards
> > compatibility.
> 
> I understand what the *general* rule is, but we have to remember why
> this rule was put into place and apply some common sense.  In some
> Enterprise user-cases where DTBs are written into ROM or where they
> are difficult /impossible to update, I can completely understand the
> requirement to support previous incarnations.  However in this, the
> real world, DTBs are shipped with their corresponding kernels.  We
> would lack a great deal of functionality if they weren't.  It is
> therefor, foolhardy and inappropriate to stick to this rule just
> 'cos.

I used to advocate the very same point of view a couple of years ago but
was repeatedly told that it's irrelevant, and everybody was to be held
to the same standards, irrespective of how easy it is to update the DTB
in lockstep with the kernel.

Part of me still wishes that the rules were a little less strict, but a
decision was made on this years ago, so I'm just repeating this here in
an attempt to save you from wasting your time arguing.

Then again, there have been occasions where decisions were undone, so
you might have better luck nowadays if you're willing to take this to
the DT bindings and ARM-SoC maintainers.

Bottom line: NAK on the backwards-incompatible DT binding change from me
based on earlier decisions made on this topic. But I may be swayed if
everyone else thinks ABI stability is no longer something we consider
important for DT.

> > > > > The second documentation adaption entails adding support for PWM
> > > > > capture devices.  A new clock is required as well as an IRQ line.
> > > > > We're also adding a new property similar to the one described
> > > > > above, but for capture channels.  Typically, there will be less
> > > > > capture channels than PWM-out, since all channels have the latter
> > > > > capability, but only some have capture support.
> > > > 
> > > > Humm, sounds like all of this should be implied from compatible strings.
> > > 
> > > You mean have a bunch of of_machine_is_compatibles() scattered around?
> > 
> > I don't understand why you need this at all. Quite frankly I don't even
> > know why st,pwm-num-devs exists. I probably missed it back at the time.
> > Usually, like Rob suggests, this should be inferred from the compatible
> > string. One commonly used way to avoid scattering explicit checks for
> > the compatible string is to add this information to the of_device_id
> > table. See a bunch of existing drivers for reference.
> 
> Yes, I am aware of the strategy, and happy to oblige if this is your
> suggestion.  I'll move all platform data into the driver and eradicate
> the DT properties.

Great!

> > Also, why make a separation of output vs. capture channels at this
> > point? Could you not simply obtain the total number of PWM channels,
> > preferably from SoC data associated with the compatible string, and
> > check at ->capture() time whether or not the particular PWM supports
> > this?
> > 
> > As-is, you imply that you have n (output) + m (capture) channels, and
> > that 0..n-1 are output and n..n+m-1 are capture channels. What if that
> > no longer holds true, but 0 and 2 are the only ones that support
> > capture?
> 
> We do?  What makes you think that?

Because there's nothing saying otherwise? The DT binding is completely
silent on the matter, and the above is the most logical interpretation
that I came up with.

Looking at the driver it seems like it's actually the other way around
and you have the first m channels that support both output and capture
functionality. But the issue remains that this isn't documented in the
DT binding documentation. And the current properties are also not very
flexible because they allow for only a single scheme of assigning the
capability.

If you move all of that knowledge into the driver, things become a lot
easier, in my opinion.

> > If you check for this at runtime you can avoid complicated DT parsing
> > code, but still get the safety check which should be enough to encourage
> > people to use the right channels in DT.
> 
> I'm pretty sure I can move all the data into the driver.  I did want
> to avoid having lots of different compatible strings, but if that's
> what you're suggesting, I can introduce one per supported platform.

That sounds like the simplest solution to me.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/151ec707/attachment-0001.sig>
