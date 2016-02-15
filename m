From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Feb 2016 00:26:37 +0100
Subject: [PATCH v5 1/3] gpio: xgene: Enable X-Gene standby GPIO as
 interrupt controller
In-Reply-To: <56BB52B8.4040501@arm.com>
References: <1454041735-8434-1-git-send-email-qnguyen@apm.com>
 <1454041735-8434-2-git-send-email-qnguyen@apm.com>
 <56BB52B8.4040501@arm.com>
Message-ID: <CACRpkdYg+Z1Y_MSFxaGbJiMiAPjX5EF4_dnWO6q5LCd0m0Fv_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 4:09 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 29/01/16 04:28, Quan Nguyen wrote:

>> +static void xgene_gpio_sb_domain_deactivate(struct irq_domain *d,
>> +             struct irq_data *irq_data)
>> +{
>> +     struct xgene_gpio_sb *priv = d->host_data;
>> +     u32 gpio = HWIRQ_TO_GPIO(priv, irq_data->hwirq);
>> +
>> +     gpiochip_unlock_as_irq(&priv->gc, gpio);
>
> Is it right to do the unlock both in irq_shutdown and domain_deactivate?
> This seems a bit odd to me to have such an inbalance. My hunch is that
> you should either implement irq_startup, do the locking there and drop
> the unlock drop deactivate, or kill irq_shutdown.
>
> Linus, what do you think?

Those functions should be called in .irq_alloc/release_resources(), that is
why Gleixner added those callbacks in the first place.

Yours,
Linus Walleij
