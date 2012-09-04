From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 4 Sep 2012 15:36:24 -0700
Subject: [PATCH] kernel/sys.c: call disable_nonboot_cpus in kernel_restart
In-Reply-To: <1346682298-13958-1-git-send-email-shawn.guo@linaro.org>
References: <1346682298-13958-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120904153624.d4aaed4e.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  3 Sep 2012 22:24:58 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> Like kernel_power_off calls disable_nonboot_cpus, we may want to have
> kernel_restart call disable_nonboot_cpus as well.  Doing so can help
> the machines that require boot cpu be the last alive cpu during reboot
> to survive with kernel restart.

That does sound logical.  But the changelog is very vague and fluffy. 
Does this patch actually fix any known problem on any known machine?

> ...
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -368,6 +368,7 @@ EXPORT_SYMBOL(unregister_reboot_notifier);
>  void kernel_restart(char *cmd)
>  {
>  	kernel_restart_prepare(cmd);
> +	disable_nonboot_cpus();
>  	if (!cmd)
>  		printk(KERN_EMERG "Restarting system.\n");
>  	else
