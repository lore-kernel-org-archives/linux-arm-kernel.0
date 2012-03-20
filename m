From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 20 Mar 2012 16:43:30 +0100
Subject: [PATCH v4 10/10] pwm-backlight: Add rudimentary device tree
 support
In-Reply-To: <4F68A1C8.5080608@wwwdotorg.org>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-11-git-send-email-thierry.reding@avionic-design.de>
 <4F67F2AF.3020404@wwwdotorg.org>
 <20120320083943.GA20249@avionic-0098.adnet.avionic-design.de>
 <4F68A1C8.5080608@wwwdotorg.org>
Message-ID: <20120320154330.GA8651@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 03/20/2012 02:39 AM, Thierry Reding wrote:
> > * Stephen Warren wrote:
> >> On 03/14/2012 09:56 AM, Thierry Reding wrote:
> >>> This commit adds very basic support for device tree probing. Currently,
> >>> only a PWM and a list of distinct brightness levels can be specified.
> >>> Enabling or disabling backlight power via GPIOs is not yet supported.
> >>>
> >>> A pointer to the exit() callback is stored in the driver data to keep it
> >>> around until the driver is unloaded.
> ...
> >>>  static int pwm_backlight_probe(struct platform_device *pdev)
> >> ...
> >>> -	pb->pwm = pwm_request(data->pwm_id, "backlight");
> >>> -	if (IS_ERR(pb->pwm)) {
> >>> -		dev_err(&pdev->dev, "unable to request PWM for backlight\n");
> >>> -		ret = PTR_ERR(pb->pwm);
> >>> -		goto err_alloc;
> >>> -	} else
> >>> -		dev_dbg(&pdev->dev, "got pwm for backlight\n");
> >>> +	if (!pb->pwm) {
> >>> +		pb->pwm = pwm_request(data->pwm_id, "backlight");
> >>> +		if (IS_ERR(pb->pwm)) {
> >>> +			dev_err(&pdev->dev, "unable to request PWM for backlight\n");
> >>> +			ret = PTR_ERR(pb->pwm);
> >>> +			goto err_alloc;
> >>> +		} else
> >>> +			dev_dbg(&pdev->dev, "got pwm for backlight\n");
> >>> +	}
> >>
> >> Hmmm. It'd be more consistent if pwm_backlight_parse_dt() called
> >> something like of_pwm_get() instead of of_pwm_request(), so that this
> >> code could always call pwm_request() on the PWM and hence operate the
> >> same irrespective of DT vs non-DT. GPIOs work that way at least.
> > 
> > That's actually what the initial patch had. Unfortunately that's pretty much
> > the opposite direction of where the PWM framework is headed because it would
> > involve getting a global index to request the PWM.
> 
> Not necessarily; get() could return a controller+index pair, which could
> then be passed to request().

This is pretty much what of_pwm_request() does internally (actually via the
of_xlate() function), and it goes one step further by requesting the
corresponding PWM.

I don't really like the fact that the DT parsing code needs to store a
requested PWM device in the platform data. The only other solution would be,
as you suggest, to obtain two indices and request based on them. However that
comes with a whole lot of problems of its own (race between getting the
controller index and the actual requesting of the PWM device, ...).

One other alternative could be to not pass the PWM device via platform data
but rather return it from the pwm_backlight_parse_dt() function (either via
the return value or an output parameter).

> > I think in the long run it
> > would be much better to get rid of pwm_request() altogether and unify by
> > having the non-DT case request the PWM device on a per-chip basis.
> 
> That might also work.

What I'm not sure about is how to represent this in the non-DT case. The
problem would be how to identify the individual PWM chips. From a quick
glance, pinctrl seems to do this purely on a name lookup basis, similar to
the clock framework.

What would be a good way to represent this in platform data?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120320/3c131345/attachment.sig>
