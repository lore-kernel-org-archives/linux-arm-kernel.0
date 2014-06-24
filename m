From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Jun 2014 11:44:07 -0400 (EDT)
Subject: [PATCH v6 1/4] arm: fiq: Add callbacks to manage FIQ routings
In-Reply-To: <1403623097-1153-2-git-send-email-daniel.thompson@linaro.org>
References: <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
 <1403623097-1153-1-git-send-email-daniel.thompson@linaro.org>
 <1403623097-1153-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <alpine.LFD.2.11.1406241138450.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jun 2014, Daniel Thompson wrote:

> Currently enable_fiq/disable_fiq use a simple offset to convert an IRQ
> virq into a FIQ virq. This is too inflexible for multi-platform kernels
> and makes runtime error checking impossible.
> 
> We solve this by introducing a flexible mapping that allows interrupt
> controllers that support FIQ to register those mappings. This, in turn,
> makes it much possible for drivers in DT kernels to install FIQ handlers
> without knowing anything about the interrupt controller.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/include/asm/fiq.h |   7 +++
>  arch/arm/kernel/fiq.c      | 103 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 108 insertions(+), 2 deletions(-)

[...]

> +bool has_fiq(int fiq)
> +{
> +	struct fiq_data *data = lookup_fiq_data(fiq);
> +
> +	if (data)
> +		return true;
> +
> +	if (fiq_start == -1)
> +		return false;
> +
> +	return fiq > fiq_start;

Shouldn't this be fiq >= fiq_start ?

Other than that...

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
