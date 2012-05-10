From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 May 2012 17:10:46 +0200
Subject: [PATCH 02/12] pinctrl: basic Nomadik pinctrl interface
In-Reply-To: <4FAAD4EB.4010007@wwwdotorg.org>
References: <1336470270-23518-1-git-send-email-linus.walleij@stericsson.com>
 <4FAAD4EB.4010007@wwwdotorg.org>
Message-ID: <CACRpkdaiTsaBT=20UUOx2mYsK4r5rArVqXfU9LMObFVb3iEA9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 10:34 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/08/2012 03:44 AM, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This adds a scratch pin control interface to the Nomadik pinctrl
>> driver, and defines the pins and groups in the DB8500 ASIC. We
>> define GPIO ranges to cover the pins exposed. The DB8500 has
>> more pins than this but we restrict the driver to the pins that
>> can be controlled from the combined GPIO and pin control hardware
>> to begin with.
>
>> diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
>
>> +static int nmk_list_groups(struct pinctrl_dev *pctldev, unsigned selector)
>> +{
>> + ? ? struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
>> +
>> + ? ? if (selector >= npct->soc->ngroups)
>> + ? ? ? ? ? ? return -EINVAL;
>
> I think all the other drivers removed this error-checking from functions
> called by the pinctrl core, assuming that the core would error-check any
> user-supplied data and respect limits in the pinctrl device descriptor.

Oh yeah that's because I based it off 3.4-rc:s simply, I should just merge
in the pinctrl-mergebase tag and be happy like everyone else, sorry
will fix.

>> +static int __devinit nmk_pinctrl_probe(struct platform_device *pdev)
>
>> + ? ? /* Poke in other ASIC variants here */
>> + ? ? if (platid->driver_data == PINCTRL_NMK_DB8500)
>> + ? ? ? ? ? ? nmk_pinctrl_db8500_init(&npct->soc);
>
> Other platforms have a unique top-level driver for each variant, with
> the probe() function for each variant calling into a utility function.
> That way, the common/utility code doesn't need to contain a
> table/list/... of all the variants. Can the same approach be used here?

Of course I could do it that way, but it's not using this feature
of the driver base to have a string identifier telling which version
it is.

Since I'm unsure, let's ask Arnd.

Arnd, what is your preferred design pattern of:

A) sub-drivers that register one struct platform_driver per
  variant, then calls into a shared core driver, or

B) a shared core driver registering one platform_driver
  with several struct platform_device_id that then call
  sub-drivers depending on which one is found

Either way is actually OK for me, but I was thinking if one
is preferred over the other.

Yours,
Linus Walleij
