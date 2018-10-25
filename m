From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Oct 2018 22:20:06 +0100
Subject: [PATCH] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS
 disabled
In-Reply-To: <CAFqt6zYxY+ocQPwNnV3CE7pTrUFniQETcxsq4Dsof41E91L6BQ@mail.gmail.com>
References: <20181025180957.7900-1-f.fainelli@gmail.com>
 <CAFqt6zYxY+ocQPwNnV3CE7pTrUFniQETcxsq4Dsof41E91L6BQ@mail.gmail.com>
Message-ID: <20181025212006.GE30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 12:00:09AM +0530, Souptick Joarder wrote:
> On Thu, Oct 25, 2018 at 11:40 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > Some software such as perf makes unconditional use of the special
> > [vectors] page which is only provided when CONFIG_KUSER_HELPERS is
> > enabled in the kernel.
> >
> > Facilitate the debugging of such situations by printing a debug message
> > to the kernel log showing the task name and the faulting address.
> >
> > Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  arch/arm/mm/fault.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> > index f4ea4c62c613..f17471fbc1c4 100644
> > --- a/arch/arm/mm/fault.c
> > +++ b/arch/arm/mm/fault.c
> > @@ -173,6 +173,11 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
> >                 show_regs(regs);
> >         }
> >  #endif
> > +#ifndef CONFIG_KUSER_HELPERS
> 
> Just have one doubt, if the condition is "#ifdef CONFIG_KUSER_HELPER"
> as commit message suggests the scenario is valid when CONFIG_KUSER_HELPER
> is enabled ? No ?
> 
> > +       if ((sig == SIGSEGV) && ((addr & PAGE_MASK) == 0xffff0000))
> > +               printk(KERN_DEBUG "%s: CONFIG_KUSER_HELPERS disabled at 0x%08lx\n",
> > +                      tsk->comm, addr);
> > +#endif

The idea is to print a message when we get a SEGV _and_ the faulting
address is in the vectors page _and_ CONFIG_KUSER_HELPERS is _not_ set
(which makes the page inaccessible.)  The message points users to
enable it and/or why the application has failed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
