From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Apr 2013 15:13:59 +0200
Subject: [PATCH] ARM: Adds pin config API to set all configs in one
 function
In-Reply-To: <051069C10411E24D9749790C498526FA1BCF5427@SJEXCHMB12.corp.ad.broadcom.com>
References: <1366841010-2823-1-git-send-email-syin@broadcom.com>
 <CACRpkdbT7f8ujCHZxKg26iMKcrAb+_yHW_2YsZwkoo892rkgTA@mail.gmail.com>
 <051069C10411E24D9749790C498526FA1BCF5427@SJEXCHMB12.corp.ad.broadcom.com>
Message-ID: <CACRpkdZ6zQdivtq5wmizovWEGb-Q9xzA6EE8CafnuV13hzX_UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 27, 2013 at 12:02 AM, Sherman Yin <syin@broadcom.com> wrote:

> Perhaps I have misunderstood you previously, as I thought you are ok with letting
> the driver take care of the loop.  The difference being instead of just moving the for
> loop inside the driver's pin_config_set(), I followed Stephen's suggestion due to
> concern about drivers duplicating the loop:
(...)
> Please correctly if I'm wrong, but I think with the functions in my patch, the
> driver still have full control of / responsibility to resolve config sequence
> and perform validation.  The difference is instead of feeding the driver one
> config at time and telling it to write when the complete() function is called,
> my patch just gives the driver all configs in one call and expects the driver
> to parse, validate and write accordingly.
(...)
>> The driver takes care of caching intermediate settings for the pin
>> until the complete() callback is called.
>> Can you devise a patch like this instead?
>
> I do have some concerns about the driver caching all the configs until complete()
> is called...  I'm ok either way as long as it provides a way to consolidate pin config register
> writes.  Just want to clarify things with you before I go ahead and modify
> my patch and driver.

OK I thought a bit about this too and I see the problem.

However I think it's cluttery to have both
pin_config_set() and pin_config_set_all().

If you want it to be done this way, I think you should modify
pin_config_set() like so instead:

-        int (*pin_config_set) (struct pinctrl_dev *pctldev,
-                               unsigned pin,
-                               unsigned long config);
+       int (*pin_config_set) (struct pinctrl_dev *pctldev,
+                                  const struct
pinctrl_setting_configs *configs, unsigned num_configs);

And then change all the drivers.

(And vice versa mutatis mutandis for the group function.)

Notice especially the added num_configs parameter that was
missing from pin_config_set_all() in your patch, please tell
me how else you deduct the size of the configs array.

To the drivers to iterate over the array of configs,
please introduce a static helper function:

for_each_config() in something like <linux/pinctrl/pinconf.h>
so it's easy for driver writers to get this right. (You'll be much
helped by this function when refactoring the existing drivers as well
I think.)

Doing the same thing with two different functions isn't
helpful, refactoring like this is much better, it's just more
work :-D

Yours,
Linus Walleij
