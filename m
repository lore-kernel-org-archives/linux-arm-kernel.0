From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Aug 2010 09:54:40 +0100
Subject: [PATCH 3/3] x86: oprofile: fix oprofile_arch_init behaviour on
	failure
In-Reply-To: <20100830090929.GU22783@erda.amd.com>
References: <1283107921-21464-1-git-send-email-will.deacon@arm.com>
	<1283107921-21464-2-git-send-email-will.deacon@arm.com>
	<1283107921-21464-3-git-send-email-will.deacon@arm.com>
	<1283107921-21464-4-git-send-email-will.deacon@arm.com>
	<20100830090929.GU22783@erda.amd.com>
Message-ID: <1283244880.645.17.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert,

On Mon, 2010-08-30 at 10:09 +0100, Robert Richter wrote:
> On 29.08.10 14:52:01, Will Deacon wrote:
> > The OProfile driver no longer calls oprofile_arch_exit when
> > oprofile_arch_init return failure.
> >
> > This patch fixes the x86 implementation of oprofile_arch_init
> > to ensure that op_nmi_exit is called if necessary.
> >
> > Cc: Robert Richter <robert.richter@amd.com>
> > Cc: Matt Fleming <matt@console-pimps.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@elte.hu>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/x86/oprofile/init.c |   26 +++++++++++++++-----------
> >  1 files changed, 15 insertions(+), 11 deletions(-)
> >
> 
> >  int __init oprofile_arch_init(struct oprofile_operations *ops)
> >  {
> >       int ret;
> > 
> > -     ret = -ENODEV;
> > -
> > -#ifdef CONFIG_X86_LOCAL_APIC
> >       ret = op_nmi_init(ops);
> > -#endif
> > -#ifdef CONFIG_X86_IO_APIC
> >       if (ret < 0)
> > +#ifdef CONFIG_X86_IO_APIC
> >               ret = op_nmi_timer_init(ops);
> > +#else
> > +             return ret;
> >  #endif
> > +
> >       ops->backtrace = x86_backtrace;
> > 
> > +     if (ret < 0)
> > +             op_nmi_exit();
> > +
> 
> I don't see why we have to do this. All init functions above clean up
> properly on failure. If op_nmi_init() succeeds we don't call
> op_nmi_timer_init(), so we don't need to free it it either.
> 

The original code called op_nmi_exit() from oprofile_arch_exit()
regardless of whether or not op_nmi_init() had succeeded. Actually, it
turns out that this is ok because of this guy:

/* in order to get sysfs right */
static int using_nmi;

which is set by the nmi_init function and checked by nmi_exit.

Do you think it would be better to rework this patch so that the static
using_nmi variable is set explicitly by init.c, or shall I just drop
this patch altogether (and resubmit the first two)?

Thanks,

Will
