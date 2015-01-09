From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jan 2015 16:48:01 +0000
Subject: [PATCH 3.19-rc2 v13 4/5] ARM: Add support for on-demand
 backtrace of other CPUs
In-Reply-To: <20150105101925.64e8ecec@gandalf.local.home>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1420469699-25350-1-git-send-email-daniel.thompson@linaro.org>
 <1420469699-25350-5-git-send-email-daniel.thompson@linaro.org>
 <20150105101925.64e8ecec@gandalf.local.home>
Message-ID: <20150109164801.GW12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 10:19:25AM -0500, Steven Rostedt wrote:
> On Mon,  5 Jan 2015 14:54:58 +0000
> Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > +/* For reliability, we're prepared to waste bits here. */
> > +static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
> > +static  cpumask_t printtrace_mask;
> > +
> > +#define NMI_BUF_SIZE		4096
> > +
> > +struct nmi_seq_buf {
> > +	unsigned char		buffer[NMI_BUF_SIZE];
> > +	struct seq_buf		seq;
> > +};

Am I missing something or does this limit us to 4096 characters of
backtrace output per CPU?

> This is the same code as in x86. I wonder if we should move the
> duplicate code into kernel/printk/ and have it compiled if the arch
> requests it (CONFIG_ARCH_WANT_NMI_PRINTK or something). That way we
> don't have 20 copies of the same nmi_vprintk() and later find that we
> need to change it, and have to change it in 20 different archs.

Agreed, though I wonder about the buffer size.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
