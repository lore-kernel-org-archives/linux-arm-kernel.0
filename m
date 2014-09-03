From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Sep 2014 11:17:52 +0200
Subject: [PATCH 5/8] pinctrl: add driver for MB86S7x
In-Reply-To: <CAJe_Zhe2VuzHtkojm9nxvDTjT4AL7Znvma+5T7JTadvFJ1vAJQ@mail.gmail.com>
References: <1405233067-4725-1-git-send-email-mollie.wu@linaro.org>
 <CACRpkdb_NC7j=XkbMPv8YYLSeEd1AOpFqmD8x+ohC7ds3cPCfg@mail.gmail.com>
 <CAJe_Zhe2VuzHtkojm9nxvDTjT4AL7Znvma+5T7JTadvFJ1vAJQ@mail.gmail.com>
Message-ID: <CACRpkda1X-7Cspp9qrfQLsmwNFiqKAUifQizvY-wD_FYb8uANQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 9:46 AM, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 22 July 2014 21:41, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sun, Jul 13, 2014 at 8:31 AM, Mollie Wu <mollie.wu@linaro.org> wrote:

>>> +static void
>>> +mb86s70_pmx_disable(struct pinctrl_dev *pctl,
>>> +                   unsigned func_selector, unsigned group_selector)
>>> +{
>>> +       struct mb86s70_pmux_chip *pchip = pinctrl_dev_get_drvdata(pctl);
>>> +       unsigned long flags;
>>> +       const unsigned *pins;
>>> +       int i, j;
>>> +
>>> +       if (group_selector >= grp_count) {
>>> +               pr_err("%s:%d\n", __func__, __LINE__);
>>> +               return;
>>> +       }
>>> +
>>> +       j = mb86s7x_pgrps[group_selector].num_pins;
>>> +       pins = mb86s7x_pgrps[group_selector].pins;
>>> +
>>> +       pr_debug("Going to disable %s on pins -",
>>> +                mb86s7x_pmx_funcs[func_selector].name);
>>> +       spin_lock_irqsave(&pchip->lock, flags);
>>> +       for (i = 0; i < j; i++) {
>>> +               pr_debug(" %d", pins[i]);
>>> +               pchip->pin_busy[pins[i]] = false;
>>> +       }
>>> +       spin_unlock_irqrestore(&pchip->lock, flags);
>>> +       pr_debug("\n");
>>> +}
>>
>> Remove this function. The .disable member is gone from
>> struct pinmux_ops, as it was ambiguous, see commit
>> 2243a87d90b42eb38bc281957df3e57c712b5e56
>> "pinctrl: avoid duplicated calling enable_pinmux_setting for a pin"
>>
> Hmm... I just got bitten by this while updating the patchset. Sorry I
> missed the patch review.
>
> The reasons given in changelog are
>   (1) 'Fix' desc->mux_usecount
>   (2) The .disable callback is not useful for any of the existing platforms.
>
> Well, for (2) I think it is only reasonable for the provider to need
> to know when some resource is released by a user just as when it was
> requested.

Well the .enable() callback is probably badly named. It's not like
it's requesting a resource, it's just setting the hardware into some
defined state. It should maybe be named .set_mux() or something.

The .disable() call is then pointless because the mux is always
set up in some way, there is no "unmuxed" state.

>    Even if the core ensures only one user is provided access to a pin,
> the controller driver may still need to know when a pin is no more in
> use. For ex, within consecutive 4 pins my controller can not enable a
> pin for some function if any in the bunch is already
> enabled/configured. So I need to know if the pin has been
> disabled/released, so I can go ahead enabling the 'neighbor' pin for
> some other role.

But should not that other role of that pin come from some state
transition in the pin control system anyway?

It is of course possible to add an optional .pin_became_free()
callback down to the driver if I can just wrap my head around
the use case.

Yours,
Linus Walleij
