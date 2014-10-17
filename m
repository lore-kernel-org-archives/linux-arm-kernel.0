From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 17 Oct 2014 07:22:09 -0700
Subject: [PATCH] spi/atmel: add support for runtime PM
In-Reply-To: <20141017135716.GS1820@sirena.org.uk> (Mark Brown's message of
 "Fri, 17 Oct 2014 15:57:16 +0200")
References: <1413424160-21180-1-git-send-email-wenyou.yang@atmel.com>
 <7hk33yhms4.fsf@deeprootsystems.com>
 <20141017135716.GS1820@sirena.org.uk>
Message-ID: <7hd29qhj3i.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Fri, Oct 17, 2014 at 06:02:35AM -0700, Kevin Hilman wrote:
>> Wenyou Yang <wenyou.yang@atmel.com> writes:
>
>> > +	if (!pm_runtime_suspended(dev)) {
>> > +		clk_disable_unprepare(as->clk);
>> > +		pinctrl_pm_select_sleep_state(dev);
>> > +	}
>
>> a.k.a. pm_runtime_put_sync() since the ->runtime_suspend() callback does
>> the same thing.
>
> Will that do the right thing when runtime PM is disabled in Kconfig?

Good point.

Then the way to make this cleaner, and obvious on inspection that system
suspend/resume are doing the same thing as runtime suspend/resume is to
have ->suspend call the runtime_suspend function.

The runtime suspend/resume functions then should be wrapped in CONFIG_PM
instead of CONFIG_PM_RUNTIME.

Kevin
