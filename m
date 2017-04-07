From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 7 Apr 2017 11:37:08 +0200
Subject: [RFC v2][PATCH 04/11] x86: Implement
 __arch_rare_write_begin/unmap()
In-Reply-To: <1490811363-93944-5-git-send-email-keescook@chromium.org>
References: <1490811363-93944-1-git-send-email-keescook@chromium.org>
 <1490811363-93944-5-git-send-email-keescook@chromium.org>
Message-ID: <20170407093708.4ozbt3azbhqur4d4@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 11:15:56AM -0700, Kees Cook wrote:
> +static __always_inline unsigned long __arch_rare_write_end(void)
> +{
> +	unsigned long cr0;
> +
> +	barrier();
> +	cr0 = read_cr0() ^ X86_CR0_WP;
> +	BUG_ON(!(cr0 & X86_CR0_WP));
> +	write_cr0(cr0);
> +	barrier();
> +	preempt_enable_no_resched();

NAK

> +	return cr0 ^ X86_CR0_WP;
> +}
