From: johan@kernel.org (Johan Hovold)
Date: Wed, 26 Nov 2014 16:13:16 +0100
Subject: [PATCH] ARM: remove redundant irq disable at halt and restart
In-Reply-To: <1414177592-14547-1-git-send-email-johan@kernel.org>
References: <1414177592-14547-1-git-send-email-johan@kernel.org>
Message-ID: <20141126151316.GE24767@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 09:06:32PM +0200, Johan Hovold wrote:
> Remove redundant local_irq_disable() at machine halt and restart.
> 
> Since commit 44424c34049f ("ARM: 7803/1: Fix deadlock scenario with
> smp_send_stop()") interrupts are disabled before stopping secondary
> CPUs.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Russell, have you had a chance to look at this clean up?

Thanks,
Johan

> ---
>  arch/arm/kernel/process.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index a35f6ebbd2c2..5663ab57cf07 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -195,7 +195,6 @@ void machine_halt(void)
>  	local_irq_disable();
>  	smp_send_stop();
>  
> -	local_irq_disable();
>  	while (1);
>  }
>  
> @@ -237,7 +236,6 @@ void machine_restart(char *cmd)
>  
>  	/* Whoops - the platform was unable to reboot. Tell the user! */
>  	printk("Reboot failed -- System halted\n");
> -	local_irq_disable();
>  	while (1);
>  }
