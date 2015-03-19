From: joshc@ni.com (Josh Cartwright)
Date: Thu, 19 Mar 2015 09:22:26 -0500
Subject: [PATCH v3 1/2] ARM: zynq: use restart_handler mechanism for slcr
 reset
In-Reply-To: <BN1BFFO11FD028DBA8016227BB3B18A2B8E2010@BN1BFFO11FD028.protection.gbl>
References: <BN1BFFO11FD008F29B247339CE49EAEA6AE2010@BN1BFFO11FD008.protection.gbl>
 <1426772033-29277-1-git-send-email-joshc@ni.com>
 <BN1BFFO11FD028DBA8016227BB3B18A2B8E2010@BN1BFFO11FD028.protection.gbl>
Message-ID: <20150319142226.GD23626@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 03:01:13PM +0100, Michal Simek wrote:
> On 03/19/2015 02:33 PM, Josh Cartwright wrote:
[..]
> >  /**
> > - * zynq_slcr_system_reset - Reset the entire system.
> > + * zynq_slcr_system_restart - Restart the entire system.
> >   */
> > -void zynq_slcr_system_reset(void)
> > +static
> > +int zynq_slcr_system_restart(struct notifier_block *nb,
> > +			     unsigned long action, void *data)
> 
> This doesn't look right to me.
> 
> [linux]$ ./scripts/kernel-doc -man -v arch/arm/mach-zynq/slcr.c >/dev/null
> Info(arch/arm/mach-zynq/slcr.c:42): Scanning doc for zynq_slcr_write
> Info(arch/arm/mach-zynq/slcr.c:55): Scanning doc for zynq_slcr_read
> Info(arch/arm/mach-zynq/slcr.c:68): Scanning doc for zynq_slcr_unlock
> Info(arch/arm/mach-zynq/slcr.c:80): Scanning doc for zynq_slcr_get_device_id
> Info(arch/arm/mach-zynq/slcr.c:96): Scanning doc for zynq_slcr_system_restart
> Warning(arch/arm/mach-zynq/slcr.c:101): No description found for parameter 'nb'
> Warning(arch/arm/mach-zynq/slcr.c:101): No description found for parameter 'action'
> Warning(arch/arm/mach-zynq/slcr.c:101): No description found for parameter 'data'
> Warning(arch/arm/mach-zynq/slcr.c:101): No description found for return value of 'zynq_slcr_system_restart'

*Sigh*.  I guess now is as good as ever to learn how to write kerneldoc.

I can't help but feel this effort really isn't worth it.  I'll do it,
obviously, because I want this patch to go in, but I really don't
understand at all what value is being provided here.

Are you advocating for _every_ function in the kernel to have an
associated kerneldoc annotation?  Even for small/self-evident/internal
functions?

In my opinion, kerneldoc annotations make sense for those functions
which:

  1.) Are widely used (think synchronization primitives, device core, etc.)
  2.) Have non-obvious semantics, or:
  3.) Have caller-mandated requirements that aren't clear otherwise
      (locks to be acquired, lifecycle management requirements, state to
       be maintained, etc.)

Beyond that, it's just review churn and fighting the inevitable
code-and-documentation-out-of-sync problem.

  Josh
