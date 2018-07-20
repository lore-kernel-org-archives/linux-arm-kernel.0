From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Jul 2018 10:44:53 +0100
Subject: [PATCH] arm64: fix for restoring console loglevel after handling
 traps
In-Reply-To: <CAM5rFu8rQaVne22cYxx3YZTaxh9Dnq2wJWNu1uierBxZfogPeA@mail.gmail.com>
References: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
 <1531993734-1463-2-git-send-email-hari.vyas@broadcom.com>
 <20180719100140.GA424@jagdpanzerIV>
 <CAM5rFu_N-=26LddRy1mO010h9yLcGuKqK6=y+h=h3-HbfEP+FQ@mail.gmail.com>
 <20180719103916.g763zmsm7wnngwop@lakrids.cambridge.arm.com>
 <CAM5rFu-MFbH_2Pohmjydy232Rpt7_E84-K=e67wAu3iQzvTLiA@mail.gmail.com>
 <20180720062609.2haxhf23zyouoxmh@salmiak>
 <20180720064027.GA3901@jagdpanzerIV>
 <CAM5rFu8rQaVne22cYxx3YZTaxh9Dnq2wJWNu1uierBxZfogPeA@mail.gmail.com>
Message-ID: <20180720094453.a64hnqoveojrozha@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 01:01:39PM +0530, Hari Vyas wrote:
> On Fri, Jul 20, 2018 at 12:10 PM, Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> > On (07/20/18 07:26), Mark Rutland wrote:
> >> > >
> >> > This die() is called from so many places i.e. entry.S shows so many ways i.e
> >> > el1_sync_invalid,irq,fiq_invalid,error_invalid.
> >
> > [..]
> >
> >> Indeed, but *none* of these should fire unless something has gone wrong already.
> >
> > [..]
> >
> > Agreed.
> >
> > I see that all those arm64/kernel/entry.S el0_sync_invalid,
> > el0_irq_invalid, el0_fiq_invalid, and so on, invoke inv_entry macro
> > which calls into bad_mode, which ends up in panic() anyway:
> >
> > asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
> > {
> >         console_verbose();
> >
> >         pr_crit("Bad mode in %s handler detected on CPU%d, code 0x%08x -- %s\n",
> >                 handler[reason], smp_processor_id(), esr,
> >                 esr_get_class_string(esr));
> >
> >         die("Oops - bad mode", regs, 0);
> >         local_daif_mask();
> >         panic("bad mode");
> > }
> >
> > bad_mode is always fatal.
> >
> > When the kernel becomes suicidal and wants to die() we better have
> > verbose consoles. So, no, I don't think I'm buying the patch.
> >
> >         -ss
> This was the behavior observed with 4.14 kernel version and proposed
> patch. I understand, giving access to system memory access to user is
> bad and should be avoided so one may argue
> simplest but bad example and unpredictable results may be observed.
> For other examples, I may need to work and find out. Please decide.
> 
> root at bcm958802a8021:~# uname -a
> 
> Linux bcm958802a8021 4.14.49+g8f1356a #1 SMP Mon Jul 9 22:37:03 UTC
> 2018 aarch64 aarch64 aarch64 GNU/Linux
> 
> root at bcm958802a8021:~# cat /proc/sys/kernel/printk
> 
> 7       4       1       7 <==CONSOLE LOGLEVEL IS SET TO 7
> 
> root at bcm958802a8021:~# echo 1 > /sys/bus/pci/rescan  <=== NO PRINT
> 
> root at bcm958802a8021:~# devmem 0x0
> 
> [   46.166083] Bad mode in Error handler detected on CPU1, code 0xbf000000 -- SError
> [   46.173805] Internal error: Oops - bad mode: 0 [#1] SMP

As previously discussed, this case *is not* recoverable, and *must* be
handled fatally. The fact that old kernels did not handle this fatally
is a *bug*.

If you are seeing SError under normal conditions, something is *very*
wrong with your system. If you are *deliberately* provoking SError, this
is your own fault.

Thanks,
Mark.
