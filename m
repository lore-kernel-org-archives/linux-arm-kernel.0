From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Aug 2012 16:50:13 -0700
Subject: [PATCH v2 07/31] arm64: Process management
In-Reply-To: <1344966752-16102-8-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-8-git-send-email-catalin.marinas@arm.com>
Message-ID: <20120814235013.GC19607@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 14, 2012 at 06:52:08PM +0100, Catalin Marinas wrote:

> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> new file mode 100644
> index 0000000..c4a4e1c
> --- /dev/null
> +++ b/arch/arm64/kernel/process.c
> @@ -0,0 +1,416 @@

[...]
> +/*
> + * Function pointers to optional machine specific functions
> + */
> +void (*pm_power_off)(void);
> +EXPORT_SYMBOL(pm_power_off);
> +
> +void (*pm_restart)(const char *cmd);
> +EXPORT_SYMBOL_GPL(pm_restart);
[...]
> +void (*pm_idle)(void) = default_idle;
> +EXPORT_SYMBOL(pm_idle);

Does it really make sense to export these to modules?

I find the powerpc way of having a machine descriptor structure with these
(and other) function pointers in it a bit cleaner, since it gives you
one place to plug it all in. I'd recommend that you consider doing that
here as well, for these three and potentially other cases in the future.

(See arch/powerpc/include/asm/machdep.h, struct machdep_calls).

> +void machine_halt(void)
> +{
> +	machine_shutdown();
> +	while (1);
> +}
> +
> +void machine_power_off(void)
> +{
> +	machine_shutdown();
> +	if (pm_power_off)
> +		pm_power_off();
> +}

Printing something here along the lines of "System halted, OK to power off"
is useful.


-Olof
