From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 May 2018 16:42:08 +0100
Subject: [PATCH] drivers/bus: arm-cci: fix build warnings
In-Reply-To: <0db1b8cd-b695-6cbf-9b27-f632b76bad11@arm.com>
References: <20180528154228.2403116-1-arnd@arndb.de>
 <0db1b8cd-b695-6cbf-9b27-f632b76bad11@arm.com>
Message-ID: <20180529154207.GJ17159@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 04:34:01PM +0100, Robin Murphy wrote:
> On 28/05/18 16:41, Arnd Bergmann wrote:
> >When the arm-cci driver is enabled, but both CONFIG_ARM_CCI5xx_PMU and
> >CONFIG_ARM_CCI400_PMU are not, we get a warning about how parts of
> >the driver are never used:
> >
> >drivers/perf/arm-cci.c:1454:29: error: 'cci_pmu_models' defined but not used [-Werror=unused-variable]
> >drivers/perf/arm-cci.c:693:16: error: 'cci_pmu_event_show' defined but not used [-Werror=unused-function]
> >drivers/perf/arm-cci.c:685:16: error: 'cci_pmu_format_show' defined but not used [-Werror=unused-function]
> >
> >Marking all three functions as __maybe_unused avoids the warnings in
> >randconfig builds. I'm doing this lacking any ideas for a better fix.
> 
> Yeah, it's a bit of a silly configuration to allow building a driver
> supporting no PMU types, but I couldn't find a way to enforce "at least one
> sub-option enabled" logic without introducing mutually-exclusive
> dependencies which kbuild thinks are recursive.
> 
> An alternative would be to remove the CCI400/CCI5x0 configurability
> altogether - I've not not looked in detail at how much difference that
> actually makes.
> 
> Otherwise, as an immediate quick-fix:
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I'll pick this one up into the arm perf tree.

Will
