From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Feb 2015 11:30:47 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150205112805.GE11344@leverpostej>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205112805.GE11344@leverpostej>
Message-ID: <20150205113047.GN8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 11:28:05AM +0000, Mark Rutland wrote:
> Hi Russell,
> 
> On Thu, Feb 05, 2015 at 10:50:35AM +0000, Russell King - ARM Linux wrote:
> > On Thu, Feb 05, 2015 at 11:14:30AM +0100, Krzysztof Kozlowski wrote:
> > > The complete() should not be used on offlined CPU. Rewrite the
> > > wait-complete mechanism with wait_on_bit_timeout().
> > 
> > Yuck.
> > 
> > I think that the IPI idea would be far better, and a much smaller patch.
> > We can continue using the completions, but instead of running the
> > completion on the dying CPU, the dying CPU triggers an IPI which does
> > the completion on the requesting CPU.
> 
> This does look _much_ nicer than the bitmask approach.
> 
> [...]
> 
> > diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > index 194df2f1aa87..c623e27a9c85 100644
> > --- a/arch/arm/kernel/smp.c
> > +++ b/arch/arm/kernel/smp.c
> > @@ -73,6 +73,9 @@ enum ipi_msg_type {
> >  	IPI_IRQ_WORK,
> >  	IPI_COMPLETION,
> >  	IPI_CPU_BACKTRACE,
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +	IPI_CPU_DEAD,
> > +#endif
> >  };
> 
> [...]
> 
> >  static const char *ipi_types[NR_IPI] __tracepoint_string = {
> >  #define S(x,s)	[x] = s
> >  	S(IPI_WAKEUP, "CPU wakeup interrupts"),
> 
> We'll probably want to add an entry here ("CPU teardown interrupts"?),
> and bump NR_IPI in asm/hardirq.h.

I'd need to move IPI_CPU_BACKTRACE out of the way then - that'll mostly
always be zero (even if the NMI IPI happens.)  I'll sort that when I
backport the patch to mainline kernels. :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
