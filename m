From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 9 Jan 2012 09:28:15 +0100
Subject: [RFC PATCH 1/9] arm: avoid using on_each_cpu hard coded ret value
In-Reply-To: <1325600353-10895-2-git-send-email-gilad@benyossef.com>
References: <1325600353-10895-1-git-send-email-gilad@benyossef.com>
 <1325600353-10895-2-git-send-email-gilad@benyossef.com>
Message-ID: <20120109082815.GB14252@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 04:19:05PM +0200, Gilad Ben-Yossef wrote:
> on_each_cpu always returns a hard coded return code of zero.
> 
> Removing all tests based on this return value saves run time
> cycles for compares and code bloat for branches.
> 
> Cc: Michal Nazarewicz <mina86@mina86.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Peter Zijlstra <a.p.zijlstra@chello.nl>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Ingo Molnar <mingo@elte.hu>
> CC: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Grant Likely <grant.likely@secretlab.ca>
> CC: Rob Herring <rob.herring@calxeda.com>
> CC: linux-arm-kernel at lists.infradead.org
> CC: devicetree-discuss at lists.ozlabs.org
> ---
>  arch/arm/kernel/perf_event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 88b0941..bfd58d8 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -617,7 +617,7 @@ static int __init
>  cpu_pmu_reset(void)
>  {
>  	if (cpu_pmu && cpu_pmu->reset)
> -		return on_each_cpu(cpu_pmu->reset, NULL, 1);
> +		on_each_cpu(cpu_pmu->reset, NULL, 1);
>  	return 0;
>  }
>  arch_initcall(cpu_pmu_reset);
This patch results in no binary change for my test build with SMP=n and
it saves one instruction on SMP=y.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
