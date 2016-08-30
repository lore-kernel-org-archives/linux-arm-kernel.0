From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Aug 2016 12:12:22 +0100
Subject: [PATCHv3] arm: l2x0: add PMU support
In-Reply-To: <1472552178-26201-1-git-send-email-mark.rutland@arm.com>
References: <1472552178-26201-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160830111222.GN1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 11:16:18AM +0100, Mark Rutland wrote:
> The L2C-220 (AKA L220) and L2C-310 (AKA PL310) cache controllers feature
> a Performance Monitoring Unit (PMU), which can be useful for tuning
> and/or debugging. This hardware is always present and the relevant
> registers are accessible to non-secure accesses. Thus, no special
> firmware interface is necessary.
> 
> This patch adds support for the PMU, plugging into the usual perf
> infrastructure. The overflow interrupt is not always available (e.g. on
> RealView PBX A9 it is not wired up at all), and the hardware counters
> saturate, so the driver does not make use of this. Instead, the driver
> periodically polls and reset counters as required to avoid losing
> events due to saturation.
...
> +	/*
> +	 * Choose the name to identify the PMU under sysfs. This is also used
> +	 * by l2x0_pmu_event_attr_is_visible to determine which events to
> +	 * display, as the PL310 PMU supports a superset of L220 events.
> +	 *
> +	 * The L210 PMU has a different programmer's interface, and is not
> +	 * supported by this driver.

This rather worries me a bit - if the L2C-210 needs a different driver,
should we be putting this driver in this file, or should we be keeping
it as a separate file?  What if L2C-210 grows a PMU driver which is
also tacked on the end of the file - it seems to me that this is rather
unwieldy.

My feeling is that we've already enough random bits tacked into this
file supporting all the L2C-210 related variants.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
