From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 26 Jun 2015 10:08:47 +0100
Subject: [PATCH] ARM64: kernel: psci: use restart_handlers instead of
 arm_pm_restart
In-Reply-To: <1622532.VhvqsHJ0rH@diego>
References: <1622532.VhvqsHJ0rH@diego>
Message-ID: <558D169F.7000804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Mark, Lorenzo

On 26/06/15 00:33, Heiko St?bner wrote:
> Instead of hogging the arm_pm_restart callback, register a restart_handler
> to make it possible for machines to register more board-specific
> restart functionality.
>

Just curious to know why do you need board specific restart handlers in
Linux. The firmware implementing PSCI is board specific and can deal
with all board specific handling in the firmware.

> The priority is set to 127, 1 below the "default" to facilitate for
> example the use of regular per-soc restart handlers at their default
> priority 128 and others like the gpio-restart at priority 129 or above.
>
> Non-psci restarts can be necessary when either the psci implementation
> is faulty and does not implement the restart callback or devices need

Interesting, SYSTEM_RESET is mandatory from PSCIv0.2 and why only
exception for faulty PSCI system reset while it's assumed all other
features are never faulty. IMO it needs to be fixed in the firmware.

> even more custom restart operations, like recent rk3288-chromebooks.
> While the soc-level restart could restart those, an external component
> needed to be also reset (via gpio-restart) to allow the device to even
> boot again.
>

Again firmware implementing PSCI is platform specific and can deal any
such customization required.

By the way, I am not arguing against usage of register_restart_handler
over arm_pm_restart, but the reasoning given here.

Regards,
Sudeep
