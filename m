From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Dec 2016 22:48:32 +0000
Subject: [PATCH v2 2/2] arm: perf: Mark as non-removable
In-Reply-To: <20161221150340.25657-3-alexander.stein@systec-electronic.com>
References: <20161221150340.25657-1-alexander.stein@systec-electronic.com>
 <20161221150340.25657-3-alexander.stein@systec-electronic.com>
Message-ID: <20161222224547.GA30170@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 21, 2016 at 04:03:40PM +0100, Alexander Stein wrote:
> This driver can only built into the kernel. So disallow driver bind/unbind
> and also prevent a kernel error in case DEBUG_TEST_DRIVER_REMOVE is
> enabled.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  arch/arm/kernel/perf_event_v7.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index b942349..795e373 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -2029,6 +2029,7 @@ static int armv7_pmu_device_probe(struct platform_device *pdev)
>  static struct platform_driver armv7_pmu_driver = {
>  	.driver		= {
>  		.name	= "armv7-pmu",
> +		.suppress_bind_attrs = true,
>  		.of_match_table = armv7_pmu_of_device_ids,
>  	},

While this patch looks correct, the other perf_event_* drivers (e.g. those
under arch/arm/) will need similar treatment.

More generally, updating each and every driver in this manner seems like a
scattergun approach that is tiresome and error prone.

IMO, it would be vastly better for a higher layer to enforce that we don't
attempt to unbind drivers where the driver does not have a remove callback, as
is the case here (and I suspect most over cases where DEBUG_TEST_DRIVER_REMOVE
is blowing up).

Is there any reason that can't be enforced at the bus layer, say?

Thanks,
Mark.
