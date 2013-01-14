From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 14 Jan 2013 21:48:54 +0800
Subject: [PATCH] ARM: imx: disable cpu in .cpu_kill hook
In-Reply-To: <20130114133208.GC23505@n2100.arm.linux.org.uk>
References: <1358168977-9631-1-git-send-email-shawn.guo@linaro.org>
 <20130114133208.GC23505@n2100.arm.linux.org.uk>
Message-ID: <20130114134853.GD24575@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 01:32:08PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 14, 2013 at 09:09:37PM +0800, Shawn Guo wrote:
> >  void imx_cpu_die(unsigned int cpu)
> >  {
> > +	static int spurious;
> > +
> >  	cpu_enter_lowpower();
> > -	imx_enable_cpu(cpu, false);
> > +	cpu_do_idle();
> > +	cpu_leave_lowpower();
> >  
> > -	/* spin here until hardware takes it down */
> > -	while (1)
> > -		;
> > +	pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, ++spurious);
> 
> Returning from the platform cpu die implementation should only be done
> in extreme situations, particularly where there's no possibility for the
> CPU to actually be taken offline (in other words, the ARM development
> platforms where there is _no_ possibility of powering down or resetting
> the secondary CPUs individually.)
> 
Indeed.  I have to admit that I have copied the code from Vexpress but
never seen it actually runs on my platform.  Will remove the recovery
completely.

Shawn
