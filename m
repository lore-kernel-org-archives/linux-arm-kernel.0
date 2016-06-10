From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 10 Jun 2016 15:06:35 +0100
Subject: [PATCH v3 20/20] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
In-Reply-To: <20160610131855.GG27142@ulmo.ba.sec>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-21-lee.jones@linaro.org>
 <20160608205152.GA5511@rob-hp-laptop> <20160609114107.GB1388@dell>
 <20160610131855.GG27142@ulmo.ba.sec>
Message-ID: <20160610140635.GC1537@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jun 2016, Thierry Reding wrote:

> On Thu, Jun 09, 2016 at 12:41:07PM +0100, Lee Jones wrote:
> > On Wed, 08 Jun 2016, Rob Herring wrote:
> > 
> > > On Wed, Jun 08, 2016 at 10:21:35AM +0100, Lee Jones wrote:
> > > > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
> > > > be more inline with the naming conventions of the subsystem.  Where
> > > > we used to treat each line as a channel, the PWM convention is to
> > > > describe them as devices.
> > > 
> > > That's all linux implementation details and you are breaking 
> > > compatibility.
> > 
> > Normally I'd agree with you, but I happen to know that a) this IP is
> > currently unused and b) up until this point (and probably beyond), ST
> > always ship the DTB with the kernel, so there will be no breakage.
> 
> Heh... I've long given up on trying to make that argument go anywhere.
> The general rule is that once we support a binding in a kernel release
> we have to support it indefinitely. If you really want to go ahead with
> this change (I don't think you should), you'd at least have to document
> both properties and support st,pwm-num-chan in the driver for backwards
> compatibility.

I understand what the *general* rule is, but we have to remember why
this rule was put into place and apply some common sense.  In some
Enterprise user-cases where DTBs are written into ROM or where they
are difficult /impossible to update, I can completely understand the
requirement to support previous incarnations.  However in this, the
real world, DTBs are shipped with their corresponding kernels.  We
would lack a great deal of functionality if they weren't.  It is
therefor, foolhardy and inappropriate to stick to this rule just
'cos.

> > > > The second documentation adaption entails adding support for PWM
> > > > capture devices.  A new clock is required as well as an IRQ line.
> > > > We're also adding a new property similar to the one described
> > > > above, but for capture channels.  Typically, there will be less
> > > > capture channels than PWM-out, since all channels have the latter
> > > > capability, but only some have capture support.
> > > 
> > > Humm, sounds like all of this should be implied from compatible strings.
> > 
> > You mean have a bunch of of_machine_is_compatibles() scattered around?
> 
> I don't understand why you need this at all. Quite frankly I don't even
> know why st,pwm-num-devs exists. I probably missed it back at the time.
> Usually, like Rob suggests, this should be inferred from the compatible
> string. One commonly used way to avoid scattering explicit checks for
> the compatible string is to add this information to the of_device_id
> table. See a bunch of existing drivers for reference.

Yes, I am aware of the strategy, and happy to oblige if this is your
suggestion.  I'll move all platform data into the driver and eradicate
the DT properties.

> Also, why make a separation of output vs. capture channels at this
> point? Could you not simply obtain the total number of PWM channels,
> preferably from SoC data associated with the compatible string, and
> check at ->capture() time whether or not the particular PWM supports
> this?
> 
> As-is, you imply that you have n (output) + m (capture) channels, and
> that 0..n-1 are output and n..n+m-1 are capture channels. What if that
> no longer holds true, but 0 and 2 are the only ones that support
> capture?

We do?  What makes you think that?

> If you check for this at runtime you can avoid complicated DT parsing
> code, but still get the safety check which should be enough to encourage
> people to use the right channels in DT.

I'm pretty sure I can move all the data into the driver.  I did want
to avoid having lots of different compatible strings, but if that's
what you're suggesting, I can introduce one per supported platform.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
