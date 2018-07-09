From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jul 2018 00:27:49 +0200
Subject: [PATCH v3] soc: imx: gpc: Turn PU domain on/off in sleep on 6qp
In-Reply-To: <ab0c7997bdb0caf6fe7e842315bb9565c2cb059d.1530895248.git.leonard.crestez@nxp.com>
References: <ab0c7997bdb0caf6fe7e842315bb9565c2cb059d.1530895248.git.leonard.crestez@nxp.com>
Message-ID: <CAPDyKFqb6eZ2SYG612yqiNisv7UV1q3UHYfZfemmvv9Q4w=Png@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 July 2018 at 18:46, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> On imx6qp power gating on the PU domain is disabled because of errata
> ERR009619. However power gating during suspend/resume can still be
> performed.

Sounds a bit hand wavy. Exactly why can it be done during system suspend/resume?

>
> Enable this by implementing SLEEP_PM_OPS in imx_pgc_power_domain_driver.
>
> In order to ensure correct ordering add device links from devices inside
> the PU domain to the pgc platform_device.

In genpd, the PM domain gets powered off after all device's
corresponding ->suspend_noirq() callback has been invoked - and it
also considers if there are some wakeup settings enabled, possibly
avoiding to do the power off.

It sound like the imx's power domain driver ->power_off|on() callback
should deal with this, to make get a consistent behavior. I understand
that you currently can't tell under what circumstances the
->power_off|on() callbacks are being invoked, that may need some
changes in genpd.

Currently we have a flag, GENPD_FLAG_ALWAYS_ON which makes genpd to
always prevent power off. Perhaps we should add a new flag
"GENPD_FLAG_RUNTIME_ON", which makes genpd to call the
->power_on|off() callbacks, but only during system wide PM.

Thoughts?

[...]

Kind regards
Uffe
