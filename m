From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 00:24:13 +0200
Subject: [PATCH] arm: Prevent memory aliasing on non-LPAE kernels
In-Reply-To: <1369950320-22784-1-git-send-email-stepanm@codeaurora.org>
References: <1369950320-22784-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <3054064.aJsgTxiNUL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 May 2013 14:45:20 Stepan Moskovchenko wrote:
> 
>  void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
> +#ifndef CONFIG_ARM_LPAE
> +       if (base > ((phys_addr_t)~0)) {
> +               pr_crit("Ignoring memory at 0x%08llx due to lack of LPAE support\n",
> +                       base);
> +               return;
> +       }
> +
> +       if (size > ((phys_addr_t)~0))
> +               size = ((phys_addr_t)~0);
> +
> +       /* arm_add_memory() already checks for the case of base + size > 4GB */
> +#endif
>         arm_add_memory(base, size);
>  }

This looks wrong for the case where 'base' is between >0 and 4GB and 'size'
makes it spill over the 4GB boundary. You need to set
'size = (phys_addr_t)~0 - base' then.

	Arnd
