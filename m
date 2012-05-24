From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 May 2012 18:15:24 +0100
Subject: [PATCH] [ARM] Unconditional call to smp_cross_call on UP crashes
In-Reply-To: <F138E222-D587-4264-8B80-E041D44BF770@antoniou-consulting.com>
References: <1337889024-10416-1-git-send-email-panto@antoniou-consulting.com>
 <20120524161733.GF6908@n2100.arm.linux.org.uk>
 <F138E222-D587-4264-8B80-E041D44BF770@antoniou-consulting.com>
Message-ID: <20120524171524.GG6908@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 07:55:56PM +0300, Pantelis Antoniou wrote:
> Hi Russell,
> 
> On May 24, 2012, at 7:17 PM, Russell King - ARM Linux wrote:
> 
> > On Thu, May 24, 2012 at 07:50:24PM +0000, Pantelis Antoniou wrote:
> >> omap2plus_defconfig builds with SMP & SMP_ON_UP set.
> >> On beagle (which is UP) is_smp() returns false and we don't call
> >> smp_init_cpus which in turn does not initialize smp_cross_call which
> >> remains NULL.
> >> 
> >> When issuing a reboot we OOPS with a NULL dereference on stop smp_call.
> > 
> > I've been wondering whether we should make smp_cross_call() a no-op instead
> > by default, rather than a NULL pointer.
> > 
> > Alternatively, if may be well worth changing this to do:
> > 
> > 	if (!cpumask_empty(&mask))
> > 		smp_cross_call(&mask, IPI_CPU_STOP);
> > 
> > instead, so we avoid calling smp_cross_call() when we're on a SMP system
> > with only one CPU online.  I like this approach better because it removes
> > a potential call into platform code which is inappropriate.
> 
> Both of these can work, and in fact have been tried.
> 
> I am partial on both to be honest. Have a default no-op function for smp_cross_call()
> and guard with cpumask_empty().
> 
> Which do you want me to make a patch for?

I think the cpumask_empty() is the best approach, thanks.
