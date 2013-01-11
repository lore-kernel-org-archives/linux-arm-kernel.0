From: chuansheng.liu@intel.com (Liu, Chuansheng)
Date: Fri, 11 Jan 2013 05:57:27 +0000
Subject: [PATCH] hardlockup: detect hard lockups without NMIs using
 secondary cpus
In-Reply-To: <CAMbhsRS5S=bRWOAA_ft3josCX9kvarrqPX-sLnO02vB0NfZJ+w@mail.gmail.com>
References: <1357783059-13923-1-git-send-email-ccross@android.com>
 <27240C0AC20F114CBF8149A2696CBE4A200DD9@SHSMSX101.ccr.corp.intel.com>
 <CAMbhsRS5S=bRWOAA_ft3josCX9kvarrqPX-sLnO02vB0NfZJ+w@mail.gmail.com>
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A2010CB@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: ccross at google.com [mailto:ccross at google.com] On Behalf Of Colin
> Cross
> Sent: Friday, January 11, 2013 1:34 PM
> To: Liu, Chuansheng
> Cc: linux-kernel at vger.kernel.org; Andrew Morton; Don Zickus; Ingo Molnar;
> Thomas Gleixner; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] hardlockup: detect hard lockups without NMIs using
> secondary cpus
> 
> On Thu, Jan 10, 2013 at 5:39 PM, Liu, Chuansheng
> <chuansheng.liu@intel.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Colin Cross [mailto:ccross at android.com]
> >> Sent: Thursday, January 10, 2013 9:58 AM
> >> To: linux-kernel at vger.kernel.org
> >> Cc: Andrew Morton; Don Zickus; Ingo Molnar; Thomas Gleixner; Liu,
> >> Chuansheng; linux-arm-kernel at lists.infradead.org; Colin Cross
> >> Subject: [PATCH] hardlockup: detect hard lockups without NMIs using
> >> secondary cpus
> >>
> >> Emulate NMIs on systems where they are not available by using timer
> >> interrupts on other cpus.  Each cpu will use its softlockup hrtimer
> >> to check that the next cpu is processing hrtimer interrupts by
> >> verifying that a counter is increasing.
> >>
> >> This patch is useful on systems where the hardlockup detector is not
> >> available due to a lack of NMIs, for example most ARM SoCs.
> >> Without this patch any cpu stuck with interrupts disabled can
> >> cause a hardware watchdog reset with no debugging information,
> >> but with this patch the kernel can detect the lockup and panic,
> >> which can result in useful debugging info.
> >>
> >> Signed-off-by: Colin Cross <ccross@android.com>
> >> +static void watchdog_check_hardlockup_other_cpu(void)
> >> +{
> >> +     int cpu;
> >> +     cpumask_t cpus = watchdog_cpus;
> >> +
> >> +     /*
> >> +      * Test for hardlockups every 3 samples.  The sample period is
> >> +      *  watchdog_thresh * 2 / 5, so 3 samples gets us back to slightly
> over
> >> +      *  watchdog_thresh (over by 20%).
> >> +      */
> >> +     if (__this_cpu_read(hrtimer_interrupts) % 3 != 0)
> >> +             return;
> >> +
Another feeling is about __this_cpu_read(hrtimer_interrupts) % 3 != 0,
It will cause the actual timeout value for hard lockup detection is not very fix, or even
very short.
Sometimes using 3 samples can detect the lockup case, but sometimes 1 sample.
Is it the case?

And in NMI case, the NMI interrupt is coming at least every watchdog_thresh.
