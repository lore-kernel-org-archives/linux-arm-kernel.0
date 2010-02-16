From: maz@misterjones.org (Marc Zyngier)
Date: Tue, 16 Feb 2010 22:12:55 +0000
Subject: [PATCH 2/2] arm/pxa: Let zeus.c link without CONFIG_PM enabled.
In-Reply-To: <1266356575-1364-1-git-send-email-stefan@datenfreihafen.org>
References: <1266356575-1364-1-git-send-email-stefan@datenfreihafen.org>
Message-ID: <20100216221255.0f905df3@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Feb 2010 22:42:55 +0100
Stefan Schmidt <stefan@datenfreihafen.org> wrote:

> Add some safety check for CONFIG_PM around zeus_power_off(). Without it linking
> can fail like this:
> 
> arch/arm/mach-pxa/built-in.o: In function `zeus_power_off':
> e800.c:(.text+0x2bc8): undefined reference to `pxa27x_cpu_suspend'
> 
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
> 
> --
> 
> This smells a bit fishy as zeus_power_off() is only mapped to pm_power_off and
> that one seems to come and go to nowhere. Is this any magic I don't get on a
> first glance?

The magic takes place in arch/arm/kernel/process.c.

> ---
>  arch/arm/mach-pxa/zeus.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
> index 75f2a37..213279d 100644
> --- a/arch/arm/mach-pxa/zeus.c
> +++ b/arch/arm/mach-pxa/zeus.c
> @@ -621,11 +621,15 @@ static struct pxa2xx_udc_mach_info zeus_udc_info = {
>  	.udc_command = zeus_udc_command,
>  };
>  
> +#ifdef CONFIG_PM
>  static void zeus_power_off(void)
>  {
>  	local_irq_disable();
>  	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP);
>  }
> +#else
> +#define zeus_power_off   NULL
> +#endif
>  
>  #ifdef CONFIG_APM_EMULATION
>  static void zeus_get_power_status(struct apm_power_info *info)

Acked-by: Marc Zyngier <maz@misterjones.org>

Eric, are you willing to take this directly, or do you want me to queue
it for the next merge window with the rest of the fixes?

	M.
-- 
I'm the slime oozin' out from your TV set...
