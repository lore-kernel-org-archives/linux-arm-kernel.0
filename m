From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Jun 2013 10:28:13 +0200
Subject: [PATCH 1/3] drivers: pinctrl sleep and idle states in the core
In-Reply-To: <51AF73E9.90506@wwwdotorg.org>
References: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
 <51AF73E9.90506@wwwdotorg.org>
Message-ID: <CACRpkdY_s_RkErKLqVOWdE-A80CZOq7+VZSE8jcYSUbYkvsYYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 5, 2013 at 7:22 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

>> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
>
>> +int pinctrl_pm_select_default_state(struct device *dev)
>
>> +int pinctrl_pm_select_sleep_state(struct device *dev)
>
>> +int pinctrl_pm_select_idle_state(struct device *dev)
>
> The implementation of those 3 functions is basically identical. I'd be
> inclined to move it to a helper function, and just pass (dev,
> pins->xxx_state) to it.

Just to follow up on this now that I'm adding one more state.

I tried to create a refactoring patch for this but couldn't come
up with anything apropriate along the lines above. For example
this function:

int pinctrl_pm_select_default_state(struct device *dev)
{
        struct dev_pin_info *pins = dev->pins;
        int ret;

        if (!pins)
                return 0;
        if (IS_ERR(pins->default_state))
                return 0; /* No default state */
        ret = pinctrl_select_state(pins->p, pins->default_state);
        if (ret)
                dev_err(dev, "failed to activate default pinctrl state\n");
        return ret;
}

Would be refactored into something like this:

static int pinctrl_pm_select_state(struct device *dev, struct pinctrl_state *s)
{
        struct dev_pin_info *pins = dev->pins;

        if (IS_ERR(s))
                return 0;
        return pinctrl_select_state(pins->p, s);
}

int pinctrl_pm_select_default_state(struct device *dev)
{
        struct dev_pin_info *pins = dev->pins;
        int ret;

        if (!pins)
                return 0;
        if (IS_ERR(pins->default_state))
                return 0; /* No default state */
        ret = pinctrl_pm_select_state(dev, pins->default_state);
        if (ret)
                dev_err(dev, "failed to activate default pinctrl state\n");
        return ret;
}

That is not any elegant, I can cut down the lines by removing
debug messages but still we're dereferencing the pins twice and other
ugliness like that. Also pinctrl_pm_select_state() becomes more and more
a NULL wrapper around pinctrl_select_state() itself. If you have some other
suggestion or a patch ... I just can't see any elegant refactoring here.

Yours,
Linus Walleij
