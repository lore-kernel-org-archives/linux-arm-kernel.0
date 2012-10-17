From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 17 Oct 2012 19:54:24 +0200
Subject: [PATCH 9/9] ARM: add uprobes support
In-Reply-To: <1350242593-17761-9-git-send-email-rabin@rab.in>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-9-git-send-email-rabin@rab.in>
Message-ID: <20121017175424.GA12553@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14, Rabin Vincent wrote:
>
> @@ -655,6 +656,9 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
>  					return restart;
>  				}
>  				syscall = 0;
> +			} else if (thread_flags & _TIF_UPROBE) {
> +				clear_thread_flag(TIF_UPROBE);
> +				uprobe_notify_resume(regs);
>  			} else {
>  				clear_thread_flag(TIF_NOTIFY_RESUME);
>  				tracehook_notify_resume(regs);

This doesn't look right. do_signal() can modify instruction pointer
after we hit the breakpoint. IOW, uprobe_notify_resume() should be
called before do_signal().

Oleg.
