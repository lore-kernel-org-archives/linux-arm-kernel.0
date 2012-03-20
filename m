From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 20 Mar 2012 09:39:44 +0100
Subject: [PATCH v4 10/10] pwm-backlight: Add rudimentary device tree
 support
In-Reply-To: <4F67F2AF.3020404@wwwdotorg.org>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-11-git-send-email-thierry.reding@avionic-design.de>
 <4F67F2AF.3020404@wwwdotorg.org>
Message-ID: <20120320083943.GA20249@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 03/14/2012 09:56 AM, Thierry Reding wrote:
> > This commit adds very basic support for device tree probing. Currently,
> > only a PWM and a list of distinct brightness levels can be specified.
> > Enabling or disabling backlight power via GPIOs is not yet supported.
> > 
> > A pointer to the exit() callback is stored in the driver data to keep it
> > around until the driver is unloaded.
> 
> > +++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight
> 
> > +pwm-backlight bindings
> > +
> > +Required properties:
> > +  - compatible: "pwm-backlight"
> > +  - pwm: OF device-tree PWM specification
> > +  - num-brightness-levels: number of distinct brightness levels
> > +  - brightness-levels: array of distinct brightness levels
> 
> I assume the values in this array are 0 (darkest/off) to 255 (max
> brightness)? The doc should probably specify this.

Typically yes. Although I haven't tested this it should work for pretty much
any range starting from 0 because the last value will be used to interpolate
("scale") the PWM duty cycle. So it really is 0 (darkest/off) to <last item>
(max brightness). I should document this, of course.

> > +  - default-brightness-level: the default brightness level
> 
> Likewise, this is an index into the default-brightness-level? Again,
> it'd be best to explicitly state this.

Yes. Correct.

> ...
> > +		brightness-levels = <0 4 8 16 32 64 128 255>;
> > +		default-brightness-level = <6>;
> 
> 
> > +static int pwm_backlight_parse_dt(struct device *dev,
> > +				  struct platform_pwm_backlight_data *data)
> ...
> > +		ret = of_property_read_u32(node, "default-brightness-level",
> > +					   &value);
> > +		if (ret < 0)
> > +			goto free;
> 
> Range-check that against max_brightness?

Yes, that would be good. I guess logging a warning and falling back to
max_brightness would be the proper action?

> >  static int pwm_backlight_probe(struct platform_device *pdev)
> ...
> > -	pb->pwm = pwm_request(data->pwm_id, "backlight");
> > -	if (IS_ERR(pb->pwm)) {
> > -		dev_err(&pdev->dev, "unable to request PWM for backlight\n");
> > -		ret = PTR_ERR(pb->pwm);
> > -		goto err_alloc;
> > -	} else
> > -		dev_dbg(&pdev->dev, "got pwm for backlight\n");
> > +	if (!pb->pwm) {
> > +		pb->pwm = pwm_request(data->pwm_id, "backlight");
> > +		if (IS_ERR(pb->pwm)) {
> > +			dev_err(&pdev->dev, "unable to request PWM for backlight\n");
> > +			ret = PTR_ERR(pb->pwm);
> > +			goto err_alloc;
> > +		} else
> > +			dev_dbg(&pdev->dev, "got pwm for backlight\n");
> > +	}
> 
> Hmmm. It'd be more consistent if pwm_backlight_parse_dt() called
> something like of_pwm_get() instead of of_pwm_request(), so that this
> code could always call pwm_request() on the PWM and hence operate the
> same irrespective of DT vs non-DT. GPIOs work that way at least.

That's actually what the initial patch had. Unfortunately that's pretty much
the opposite direction of where the PWM framework is headed because it would
involve getting a global index to request the PWM. I think in the long run it
would be much better to get rid of pwm_request() altogether and unify by
having the non-DT case request the PWM device on a per-chip basis.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120320/89ee5a2d/attachment.sig>
