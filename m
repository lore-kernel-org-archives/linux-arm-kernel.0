From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 23 Mar 2017 11:52:53 +0000
Subject: [RFC PATCH v2 23/41] arm64/sve: Move ZEN handling to the common
 task_fpsimd_load() path
In-Reply-To: <20170322165527.GD19950@leverpostej>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-24-git-send-email-Dave.Martin@arm.com>
 <20170322165527.GD19950@leverpostej>
Message-ID: <20170323115252.GD3750@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 04:55:27PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Wed, Mar 22, 2017 at 02:50:53PM +0000, Dave Martin wrote:
> >  void do_sve_acc(unsigned int esr, struct pt_regs *regs)
> >  {
> > -	unsigned long tmp;
> > +	if (test_and_set_thread_flag(TIF_SVE)) {
> > +		unsigned long tmp;
> >  
> > -	if (test_and_set_thread_flag(TIF_SVE))
> > +		asm ("mrs %0, cpacr_el1" : "=r" (tmp));
> 
> Please use read_sysreg().
> 
> > +
> > +		printk(KERN_INFO "%s: Strange, ZEN=%u\n",
> > +		       __func__, (unsigned int)((tmp >> 16) & 3));
> >  		BUG();
> 
> Given we're about to BUG(), I guess it would make more sense to use
> pr_err() here, and be a bit more informative. e.g.
> 
> 	pr_crit("SVE trap taken unexpectedly. CPACR_EL1.ZEN is %u\n",
> 		(unsigned int)((tmp >> 16) & 3));
> 	BUG();

This also goes away later -- it made sense for debugging, but since
do_sve_acc() is called on the back of a trap this BUG is really a check
for broken hardware.

Later, this is reduced to

	if (test_and_set_thread_flag(TIF_SVE))
		BUG();

with the CPACR manipulation moved to ret_to_user
(via task_fpsimd_load()).

> 
> ... my usual comments w.r.t. magic numbers apply.
> 
> [...]
> 
> > +		BUILD_BUG_ON(_TIF_SVE != CPACR_EL1_ZEN_EL0EN);
> 
> As previously, I do not think this is a good idea. Treating these as
> separate values is not difficult, and IMO far easier to reason about.

Agreed.

Cheers
---Dave
