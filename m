From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Feb 2013 20:32:41 +0100
Subject: [PATCH] pinctrl/pinconfig: add debug interface
In-Reply-To: <511A7478.8040506@wwwdotorg.org>
References: <1360527070-18430-1-git-send-email-linus.walleij@stericsson.com>
 <51195A63.7080706@wwwdotorg.org>
 <CACRpkdZu0+maCE2GjuZcQPZPZbw=Fz0DUHYY8FXPdZEH0PeViQ@mail.gmail.com>
 <511A7478.8040506@wwwdotorg.org>
Message-ID: <CACRpkdYhwbpvfeoSiL1pfhVC+3O+8yMnA-raGimr0RpZdffRHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 5:57 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 02/12/2013 05:54 AM, Linus Walleij wrote:

>> Of course, if this unsigned long is a pointer, this is just a
>> fantastic recipe for shooting oneself in the foot, but again
>> debugfs is just one big gun aimed at ones foot anyway, that's
>> the whole point of debugfs.
>
> But it'd be possible to handle this if the code to modify the map called
> into the individual pinctrl driver to convert the data the user wrote
> into the value to store in the map, just like it does for DT.
>
> Then, it'd work in all cases.

You are right, this is way more elegant. So Laurent, can you add
some optional function pointer to struct pinconf_ops to translate
the passed parameter, and if that function is not assigned we do
not open the debugfs interface for config at all. This will be
quite elegant.

Something like:

int (*pin_config_group_dbg_set) (struct pinctrl_dev *pctldev,
                                           const char *arg,
                                           unsigned long *config);

> Plus, it could convert e.g. "pull up" to 0x10001 rather than requiring
> the user to manually encode the 0x10001 themselves; much more useful.

You are right.

Reconfiguring muxes from debugfs will be different, I guess
that may be handled entirely by the core. But it's a separate thing.

Yours,
Linus Walleij
