From: groeck@google.com (Guenter Roeck)
Date: Thu, 23 Jun 2016 10:23:49 -0700
Subject: [v3 PATCH 3/5] phy: Add USB Type-C PHY driver for rk3399
In-Reply-To: <1466686264-6744-4-git-send-email-zyw@rock-chips.com>
References: <1466686264-6744-1-git-send-email-zyw@rock-chips.com>
 <1466686264-6744-4-git-send-email-zyw@rock-chips.com>
Message-ID: <CABXOdTc11gjrt+_zRs6aJhbgrHXSXnBoG5ZoqwNUKirr_dpX=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

[ ... ]

> +       ret = extcon_register_notifier(tcphy->pd_extcon, EXTCON_USB,
> +                                      &tcphy->event_nb);
> +       if (ret) {
> +               dev_err(dev, "regitster EXTCON_USB notifer failed\n");
> +               return ret;
> +       }
> +
> +       ret = extcon_register_notifier(tcphy->pd_extcon, EXTCON_USB_HOST,
> +                                      &tcphy->event_nb);
> +       if (ret) {
> +               dev_err(dev, "regitster EXTCON_USB_HOST notifer failed\n");
> +               return ret;
> +       }
> +
> +       ret = extcon_register_notifier(tcphy->pd_extcon, EXTCON_DISP_DP,
> +                                      &tcphy->event_nb);
> +       if (ret) {
> +               dev_err(dev, "regitster EXTCON_DISP_DP notifer failed\n");
> +               return ret;
> +       }
> +

I don't think you can register multiple notifiers with the same
notifier block. It may work by chance, but at least the 'next' object
in notifier_clock is set in notifier_chain_register(). Best case it
may work, but worst case it might cause a loop in the list of
notifiers.

Guenter
