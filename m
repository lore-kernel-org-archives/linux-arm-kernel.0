From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 27 Jan 2016 08:14:21 +0100
Subject: [PATCH] drivers: power: reset: at91-reset: Provide reset reason
 via sysfs (amended with Signed-off-by tag)
In-Reply-To: <20160125085539.GB16261@piout.net>
References: <1453394936-16616-1-git-send-email-davidm@egauge.net>
 <20160125085539.GB16261@piout.net>
Message-ID: <20160127071418.GA7124@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 25, 2016 at 09:55:39AM +0100, Alexandre Belloni wrote:
> (Adding Sebastian in Cc)

Thanks :)

> [...]
> > +static ssize_t reset_reason_show(struct device *,
> > +				 struct device_attribute *attr,
> > +				 char *);
> > +static DEVICE_ATTR(reset_reason, S_IRUSR, reset_reason_show, NULL);

IMHO power_on_reason is more fitting, since it also covers things
like "wake-on-rtc" or "power-button".

> All sysfs files have to be documented. Can you add some documentation in
> Documentation/ABI ?
> 
> Also, I think this should be added as a generic file for the whole
> subsystem.

Currently the subsystem does not have any generic files, since the
power/reset drivers just take care of system reset/shutdown. I think
we do not need to introduce it for one generic file, but we should
try to standardize the ABI (including the values).

I can see, that there are currently six different values possible
for at91-reset, but it's unclear to me what some of them mean, so
that should be covered in the ABI documentation. Also it may make
sense to drop the reset suffix for some of them (e.g. "unknown").

    reason = "general reset";

    This is power-on by power-button/applying voltage?

    reason = "wakeup";

    This is power-on by RTC?

    reason = "watchdog reset";

    I gues this is reboot triggered by watchdog timeout?

    reason = "software reset";

    This will be returned if system was started by rebooting via
    "reboot / shutdown -r"?

    reason = "user reset";

    This is returned if the board's reset button was pressed?

    reason = "unknown reset";

    => just use "unknown"

I suggest to create include/linux/power/power_on_reason.h, with
standardized values, that are used by the driver:

#define POWER_ON_REASON_RTC "RTC wakeup"
#define POWER_ON_REASON_WATCHDOG "watchdog timeout"
...

> [...]

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/2972f6b1/attachment.sig>
