From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 24 Jan 2011 14:41:43 +0000
Subject: [PATCH v2 20/28] ARM: tegra: cpufreq: Disable cpufreq during
	suspend
In-Reply-To: <1295834493-5019-21-git-send-email-ccross@android.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-21-git-send-email-ccross@android.com>
Message-ID: <20110124144142.GA16813@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 23, 2011 at 06:01:25PM -0800, Colin Cross wrote:
> Adds a SUSPEND_PREPARE notification hook to drop the frequency to
> the lowest possible during suspend.  This prevents the cpufreq driver
> from attempting regulator calls after suspend has started - the
> regulator api can call into drivers that have already been suspended.

Hrm, what's the situation where that happens and why does it cause
problems?  The regulator API doesn't care if suspend is going on, and
nor do any of the current drivers for regulators.  There is an issue
with keeping things like I2C alive until the bitter end of suspend so
you've got a control bus to the regulators but that's a generic issue
which crops up with other subsystems too so a regulator-specific
workaround seems dodgy.

The patch itself seems fine, it's just that it feels like there's
something else going on.
