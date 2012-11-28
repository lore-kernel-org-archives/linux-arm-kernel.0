From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Nov 2012 22:58:02 +0800
Subject: [PATCH 6/6 v6] cpufreq, highbank: add support for highbank cpufreq
In-Reply-To: <50B60E9C.9000405@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-7-git-send-email-mark.langsdorf@calxeda.com>
 <20121128023240.GA28170@S2100-06.ap.freescale.net>
 <50B60E9C.9000405@calxeda.com>
Message-ID: <20121128145759.GB28170@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 07:16:12AM -0600, Mark Langsdorf wrote:
> Standard practice is to have cpufreq_set_target() handle voltage
> transitions and leave clk_set_rate() handle the frequency changes.

The standard practice is to have cpufreq_set_target() handle both
voltage and frequency transitions, while voltage is handled by regulator
and frequency by clk API.

> I'd
> have to move most of the logic of hb_set_target() into
> clk_highbank.c:clk_pll_set_rate() and then add extra logic for when
> cpufreq is not enabled/loaded.

You only need to move hb_voltage_change() into cpu clock's .set_rate()
hook with no need of checking if cpufreq is enabled or not.

> I don't think the clk maintainers would
> take that patch, either.

This is all handled platform clock specific .set_rate() hook.  I doubt
it will concern clk maintainers at all, especially when doing so we
will avoid another cpufreq driver by just using cpufreq-cpu0 driver.

Shawn
