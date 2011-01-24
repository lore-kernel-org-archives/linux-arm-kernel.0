From: ccross@android.com (Colin Cross)
Date: Mon, 24 Jan 2011 10:50:53 -0800
Subject: [PATCH v2 20/28] ARM: tegra: cpufreq: Disable cpufreq during
	suspend
In-Reply-To: <20110124144142.GA16813@sirena.org.uk>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-21-git-send-email-ccross@android.com>
	<20110124144142.GA16813@sirena.org.uk>
Message-ID: <AANLkTikrUdLM8VmW5yCndf927E=drZF1gGBwXq6Dj5mW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 6:41 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Jan 23, 2011 at 06:01:25PM -0800, Colin Cross wrote:
>> Adds a SUSPEND_PREPARE notification hook to drop the frequency to
>> the lowest possible during suspend. ?This prevents the cpufreq driver
>> from attempting regulator calls after suspend has started - the
>> regulator api can call into drivers that have already been suspended.
>
> Hrm, what's the situation where that happens and why does it cause
> problems? ?The regulator API doesn't care if suspend is going on, and
> nor do any of the current drivers for regulators. ?There is an issue
> with keeping things like I2C alive until the bitter end of suspend so
> you've got a control bus to the regulators but that's a generic issue
> which crops up with other subsystems too so a regulator-specific
> workaround seems dodgy.

The end result is that the regulator driver calls the i2c driver after
the i2c driver has been suspended.  On Tegra, this happens because of
voltage scaling on the CPU regulator, which can be on the i2c bus.  A
sleep in a suspend handler after the i2c bus has been suspended can
cause the cpufreq governor to lower the frequency, and try to lower
the voltage as well.

The problem isn't limited to i2c busses, there are some regulators on
spi busses.  You would need to ensure that any driver that has a
regulator consumer suspends before the regulator driver it
communicates with, and that still wouldn't fix cpufreq, which has a
sysdev suspend handler.

> The patch itself seems fine, it's just that it feels like there's
> something else going on.
>
