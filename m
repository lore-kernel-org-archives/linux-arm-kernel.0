From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Mar 2012 09:56:09 -0600
Subject: [PATCH v4 10/10] pwm-backlight: Add rudimentary device tree
 support
In-Reply-To: <20120320154330.GA8651@avionic-0098.mockup.avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-11-git-send-email-thierry.reding@avionic-design.de>
 <4F67F2AF.3020404@wwwdotorg.org>
 <20120320083943.GA20249@avionic-0098.adnet.avionic-design.de>
 <4F68A1C8.5080608@wwwdotorg.org>
 <20120320154330.GA8651@avionic-0098.mockup.avionic-design.de>
Message-ID: <4F68A899.3030009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2012 09:43 AM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 03/20/2012 02:39 AM, Thierry Reding wrote:
...
>>> I think in the long run it
>>> would be much better to get rid of pwm_request() altogether and unify by
>>> having the non-DT case request the PWM device on a per-chip basis.
>>
>> That might also work.
> 
> What I'm not sure about is how to represent this in the non-DT case. The
> problem would be how to identify the individual PWM chips. From a quick
> glance, pinctrl seems to do this purely on a name lookup basis, similar to
> the clock framework.
> 
> What would be a good way to represent this in platform data?

I think most get subsystems have a get API that works for both DT and
non-DT, rather than using platform data:

# works in DT right now IIRC:
regulator_get(dev, supply_name)

# patches posted to make this work in DT. Near checkin:
p = pinctrl_get(dev); s = pinctrl_lookup_state(p, state_name)

# patches posted to make this work in DT. I'm not sure how
# near they are to check-in.
clk_get(dev, clk_name)

That way, there could be a pwm_get(dev, name) for both non-DT (use some
table registered by board files) and DT (use the OF lookup code you've
written).

Admittedly, GPIOs don't work quite this way. Interrupts kinda do via the
platform resources.

For board files, this would rely on some table which mapped from the get
parameters to the returned object. IIRC, most of these tables are
indexed by (dev_name(dev), name) and probably return the dev_name() of
the providing device (or whatever internally makes sense to identify the
device) plus some subsystem-specific data (e.g. PWM index).
