From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 22 Aug 2014 13:16:33 +0530
Subject: [PATCH 5/8] pinctrl: add driver for MB86S7x
In-Reply-To: <CACRpkdb_NC7j=XkbMPv8YYLSeEd1AOpFqmD8x+ohC7ds3cPCfg@mail.gmail.com>
References: <1405233067-4725-1-git-send-email-mollie.wu@linaro.org>
 <CACRpkdb_NC7j=XkbMPv8YYLSeEd1AOpFqmD8x+ohC7ds3cPCfg@mail.gmail.com>
Message-ID: <CAJe_Zhe2VuzHtkojm9nxvDTjT4AL7Znvma+5T7JTadvFJ1vAJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 July 2014 21:41, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Jul 13, 2014 at 8:31 AM, Mollie Wu <mollie.wu@linaro.org> wrote:

>
>> +static int
>> +mb86s70_pmx_enable(struct pinctrl_dev *pctl,
>> +                  unsigned func_selector, unsigned group_selector)
>> +{
>> +       struct mb86s70_pmux_chip *pchip = pinctrl_dev_get_drvdata(pctl);
>> +       unsigned long flags;
>> +       const unsigned *pins;
>> +       int i, j;
>> +
>> +       if (group_selector >= grp_count) {
>> +               pr_err("%s:%d\n", __func__, __LINE__);
>> +               return -EINVAL;
>> +       }
>> +
>> +       j = mb86s7x_pgrps[group_selector].num_pins;
>> +       pins = mb86s7x_pgrps[group_selector].pins;
>> +
>> +       spin_lock_irqsave(&pchip->lock, flags);
>> +
>> +       /* Busy if any pin in the same 'bunch' is taken */
>> +       for (i = 0; i < j; i++) {
>> +               u32 val;
>> +               int p = pins[i] / 4 * 4;
>> +
>> +               if (pins[i] >= PINS_VIRT) /* Not for virtual pins */
>> +                       continue;
>> +
>> +               val = readl(pchip->base + p);
>> +               /* skip if no change needed */
>> +               if (val == mb86s7x_pmx_funcs[func_selector].prog_val)
>> +                       continue;
>> +
>> +               if (pchip->pin_busy[p]) {
>> +                       pr_err("%s:%d:%d %d busy\n",
>> +                              __func__, __LINE__, pins[i], p);
>> +                       goto busy_exit;
>> +               }
>> +
>> +               if (pchip->pin_busy[p + 1]) {
>> +                       pr_err("%s:%d:%d %d busy\n",
>> +                              __func__, __LINE__, pins[i], p+1);
>> +                       goto busy_exit;
>> +               }
>
> I don't see why you are doing this and keeping track of
> pins as "busy" or not. One thing the pin control core does
> is to make sure pins do not collide in different use cases,
> it seems like you're re-implementing this check again.
>
>> +               if (p == 64)
>> +                       continue;
>
> This if-clause seems dubious. At least add a comment as
> to what is happening here and why.
>
>> +               if (pchip->pin_busy[p + 2]) {
>> +                       pr_err("%s:%d:%d %d busy\n",
>> +                              __func__, __LINE__, pins[i], p+2);
>> +                       goto busy_exit;
>> +               }
>> +
>> +               if (pchip->pin_busy[p + 3]) {
>> +                       pr_err("%s:%d:%d %d busy\n",
>> +                              __func__, __LINE__, pins[i], p+3);
>> +                       goto busy_exit;
>> +               }
>
> I don't understand this either.
>
> Why all this fuzz around the four pins from p ... p+3?
>
>> +               continue;
>> +busy_exit:
>> +               spin_unlock_irqrestore(&pchip->lock, flags);
>> +               pr_err("%s:%d Take a look!\n", __func__, __LINE__);
>> +               return -EBUSY;
>> +       }
>
> You don't have to have the busy_exit: inside the for-loop right?
>
> Just push it below the return 0; in the end of this function
> so you can get rid of the dangling continue;
>
>> +       pr_debug("Going to enable %s on pins -",
>> +                mb86s7x_pmx_funcs[func_selector].name);
>> +       for (i = 0; i < j; i++) {
>> +               int p = pins[i];
>> +
>> +               pr_debug(" %d", p);
>> +               pchip->pin_busy[p] = true;
>
> So I'm questioning this....
>
>> +               if (p < PINS_VIRT) /* Not for virtual pins */
>
> We need an explanation somewhere about what "virtual pins"
> means in this driver, I have never seen that before.
>
>> +                       writel(mb86s7x_pmx_funcs[func_selector].prog_val,
>> +                              pchip->base + p / 4 * 4);
>
> This may need some static inline like described above to simplify
> the code and make it more readable, but I see what is going on.
>
>> +       }
>> +
>> +       spin_unlock_irqrestore(&pchip->lock, flags);
>> +       pr_debug("\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static void
>> +mb86s70_pmx_disable(struct pinctrl_dev *pctl,
>> +                   unsigned func_selector, unsigned group_selector)
>> +{
>> +       struct mb86s70_pmux_chip *pchip = pinctrl_dev_get_drvdata(pctl);
>> +       unsigned long flags;
>> +       const unsigned *pins;
>> +       int i, j;
>> +
>> +       if (group_selector >= grp_count) {
>> +               pr_err("%s:%d\n", __func__, __LINE__);
>> +               return;
>> +       }
>> +
>> +       j = mb86s7x_pgrps[group_selector].num_pins;
>> +       pins = mb86s7x_pgrps[group_selector].pins;
>> +
>> +       pr_debug("Going to disable %s on pins -",
>> +                mb86s7x_pmx_funcs[func_selector].name);
>> +       spin_lock_irqsave(&pchip->lock, flags);
>> +       for (i = 0; i < j; i++) {
>> +               pr_debug(" %d", pins[i]);
>> +               pchip->pin_busy[pins[i]] = false;
>> +       }
>> +       spin_unlock_irqrestore(&pchip->lock, flags);
>> +       pr_debug("\n");
>> +}
>
> Remove this function. The .disable member is gone from
> struct pinmux_ops, as it was ambiguous, see commit
> 2243a87d90b42eb38bc281957df3e57c712b5e56
> "pinctrl: avoid duplicated calling enable_pinmux_setting for a pin"
>
Hmm... I just got bitten by this while updating the patchset. Sorry I
missed the patch review.

The reasons given in changelog are
  (1) 'Fix' desc->mux_usecount
  (2) The .disable callback is not useful for any of the existing platforms.

Well, for (2) I think it is only reasonable for the provider to need
to know when some resource is released by a user just as when it was
requested.
   Even if the core ensures only one user is provided access to a pin,
the controller driver may still need to know when a pin is no more in
use. For ex, within consecutive 4 pins my controller can not enable a
pin for some function if any in the bunch is already
enabled/configured. So I need to know if the pin has been
disabled/released, so I can go ahead enabling the 'neighbor' pin for
some other role.

For reason (1), there should be some way to fix within the core?

Regards,
Jassi
