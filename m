From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 30 May 2013 16:10:54 -0600
Subject: [PATCH] arm: Prevent memory aliasing on non-LPAE kernels
In-Reply-To: <1369950320-22784-1-git-send-email-stepanm@codeaurora.org>
References: <1369950320-22784-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <20130530221054.GA31643@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 02:45:20PM -0700, Stepan Moskovchenko wrote:
>  void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
> +#ifndef CONFIG_ARM_LPAE
> +	if (base > ((phys_addr_t)~0)) {

The #ifdef is probably not necessary here, simply checking that
base/size can be represented in a phys_addr_t is enough.

> +		pr_crit("Ignoring memory at 0x%08llx due to lack of LPAE support\n",
> +			base);
> +		return;
> +	}
> +
> +	if (size > ((phys_addr_t)~0))
> +		size = ((phys_addr_t)~0);

A similar printk as arm_add_memory for this one too?

                printk(KERN_CRIT "Truncating memory at 0x%08llx to fit in "
                        "32-bit physical address space\n", (long long)start);

Regards,
Jason
