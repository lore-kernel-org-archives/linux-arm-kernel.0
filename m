From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Sep 2018 16:34:29 -0700
Subject: [PATCH] gpio: omap: Remove custom PM calls and use cpu_pm instead
In-Reply-To: <20180911183729.17110-1-tony@atomide.com>
References: <20180911183729.17110-1-tony@atomide.com>
Message-ID: <20180911233429.GF5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [180911 18:41]:
> For omap2, we don't need to save context and don't want to remove any
> triggering so let's add a quirk flag for that.
...

> +	switch (cmd) {
> +	case CPU_CLUSTER_PM_ENTER:
> +		/* Gets cleard on runtime_suspend */
> +		bank->power_mode = OFF_MODE;

Oops I forgot to check for OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER
here, this should be:

	if (bank->quirks & OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER)
		bank->power_mode = OFF_MODE;

Regards,

Tony
