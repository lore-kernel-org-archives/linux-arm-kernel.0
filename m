From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Oct 2014 15:11:16 +0000
Subject: [PATCH V4 3/3] rtc: omap: Support regulator supply for RTC
In-Reply-To: <20141028150148.GE8123@saruman>
References: <1414490332-14856-1-git-send-email-lokeshvutla@ti.com>
 <1414490332-14856-4-git-send-email-lokeshvutla@ti.com>
 <20141028150148.GE8123@saruman>
Message-ID: <20141028151116.GV18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 10:01:48AM -0500, Felipe Balbi wrote:
> On Tue, Oct 28, 2014 at 03:28:52PM +0530, Lokesh Vutla wrote:

> > +- vrtc-minuV: Minimum required voltage in uV, If default voltage needs to be changed
> > +- vrtc-maxuV: Maximum acceptable voltage in uV, If default voltage needs to be changed

> huh ? minuV and maxuV is already part of the regulator binding itself.

No, they aren't - there's bindings for setting constraints but not
bindings for setting values in consumers since consumers generally
understand why they are setting a voltage if they do so.  I'd expect
that we'd have a property for whatever system feature might cause us to
need to explicitly set the voltage if we need to vary the voltage at
runtime, or alternatively for systems to set a voltage through the
constraints on the supply rather than having properties on the consumer
- why are they here?

If for some reason we really need these properties they should be -max-uV
and -min-uV.

> > @@ -514,6 +516,37 @@ static int omap_rtc_probe(struct platform_device *pdev)
> >  	if (IS_ERR(rtc->base))
> >  		return PTR_ERR(rtc->base);
> >  
> > +	rtc->supply = devm_regulator_get_optional(&pdev->dev, "vrtc");

> I'm not sure if this is optional either, it's just that many of our
> current DTS don't really pass a regulator to RTC, right ?

If the RTC can run without power that would certainly be most
impressive.  I can't see any reason for this driver to use anything
other than a standard regulator_get().

> > +		if (vrtc_minuV && vrtc_maxuV) {
> > +			ret = regulator_set_voltage(rtc->supply,
> > +						    vrtc_minuV, vrtc_maxuV);
> > +			if (ret) {
> > +				dev_err(&pdev->dev, "failed to set volt %d\n",
> > +					ret);
> > +				return ret;
> > +			}
> > +		}

> I'd really like to Mark's comments here but I was under the impression
> that if the binding already gives min_microvolt == max_microvolt then
> driver shouldn't really care about a set_voltage. Mark ?

That's what happens for the standard properties on the supplying
regulator, these properties are separate to that.  Like I say I'm not
sure I understand why this is being done on a per-consumer basis.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/33561daf/attachment.sig>
