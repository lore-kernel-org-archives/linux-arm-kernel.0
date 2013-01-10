From: dzickus@redhat.com (Don Zickus)
Date: Thu, 10 Jan 2013 13:17:51 -0500
Subject: [PATCH] hardlockup: detect hard lockups without NMIs using
 secondary cpus
In-Reply-To: <CAMbhsRT7q+DSKOdPMtUqtPZJrB_z-ixmv09TkT2ZweUJGXjkYg@mail.gmail.com>
References: <1357783059-13923-1-git-send-email-ccross@android.com>
 <20130110140215.GP88797@redhat.com>
 <CAMbhsRT7q+DSKOdPMtUqtPZJrB_z-ixmv09TkT2ZweUJGXjkYg@mail.gmail.com>
Message-ID: <20130110181751.GR88797@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 09:27:28AM -0800, Colin Cross wrote:
> On Thu, Jan 10, 2013 at 6:02 AM, Don Zickus <dzickus@redhat.com> wrote:
> > On Wed, Jan 09, 2013 at 05:57:39PM -0800, Colin Cross wrote:
> >> Emulate NMIs on systems where they are not available by using timer
> >> interrupts on other cpus.  Each cpu will use its softlockup hrtimer
> >> to check that the next cpu is processing hrtimer interrupts by
> >> verifying that a counter is increasing.
> >>
> >> This patch is useful on systems where the hardlockup detector is not
> >> available due to a lack of NMIs, for example most ARM SoCs.
> >
> > I have seen other cpus, like Sparc I think, create a 'virtual NMI' by
> > reserving an IRQ line as 'special' (can not be masked).  Not sure if that
> > is something worth looking at here (or even possible).
> >
> >> Without this patch any cpu stuck with interrupts disabled can
> >> cause a hardware watchdog reset with no debugging information,
> >> but with this patch the kernel can detect the lockup and panic,
> >> which can result in useful debugging info.
> >
> > <SNIP>
> >> +#ifdef CONFIG_HARDLOCKUP_DETECTOR_OTHER_CPU
> >> +static int is_hardlockup_other_cpu(int cpu)
> >> +{
> >> +     unsigned long hrint = per_cpu(hrtimer_interrupts, cpu);
> >> +
> >> +     if (per_cpu(hrtimer_interrupts_saved, cpu) == hrint)
> >> +             return 1;
> >> +
> >> +     per_cpu(hrtimer_interrupts_saved, cpu) = hrint;
> >> +     return 0;
> >
> > Will this race with the other cpu you are checking?  For example if cpuA
> > just updated its hrtimer_interrupts_saved and cpuB goes to check cpuA's
> > hrtimer_interrupts_saved, it seems possible that cpuB could falsely assume
> > cpuA is stuck?
> 
> cpuA doesn't update its own hrtimer_interrupts_saved, cpuB does.
> However, there may be a similar race condition during hotplug if cpuB
> updates hrtimer_interrupts_saved for cpuA, then goes offline, then
> cpuC may try to check cpuA and see that hrtimer_interrupts_saved ==
> hrtimer_interrupts.  I think this can be solved by setting
> watchdog_nmi_touch for the next cpu when a cpu goes online or offline.

Ah, that is where my misunderstanding was.  I overlooked the fact that it
was only updated by the other cpu.  Sorry about that.

I'll re-review it again with that in mind.

Cheers,
Don
