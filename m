From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 27 Jan 2015 13:17:47 +0200
Subject: [PATCHv5 2/2] leds: tlc591xx: Driver for the TI 8/16 Channel
 i2c LED driver
In-Reply-To: <20150126174100.GD5015@lunn.ch>
References: <1421879364-8573-1-git-send-email-andrew@lunn.ch>
 <1421879364-8573-3-git-send-email-andrew@lunn.ch> <54C625D8.7040305@ti.com>
 <20150126174100.GD5015@lunn.ch>
Message-ID: <54C773DB.8010905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/15 19:41, Andrew Lunn wrote:

>> Maybe it's normal for LED drivers, but why is the workqueue needed? Why
>> not just do the work synchronously?
> 
> include/linux/leds.h says:
> 
>         /* Must not sleep, use a workqueue if needed */
>         void            (*brightness_set)(struct led_classdev *led_cdev,
>                                           enum led_brightness brightness);
> 
> and regmap uses a lock to protect its structures, and so does i2c, etc.

Ah ok.

>>> +static int
>>> +tlc591xx_configure(struct device *dev,
>>> +		   struct tlc591xx_priv *priv,
>>> +		   struct regmap *regmap,
>>> +		   const struct tlc591xx *tlc591xx)
>>> +{
>>> +	unsigned int i;
>>> +	int err = 0;
>>> +
>>> +	tlc591xx_set_mode(regmap, MODE2_DIM);
>>> +	for (i = 0; i < TLC59116_LEDS; i++) {
>>
>> Looping for tlc591xx->maxleds should be enough?
> 
> Yes, it would, but i'm not sure that is any better. At the moment it
> is a constant, so the compiler can optimise it. We might save 8
> iterations for TLC59108, but how much do we add by having less well
> optimized code? And this is during probe, not some hot path, so do we
> really care?

True. And if the define is renamed to TLC591XX_MAX_LEDS or such, then
it's clear.

>>> +
>>> +	tlc591xx = of_match_device(of_tlc591xx_leds_match, dev)->data;
>>
>> I presume of_match_device() can return NULL or an error, making the
>> above crash.
> 
> It would be very odd. The fact the probe function is being called
> means there is a match. So return values like -ENODEV would mean a
> core OF bug. There is no memory allocations needed, so -ENOMEM would
> also not be expected.

The match could come from non-DT based matching. You don't support that
in the driver, but it would be good to bail out early if that is the case.

>>> +
>>> +	count = of_get_child_count(np);
>>
>> 'np' may be NULL. I'm not sure how of_get_child_count() likes that.
>  
> How can it be NULL? If the probe has been called, it means the
> compatibility string must match. If it matches, there must be a np!

Again with non-DT match, although if that's the case the driver should
have already returned an error at this point.

> Anyway, of_get_child_count() looks to be happy with NULL and will
> return 0.

Yep, then it's not an issue.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/5f2abe00/attachment.sig>
