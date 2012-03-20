From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Mar 2012 09:27:04 -0600
Subject: [PATCH v4 10/10] pwm-backlight: Add rudimentary device tree
 support
In-Reply-To: <20120320083943.GA20249@avionic-0098.adnet.avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-11-git-send-email-thierry.reding@avionic-design.de>
 <4F67F2AF.3020404@wwwdotorg.org>
 <20120320083943.GA20249@avionic-0098.adnet.avionic-design.de>
Message-ID: <4F68A1C8.5080608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2012 02:39 AM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 03/14/2012 09:56 AM, Thierry Reding wrote:
>>> This commit adds very basic support for device tree probing. Currently,
>>> only a PWM and a list of distinct brightness levels can be specified.
>>> Enabling or disabling backlight power via GPIOs is not yet supported.
>>>
>>> A pointer to the exit() callback is stored in the driver data to keep it
>>> around until the driver is unloaded.
...
>>>  static int pwm_backlight_probe(struct platform_device *pdev)
>> ...
>>> -	pb->pwm = pwm_request(data->pwm_id, "backlight");
>>> -	if (IS_ERR(pb->pwm)) {
>>> -		dev_err(&pdev->dev, "unable to request PWM for backlight\n");
>>> -		ret = PTR_ERR(pb->pwm);
>>> -		goto err_alloc;
>>> -	} else
>>> -		dev_dbg(&pdev->dev, "got pwm for backlight\n");
>>> +	if (!pb->pwm) {
>>> +		pb->pwm = pwm_request(data->pwm_id, "backlight");
>>> +		if (IS_ERR(pb->pwm)) {
>>> +			dev_err(&pdev->dev, "unable to request PWM for backlight\n");
>>> +			ret = PTR_ERR(pb->pwm);
>>> +			goto err_alloc;
>>> +		} else
>>> +			dev_dbg(&pdev->dev, "got pwm for backlight\n");
>>> +	}
>>
>> Hmmm. It'd be more consistent if pwm_backlight_parse_dt() called
>> something like of_pwm_get() instead of of_pwm_request(), so that this
>> code could always call pwm_request() on the PWM and hence operate the
>> same irrespective of DT vs non-DT. GPIOs work that way at least.
> 
> That's actually what the initial patch had. Unfortunately that's pretty much
> the opposite direction of where the PWM framework is headed because it would
> involve getting a global index to request the PWM.

Not necessarily; get() could return a controller+index pair, which could
then be passed to request().

> I think in the long run it
> would be much better to get rid of pwm_request() altogether and unify by
> having the non-DT case request the PWM device on a per-chip basis.

That might also work.
