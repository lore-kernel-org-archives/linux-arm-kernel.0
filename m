From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 25 Jun 2014 16:03:12 +0200
Subject: [PATCH v8 3/9] seccomp: introduce writer locking
In-Reply-To: <1403642893-23107-4-git-send-email-keescook@chromium.org>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <1403642893-23107-4-git-send-email-keescook@chromium.org>
Message-ID: <20140625140312.GC7892@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24, Kees Cook wrote:
>
> @@ -524,6 +529,8 @@ static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
>  	}
>  #endif
>
> +	spin_lock_irqsave(&current->sighand->siglock, irqflags);
> +

Well, I won't argue if you prefer to use _irqsave "just in case".

But irqs must be enabled in syscall paths, you could use spin_lock_irq().
The same for seccomp_set_mode_filter() added later.

Oleg.
