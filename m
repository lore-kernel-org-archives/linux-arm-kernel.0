From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Jul 2014 13:18:56 -0700
Subject: [PATCH v5 1/7] kernel: Add support for kernel restart handler
 call chain
In-Reply-To: <1405668856-13738-2-git-send-email-linux@roeck-us.net>
References: <1405668856-13738-1-git-send-email-linux@roeck-us.net>
 <1405668856-13738-2-git-send-email-linux@roeck-us.net>
Message-ID: <53D95330.1050904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/14 00:34, Guenter Roeck wrote:
> +/**
> + *	do_kernel_restart - Execute kernel restart handler call chain
> + *
> + *	Calls functions registered with register_restart_handler.
> + *
> + *	Expected to be called from machine_restart as last step of the restart
> + *	sequence.
> + *
> + *	Restarts the system immediately if a restart handler function has been
> + *	registered. Otherwise does nothing.
> + */
> +void do_kernel_restart(char *cmd)
> +{
> +	blocking_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
> +}

Has this been tested with scheduling while atomic checking
(CONFIG_DEBUG_ATOMIC_SLEEP) or lockdep (CONFIG_PROVE_LOCKING)? ARM would
call this with irqs disabled and blocking_notifier_call_chain() would
spit out a warning when it tries to down_read() on it's semaphore. This
should probably be an atomic notifier chain instead.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
