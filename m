From: mingo@kernel.org (Ingo Molnar)
Date: Thu, 2 May 2013 09:34:00 +0200
Subject: [PATCH -v7 11/11] Move arch/x86 reboot= handling to generic
 kernel.
In-Reply-To: <1367428011-17123-12-git-send-email-holt@sgi.com>
References: <1367428011-17123-1-git-send-email-holt@sgi.com>
 <1367428011-17123-12-git-send-email-holt@sgi.com>
Message-ID: <20130502073400.GD26361@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Robin Holt <holt@sgi.com> wrote:

> Merge together the unicore32, arm, and x86 reboot= command line
> parameter handling.

Nice!

> +		switch (*str) {
> +#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
> +		case 'w':
> +			reboot_mode = REBOOT_WARM;
> +			break;
> +
> +		case 'c':
> +			reboot_mode = REBOOT_COLD;
> +			break;
> +
> +#ifdef CONFIG_SMP
> +		case 's':
> +			if (isdigit(*(str+1))) {
> +				reboot_cpu = (int) (*(str+1) - '0');
> +				if (isdigit(*(str+2)))
> +					reboot_cpu = reboot_cpu*10 + (int)(*(str+2) - '0');
> +			}
> +			/*
> +			 * We will leave sorting out the final value
> +			 * when we are ready to reboot, since we might not
> +			 * have detected BSP APIC ID or smp_num_cpu
> +			 */
> +			break;
> +#endif /* CONFIG_SMP */
> +
> +#else
> +		case 's':
> +			reboot_mode = REBOOT_WARM;
> +		case 'h':
> +			reboot_mode = REBOOT_COLD;
> +#endif

This architecture dependent bit is not so nice.

I doubt the 's' parameter is used widely at all on x86 [it's more like a 
debug/hack parameter], so might as well just pick up a new character (for 
example capital 'S'?) and have the same parameters on every architecture.

Thanks,

	Ingo
