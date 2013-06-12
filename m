From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Jun 2013 11:37:16 -0700
Subject: [PATCH] pinctrl: document the pinctrl PM states
In-Reply-To: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
References: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130612183716.GW8164@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@stericsson.com> [130611 13:05]:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This document snippet tries to be helpful and define the pin
> PM states and helpers, and how they should be used to create
> some kind of common ontology around this.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/pinctrl.txt | 118 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt
> index f6e664b..a34ea92 100644
> --- a/Documentation/pinctrl.txt
> +++ b/Documentation/pinctrl.txt
> @@ -1196,6 +1196,124 @@ registered. Thus make sure that the error path in your driver gracefully
>  cleans up and is ready to retry the probing later in the startup process.
>  
>  
> +Default and power management related states
> +===========================================
> +
> +As mentioned earlier the device core will automatically try to obtain a
> +pinctrl handle and activate the "default" state on all drivers.
> +
> +However, for power management and power saving, it is sometimes necessary
> +to switch pin states at runtime. Electrically speaking this involves
> +for example reconfigure some pins to be grounded or pulled-down when the
> +system as a whole goes to sleep, or a pull-up could be turned off when pins
> +are idle, reducing leak current.
> +
> +To help out with this, if CONFIG_PM is selected in the Kconfig, three
> +additional states will also be obtained by the driver core and cached
> +there:
> +
> +"active"   this is indended as an explicit active state, if the "default"
> +           state is not synonymous with the active one.
> +
> +"idle"     this is a state that is relaxing the pins when the system as a
> +           whole is up and running, but these particular pins are unused.
> +
> +"sleep"    this is a state that is used when the whole system goes to
> +           suspend, becomes uninteractive, unresponsive to anything but
> +           specific wake-up events.

In the cases I've seen "idle" and "sleep" are the same. But it sounds like
other people's hardware have different needs and it's optional so:

Acked-by: Tony Lindgren <tony@atomide.com>
