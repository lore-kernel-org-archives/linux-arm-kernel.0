From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 20 Oct 2014 02:05:42 +0000
Subject: [PATCH] spi/atmel: add support for runtime PM
In-Reply-To: <7hd29qhj3i.fsf@deeprootsystems.com>
References: <1413424160-21180-1-git-send-email-wenyou.yang@atmel.com>
 <7hk33yhms4.fsf@deeprootsystems.com>	<20141017135716.GS1820@sirena.org.uk>
 <7hd29qhj3i.fsf@deeprootsystems.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641BF594F37@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at kernel.org]
> Sent: Friday, October 17, 2014 10:22 PM
> To: Mark Brown
> Cc: Yang, Wenyou; linux-spi at vger.kernel.org; linux-kernel at vger.kernel.org; Ferre,
> Nicolas; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] spi/atmel: add support for runtime PM
> 
> Mark Brown <broonie@kernel.org> writes:
> 
> > On Fri, Oct 17, 2014 at 06:02:35AM -0700, Kevin Hilman wrote:
> >> Wenyou Yang <wenyou.yang@atmel.com> writes:
> >
> >> > +	if (!pm_runtime_suspended(dev)) {
> >> > +		clk_disable_unprepare(as->clk);
> >> > +		pinctrl_pm_select_sleep_state(dev);
> >> > +	}
> >
> >> a.k.a. pm_runtime_put_sync() since the ->runtime_suspend() callback
> >> does the same thing.
> >
> > Will that do the right thing when runtime PM is disabled in Kconfig?
> 
> Good point.
> 
> Then the way to make this cleaner, and obvious on inspection that system
> suspend/resume are doing the same thing as runtime suspend/resume is to have -
> >suspend call the runtime_suspend function.
> 
> The runtime suspend/resume functions then should be wrapped in CONFIG_PM
> instead of CONFIG_PM_RUNTIME.
But if the runtime PM is disabled,  __pm_runtime_idle() return -ENOSYS, which invoked by pm_runtime_put_sync(), in spite of the runtime suspend/resume functions wrapper,

> 
> Kevin

Best Regards,
Wenyou Yang
