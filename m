From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 31 May 2017 13:59:42 -0700
Subject: [PATCH v2 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
In-Reply-To: <20170531061457.23744-6-o.rempel@pengutronix.de>
References: <20170531061457.23744-1-o.rempel@pengutronix.de>
 <20170531061457.23744-6-o.rempel@pengutronix.de>
Message-ID: <20170531135942.20a72fe106667791e874fb20@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 May 2017 08:14:56 +0200 Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On some boards the SoC can use one pin "PMIC_STBY_REQ" to notify th PMIC
> about state changes. In this case internal state of PMIC must be
> preconfigured for upcomming state change.
> It works fine with the current regulator framework, except with the
> power-off case.
> 
> This patch is providing an optional pm_power_off_prepare handler
> which will configure the PMIC_StandBy state to disable all power lines.
> 
> In my power consumption test on RIoTBoard, I got the following results:
> poweroff without this patch:	320 mA
> poweroff with this patch:	2   mA
> suspend to ram:			40  mA
> 
> ...
>
> +static int pfuze_poweroff_pre_init(struct pfuze_chip *pfuze_chip)
> +{
> +	if (pfuze_chip->chip_id != PFUZE100) {
> +		dev_warn(pfuze_chip->dev, "Requested pm_power_off_prepare handler for not supoorted chip\n");
> +		return -ENODEV;
> +	}
> +
> +	if (pm_power_off_prepare) {
> +		dev_warn(pfuze_chip->dev, "pm_power_off_prepare is already registred.\n");
> +		return -EBUSY;
> +	}
> +
> +	syspm_pfuze_chip = pfuze_chip;
> +	pm_power_off_prepare = pfuze_poweroff_pre;
> +
> +	return 0;
> +}
> +

Ah, there it is.

This looks a bit dodgy.  What happens after someone does rmmod on this
driver?

(typo in comment: "supoorted")

(I wish we could get "poweroff" and "power_off" consistent)
