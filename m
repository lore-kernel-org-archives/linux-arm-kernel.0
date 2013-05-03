From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 10:38:39 +0200
Subject: [PATCH] ARM: Adds pin config API to set all configs in one
 function
In-Reply-To: <051069C10411E24D9749790C498526FA1BCF706F@SJEXCHMB12.corp.ad.broadcom.com>
References: <1366841010-2823-1-git-send-email-syin@broadcom.com>
 <CACRpkdbT7f8ujCHZxKg26iMKcrAb+_yHW_2YsZwkoo892rkgTA@mail.gmail.com>
 <051069C10411E24D9749790C498526FA1BCF5427@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdZ6zQdivtq5wmizovWEGb-Q9xzA6EE8CafnuV13hzX_UA@mail.gmail.com>
 <051069C10411E24D9749790C498526FA1BCF706F@SJEXCHMB12.corp.ad.broadcom.com>
Message-ID: <CACRpkdYw--zVux+j1KYfW6CejdWWUheo3Ypo_X1Kt1qvNyQKRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 2, 2013 at 2:07 AM, Sherman Yin <syin@broadcom.com> wrote:
> [Me]:
>>Notice especially the added num_configs parameter that was
>>missing from pin_config_set_all() in your patch, please tell
>>me how else you deduct the size of the configs array.
>
> We are passing a pointer to struct pinctrl_setting_configs,
> which should have the num_configs already:
>
> 105struct pinctrl_setting_configs {
> 106     unsigned group_or_pin;
> 107     unsigned long *configs;
> 108     unsigned num_configs;
> 109};
>
> I want to be sure you are ok with exposing this struct to
> consumers (ie. drivers).  If not, we could pass the 3
> components in the API instead.

Damned I got it wrong. I was totally confused by
the passing of the struct to the driver and not really
grasping what it contained.

The idea was to pass the array of configs (since this
is dealing with configs, not multuiplexing) and then
a number telling how many configs there are in the
array.

Pass struct pinctrl_setting_configs is not OK because
then all of a sudden we're starting to expose a lot of
pinctrl internals to the drivers and that will invariably
be abused: one day someone will make a pinconfig
function that look at the mux group just because it's
convenient...

So I was after something like this:

int (*pin_config_set) (struct pinctrl_dev *pctldev,
                               unsigned pin,
                               unsigned long *configs,
                               unsigned num_configs);

(And same for groups.)

So we get an array of configs and the driver can
iterate over this. Since these are
unsigned longs we do not need a special helper
as I thought.

And then you should refactor the drivers to account
for this.

Yours,
Linus Walleij
