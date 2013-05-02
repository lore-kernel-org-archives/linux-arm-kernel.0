From: syin@broadcom.com (Sherman Yin)
Date: Thu, 2 May 2013 00:07:05 +0000
Subject: [PATCH] ARM: Adds pin config API to set all configs in one
 function
In-Reply-To: <CACRpkdZ6zQdivtq5wmizovWEGb-Q9xzA6EE8CafnuV13hzX_UA@mail.gmail.com>
References: <1366841010-2823-1-git-send-email-syin@broadcom.com>
 <CACRpkdbT7f8ujCHZxKg26iMKcrAb+_yHW_2YsZwkoo892rkgTA@mail.gmail.com>
 <051069C10411E24D9749790C498526FA1BCF5427@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdZ6zQdivtq5wmizovWEGb-Q9xzA6EE8CafnuV13hzX_UA@mail.gmail.com>
Message-ID: <051069C10411E24D9749790C498526FA1BCF706F@SJEXCHMB12.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>OK I thought a bit about this too and I see the problem.
>
>However I think it's cluttery to have both
>pin_config_set() and pin_config_set_all().
>
>If you want it to be done this way, I think you should modify
>pin_config_set() like so instead:
>
>-        int (*pin_config_set) (struct pinctrl_dev *pctldev,
>-                               unsigned pin,
>-                               unsigned long config);
>+       int (*pin_config_set) (struct pinctrl_dev *pctldev,
>+                                  const struct
>pinctrl_setting_configs *configs, unsigned num_configs);
>
>And then change all the drivers.
>
>(And vice versa mutatis mutandis for the group function.)

So that's basically back to the initial suggestion of moving the 
loop inside the driver's function instead of creating a separate
API?  Stephen said he is concerned about the duplicated loop
but did say it's not a big deal.

>Notice especially the added num_configs parameter that was
>missing from pin_config_set_all() in your patch, please tell
>me how else you deduct the size of the configs array.

We are passing a pointer to struct pinctrl_setting_configs, 
which should have the num_configs already:

105struct pinctrl_setting_configs {
106	unsigned group_or_pin;
107	unsigned long *configs;
108	unsigned num_configs;
109};

I want to be sure you are ok with exposing this struct to 
consumers (ie. drivers).  If not, we could pass the 3
components in the API instead.

>To the drivers to iterate over the array of configs,
>please introduce a static helper function:
>
>for_each_config() in something like <linux/pinctrl/pinconf.h>
>so it's easy for driver writers to get this right. (You'll be much
>helped by this function when refactoring the existing drivers as well
>I think.)

Yup ok.

>Doing the same thing with two different functions isn't
>helpful, refactoring like this is much better, it's just more
>work :-D

Yes it's more work, and a bit more risk of breaking stuff.  Out of the
2 methods, I do like this better since there are less APIs.  I will probably
have to get this patch in after my pinctrl driver since it is almost ready.

Thanks!
Sherman
