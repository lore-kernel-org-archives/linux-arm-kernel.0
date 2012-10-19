From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Oct 2012 14:51:21 +0200
Subject: [PATCH] pinctrl: reserve pins when states are activated
In-Reply-To: <508091C4.9080008@wwwdotorg.org>
References: <1350554487-7914-1-git-send-email-linus.walleij@stericsson.com>
 <508091C4.9080008@wwwdotorg.org>
Message-ID: <CACRpkdbHLpkqGx4bGPxYN43QiQRedirRnf+tQ7avbQmd6k1kQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 1:33 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 10/18/2012 04:01 AM, Linus Walleij wrote:
>> This switches the way that pins are reserved for multiplexing:
>
> The conceptual change makes perfect sense to me.

Thanks...

>> diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
>
>>  void pinmux_free_setting(struct pinctrl_setting const *setting)
> ...
>> +     /*
>> +      * If a setting is active, disable it so that all pins are released
>> +      */
>> +     pinmux_disable_setting(setting);
>
> "*If* a setting is active ..." implies there should be a C if statement
> here to check if the setting is actually active before trying to disable it?

Spot on.

Actually in core.c we're already checking this:

	case PIN_MAP_TYPE_MUX_GROUP:
		if (state == p->state)
			pinmux_disable_setting(setting);
		pinmux_free_setting(setting);
		break;

So this is just buggy driving the refcount down to negative.
(I think Jean-Nicolas noticed this phenomenon...)

I should just delete pinmux_free_setting().

Yours,
Linus Walleij

Yours,
Linus Walleij
