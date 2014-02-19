From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Feb 2014 09:40:37 +0000
Subject: [PATCH 01/17] amba: Let runtime PM callbacks be available for
 CONFIG_PM
In-Reply-To: <1391529538-21685-2-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140219094037.GQ21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 04:58:42PM +0100, Ulf Hansson wrote:
> Convert to the SET_PM_RUNTIME_PM macro while defining the runtime PM
> callbacks. This means the callbacks becomes available for both
> CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME, which is needed by drivers and
> power domains.

This patch is wrong, because it causes build errors:

drivers/amba/bus.c:126:18: error: 'pm_generic_suspend_late' undeclared here (not in a function)
drivers/amba/bus.c:127:18: error: 'pm_generic_resume_early' undeclared here (not in a function)
drivers/amba/bus.c:128:17: error: 'pm_generic_freeze_late' undeclared here (not in a function)
drivers/amba/bus.c:129:16: error: 'pm_generic_thaw_early' undeclared here (not in a function)
drivers/amba/bus.c:130:19: error: 'pm_generic_poweroff_late' undeclared here (not in a function)
drivers/amba/bus.c:131:19: error: 'pm_generic_restore_early' undeclared here (not in a function)

The failing configuration is:

# CONFIG_SUSPEND is not set
CONFIG_PM_RUNTIME=y
CONFIG_PM=y

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
