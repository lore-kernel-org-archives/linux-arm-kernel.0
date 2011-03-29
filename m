From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 29 Mar 2011 15:24:24 -0700
Subject: [PATCH] ARM: Use generic BUG() handler
In-Reply-To: <1300307259-834-1-git-send-email-sjg@chromium.org>
References: <1300307259-834-1-git-send-email-sjg@chromium.org>
Message-ID: <4D925C18.7040202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/16/2011 1:27 PM, Simon Glass wrote:
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 6146279..4f22346 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -80,6 +80,18 @@ SECTIONS
>  
>  	PERCPU(PAGE_SIZE)
>  
> +	/*
> +	* .exit.text is discarded at runtime, not link time, to deal with
> +	*  references from bug_table
> +	*/
> +	.exit.text : AT(ADDR(.exit.text)) {
> +		EXIT_TEXT
> +	}
> +
> +	.exit.data : AT(ADDR(.exit.data)) {
> +		EXIT_DATA
> +	}
> +
>  #ifndef CONFIG_XIP_KERNEL
>  	. = ALIGN(PAGE_SIZE);
>  	__init_end = .;

Should this be using the ARM_EXIT_KEEP macro instead? It seems like you
could add another condition to that macro like:

#if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || defined(CONFIG_GENERIC_BUG)
#define ARM_EXIT_KEEP(x)        x
#else
#define ARM_EXIT_KEEP(x)
#endif


and then drop this hunk here. Plus, this might be better because if you
have BUG=n and SMP_ON_UP=n you can drop the exit sections at link time
still, but with your patch they get dropped at runtime, right?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
