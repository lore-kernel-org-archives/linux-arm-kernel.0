From: sergey.senozhatsky@gmail.com (Sergey Senozhatsky)
Date: Fri, 5 May 2017 11:21:41 +0900
Subject: [PATCH v2] printk: Use the main logbuf in NMI when logbuf_lock
 is available
In-Reply-To: <1493912763-24873-1-git-send-email-pmladek@suse.com>
References: <1493912763-24873-1-git-send-email-pmladek@suse.com>
Message-ID: <20170505022141.GA418@tigerII.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (05/04/17 17:46), Petr Mladek wrote:
[..]
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

a small nitpick,

[..]
>  void printk_nmi_enter(void)
>  {
> -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> +	/*
> +	 * The size of the extra per-CPU buffer is limited. Use it only when
> +	 * the main one is locked. If this CPU is not in the safe context,
> +	 * the lock must be taken on another CPU and we could wait for it.
> +	 */
> +	if (raw_spin_is_locked(&logbuf_lock) &&
> +	    this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK) {
> +		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);

could we please check `printk_context' (local to a particular CPU)
first and, if positive, then access `logbuf_lock' (which is global)?

	-ss
