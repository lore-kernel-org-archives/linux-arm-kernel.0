From: geoff@infradead.org (Geoff Levand)
Date: Thu, 26 Mar 2015 15:29:17 -0700
Subject: [PATCH 3/5] arm64: kdump: do not go into EL2 before starting a
 crash dump kernel
In-Reply-To: <1427358533-3754-4-git-send-email-takahiro.akashi@linaro.org>
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
 <1427358533-3754-4-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1427408957.6526.1.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-03-26 at 17:28 +0900, AKASHI Takahiro wrote:
> @@ -64,7 +65,11 @@ void soft_restart(unsigned long addr)
>  	setup_mm_for_reboot();
>  
>  	cpu_soft_restart(virt_to_phys(cpu_reset),
> -		is_hyp_mode_available(), addr);
> +#ifdef CONFIG_KEXEC
> +		!in_crash_kexec &&
> +#endif

Why not define in_crash_kexec without condition on CONFIG_KEXEC, say
here in process.c and then avoid these preprocessor conditionals.

> +		is_hyp_mode_available(),
> +		addr);
>  
>  	/* Should never get here */
>  	BUG();
