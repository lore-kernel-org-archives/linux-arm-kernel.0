From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Thu, 19 Jul 2018 19:01:40 +0900
Subject: [PATCH] arm64: fix for restoring console loglevel after handling
 traps
In-Reply-To: <1531993734-1463-2-git-send-email-hari.vyas@broadcom.com>
References: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
 <1531993734-1463-2-git-send-email-hari.vyas@broadcom.com>
Message-ID: <20180719100140.GA424@jagdpanzerIV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (07/19/18 15:18), Hari Vyas wrote:
[..]

Not so sure about the patch, sorry.

> @@ -211,6 +211,8 @@ void die(const char *str, struct pt_regs *regs, int err)
>  
>  	bust_spinlocks(0);
>  	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
> +
> +	restore_console_loglevel();
>  	oops_exit();

This is *probably* the only place where you can roll-back the
loglevel, but you restore console loglevel too early - a trap
can panic() the system, we need to preserve the console verbose
mode which we set at the start of the trap.

> @@ -624,6 +626,7 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
>  	die("Oops - bad mode", regs, 0);
>  	local_daif_mask();
>  	panic("bad mode");
> +	restore_console_loglevel();

panic()

> @@ -680,6 +683,7 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  	 * to get a better stack trace.
>  	 */
>  	nmi_panic(NULL, "kernel stack overflow");
> +	restore_console_loglevel();

panic()

> @@ -694,7 +698,7 @@ void __noreturn arm64_serror_panic(struct pt_regs *regs, u32 esr)
>  		__show_regs(regs);
>  
>  	nmi_panic(regs, "Asynchronous SError Interrupt");
> -
> +	restore_console_loglevel();

panic()

What's the point of restore_console_loglevel() after panic()?

	-ss
