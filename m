From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 5 Jan 2015 10:19:25 -0500
Subject: [PATCH 3.19-rc2 v13 4/5] ARM: Add support for on-demand
 backtrace of other CPUs
In-Reply-To: <1420469699-25350-5-git-send-email-daniel.thompson@linaro.org>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1420469699-25350-1-git-send-email-daniel.thompson@linaro.org>
 <1420469699-25350-5-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150105101925.64e8ecec@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  5 Jan 2015 14:54:58 +0000
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> +
> +/* For reliability, we're prepared to waste bits here. */
> +static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
> +static  cpumask_t printtrace_mask;
> +
> +#define NMI_BUF_SIZE		4096
> +
> +struct nmi_seq_buf {
> +	unsigned char		buffer[NMI_BUF_SIZE];
> +	struct seq_buf		seq;
> +};
> +
> +/* Safe printing in NMI context */
> +static DEFINE_PER_CPU(struct nmi_seq_buf, nmi_print_seq);
> +
> +/* "in progress" flag of arch_trigger_all_cpu_backtrace */
> +static unsigned long backtrace_flag;
> +
> +/*
> + * It is not safe to call printk() directly from NMI handlers.
> + * It may be fine if the NMI detected a lock up and we have no choice
> + * but to do so, but doing a NMI on all other CPUs to get a back trace
> + * can be done with a sysrq-l. We don't want that to lock up, which
> + * can happen if the NMI interrupts a printk in progress.
> + *
> + * Instead, we redirect the vprintk() to this nmi_vprintk() that writes
> + * the content into a per cpu seq_buf buffer. Then when the NMIs are
> + * all done, we can safely dump the contents of the seq_buf to a printk()
> + * from a non NMI context.
> + */
> +static int nmi_vprintk(const char *fmt, va_list args)
> +{
> +	struct nmi_seq_buf *s = this_cpu_ptr(&nmi_print_seq);
> +	unsigned int len = seq_buf_used(&s->seq);
> +
> +	seq_buf_vprintf(&s->seq, fmt, args);
> +	return seq_buf_used(&s->seq) - len;
> +}
> +

This is the same code as in x86. I wonder if we should move the
duplicate code into kernel/printk/ and have it compiled if the arch
requests it (CONFIG_ARCH_WANT_NMI_PRINTK or something). That way we
don't have 20 copies of the same nmi_vprintk() and later find that we
need to change it, and have to change it in 20 different archs.

-- Steve
