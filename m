From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Fri, 20 Oct 2017 17:54:16 -0700
Subject: [PATCH 7/7] gpio: brcmstb: implement suspend/resume/shutdown
In-Reply-To: <aa8a2900-22a5-5ec5-2afc-038fc42ea940@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
 <20170930034057.15166-8-opendmb@gmail.com>
 <20171019090359.GB31645@kessel>
 <aa8a2900-22a5-5ec5-2afc-038fc42ea940@gmail.com>
Message-ID: <CADtm3G5utU_-6+FMqnxN0LYJggLhSe7Q6V5LbwchLQLe5zVing@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 11:39 AM, Doug Berger <opendmb@gmail.com> wrote:
>>> +static int brcmstb_gpio_resume(struct device *dev)
>>> +{
>>> +    struct brcmstb_gpio_priv *priv = dev_get_drvdata(dev);
>>> +    struct brcmstb_gpio_bank *bank;
>>> +    u32 wake_mask = 0;
>>
>> This isn't really being used as a mask, contrary to appearances.  It's
>> just tracking whether any active IRQs were seen.  Please change to use a
>> bool instead and adjust the name accordingly.
>>
>
> I see your point, but I believe it is cleaner to use this to consolidate
> the bit masks returned by each __brcmstb_gpio_get_active_irqs() call.
> This allows a single test rather than a test per bank.

What about something like this?

bool need_wakeup_event = false;

list_for_each_entry(bank, &priv->bank_list, node) {
        need_wakeup_event |= !!__brcmstb_gpio_get_active_irqs(bank);
        brcmstb_gpio_bank_restore(priv, bank);
}

if (priv->parent_wake_irq && need_wakeup_event)
        pm_wakeup_event(dev, 0);
