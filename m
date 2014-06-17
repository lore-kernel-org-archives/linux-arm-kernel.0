From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jun 2014 17:03:28 +0200
Subject: [PATCH 01/14] ARM: mvebu: fix randconfig builds for pmsu driver
In-Reply-To: <20140617160011.03b1ea15@free-electrons.com>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
 <1402675276-538682-2-git-send-email-arnd@arndb.de>
 <20140617160011.03b1ea15@free-electrons.com>
Message-ID: <4575903.g78pJlsGh9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 June 2014 16:00:11 Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Fri, 13 Jun 2014 18:01:03 +0200, Arnd Bergmann wrote:
> 
> > @@ -200,7 +201,9 @@ static noinline int do_armada_370_xp_cpu_suspend(unsigned long deepidle)
> >       /* If we are here, wfi failed. As processors run out of
> >        * coherency for some time, tlbs might be stale, so flush them
> >        */
> > +#ifdef CONFIG_MMU
> >       local_flush_tlb_all();
> > +#endif
> 
> So noMMU builds are supported in a single image with MMU builds?

It's not supported yet, but I have a patch to do that, which I used for
testing this code. I try to have the platform code ready before submitting
the main patch.

> Instead of having to #ifdef all around the place, wouldn't it be better
> for the noMMU headers to provide an empty definition for this function?

Yes, good point, it should probably be part of the main patch then.

> >  static int armada_370_xp_cpu_suspend(unsigned long deepidle)
> >  {
> > +     if (!IS_ENABLED(CONFIG_CPU_IDLE))
> > +             return -ENODEV;
> > +
> >       return cpu_suspend(deepidle, do_armada_370_xp_cpu_suspend);
> >  }
> 
> This unfortunately isn't really correct, and the patch I sent in
> "[PATCH] ARM: mvebu: select ARM_CPU_SUSPEND for Marvell EBU v7
> platforms" on June, 11th already fixes the cpu_suspend()/cpu_resume()
> problem.

ok.

> The issue with your solution is that it assumes this function is only
> used for cpuidle. That is indeed the case in v3.16, but will be wrong
> as soon as we add CPU hotplug support, which I have posted on May, 30th
> in "[PATCH 0/5] CPU hotplug for Marvell Armada XP", and which I hope to
> see included in v3.17.

Right. I'll drop this patch from the submission then. You came just in
time, as I had originally planned to send it out this morning.

I'll also follow up with a separate patch to address the isb() issue.

	Arnd
