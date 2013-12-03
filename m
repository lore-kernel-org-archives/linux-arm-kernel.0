From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Dec 2013 17:08:15 +0000
Subject: [RFC part3 PATCH 2/2] ARM64 / clocksource: Use
 arch_timer_acpi_init()
In-Reply-To: <1386088891-2917-3-git-send-email-hanjun.guo@linaro.org>
References: <1386088891-2917-1-git-send-email-hanjun.guo@linaro.org>
 <1386088891-2917-3-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20131203170815.GB16025@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 04:41:31PM +0000, Hanjun Guo wrote:
> Use arch_timer_acpi_init() on ARM64 to initialise arch timer
> in ACPI way when DT is not available.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/time.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
> index 29c39d5..fb009da 100644
> --- a/arch/arm64/kernel/time.c
> +++ b/arch/arm64/kernel/time.c
> @@ -67,6 +67,10 @@ void __init time_init(void)
>  
>  	clocksource_of_init();
>  
> +	/* if can't be initialised from DT, try ACPI way */
> +	if (!arch_timer_get_rate())
> +		arch_timer_acpi_init();
> +

As mentioned on the previous patch, I think for the timebeing we should
rely on CNTFREQ.

Additionally, if you need to do this we should have an analagous
mechanism to clocksource_of_init() that performs this initialisation for
ACPI, and here we can call a clocksource_*_init function that does the
right thing.

There's no need for this file to know anything about ACPI.

Mark.
