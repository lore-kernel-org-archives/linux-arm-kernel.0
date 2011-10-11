From: khilman@ti.com (Kevin Hilman)
Date: Tue, 11 Oct 2011 12:01:17 -0700
Subject: [PATCH v6 14/16] OMAP2+: UART: Take console_lock in suspend path
	if not taken
In-Reply-To: <1317380561-661-5-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:32:39 +0530")
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-5-git-send-email-govindraj.raja@ti.com>
Message-ID: <87sjmz1hfm.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> In suspend path the console_lock is taken by uart_port_suspend
> however when no_console_suspend is used console_lock is not taken.
>
> During system wide suspend omap_pwr_domain hooks cut all
> clocks that are left enabled. So its unsafe to proceed printing after
> clocks are cut by pwr_domain hooks. 

As I've mentioned in previous reviews, when no_console_suspend is
enabled, the user has explicitly requested console output during
suspend.  In order to support that, we should not be cutting clocks at
all in that mode.

One way to address this would be to just disable runtime PM in the
->prepare method of the driver if no_console_suspend is enabled.

> Also pm_runtime will be disabled after dpm_suspend devices happens.

Not sure why this is relevant.

> So buffer all prints in suspend path by taking console_lock and print
> them back safely after power domain hooks re-enable clocks back.
>
> Use CONFIG_SERIAL_OMAP_CONSOLE macro check to take console_lock since
> console ops are available only if omap console is defined.
> omap-serial can be built as module without console support.

Please revisit use of #ifdefs.  (c.f. #ifdefs are ugly in
Documentation/SubmittingPatches)

Kevin
