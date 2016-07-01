From: oss@buserror.net (Scott Wood)
Date: Fri, 01 Jul 2016 01:51:45 -0500
Subject: [PATCH v2 1/2] ARM64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <5771267D.7030102@arm.com>
References: <1463114260-8724-1-git-send-email-oss@buserror.net>
 <20160513112441.200f4349@arm.com> <1466559926.22191.203.camel@buserror.net>
 <5771267D.7030102@arm.com>
Message-ID: <1467355905.32358.31.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-06-27 at 14:13 +0100, Marc Zyngier wrote:
> On 22/06/16 02:45, Scott Wood wrote:
> > 
> > On Fri, 2016-05-13 at 11:24 +0100, Marc Zyngier wrote:
> > > 
> > > On Thu, 12 May 2016 23:37:39 -0500
> > > Scott Wood <oss@buserror.net> wrote:
> > > 
> > > > +#ifdef CONFIG_ARM64
> > > > +static __always_inline void rewrite_tval(const int access,
> > > > +		unsigned long evt, struct clock_event_device *clk)
> > > > +{
> > > > +	u64 cval_old, cval_new;
> > > > +	int timeout = 200;
> > > > +
> > > > +	do {
> > > > +		cval_old = __arch_counter_get_cntvct();
> > > > +		arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL,
> > > > evt,
> > > > clk);
> > > > +		cval_new = __arch_counter_get_cntvct();
> > > Don't you need to guarantee the order of accesses here?
> > I'm not 100% sure.??The erratum workaround sample code doesn't show any
> > barriers, and adding more barriers could make it harder for the loop to
> > successfully complete.??There's already a barrier after the write, so the
> > only
> > concern should be whether the timer read could be reordered after the
> > timer
> > write, which could cause the loop to exit even if the write was bad.??Do
> > you
> > know if A53 or A57 will reorder a counter read relative to a tval write?
> I can't see any absolute guarantee that they wouldn't be reordered (but
> I have no insight on the micro-architecture either). I'd rather err on
> the side of caution here.

Adding another isb() before arch_timer_reg_write() causes the loop to not
complete with any reasonable timeout. ?A testing loop (that repeatedly writes
to TVAL (using the workaround code), reads it back, and checks that the value
read back is not greater than the value that was written) shows that the
workaround without the extra isb() is effective -- lots of assertions without
the workaround, and none with it -- but I'll go with the cval workaround
instead.

-Scott
