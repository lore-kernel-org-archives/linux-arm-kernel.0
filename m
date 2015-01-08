From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Jan 2015 23:10:47 +0100
Subject: [RFC] ARM: Make CPU_DCACHE_DISABLE depend on !SMP
In-Reply-To: <CADtm3G5Ebf6WkHG3fyiY3pm7fEBBNoW3DDEEwpvBXGj0fVE6jQ@mail.gmail.com>
References: <1420683088-1856-1-git-send-email-f.fainelli@gmail.com>
 <54AEA7E0.5070101@gmail.com>
 <CADtm3G5Ebf6WkHG3fyiY3pm7fEBBNoW3DDEEwpvBXGj0fVE6jQ@mail.gmail.com>
Message-ID: <3495606.iOQOj3bxPc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 January 2015 13:54:29 Gregory Fong wrote:
> On Thu, Jan 8, 2015 at 7:53 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > Le 08/01/2015 03:52, Russell King - ARM Linux a ?crit :
> >> On Thu, Jan 08, 2015 at 09:33:05AM +0100, Arnd Bergmann wrote:
> >>>
> >>> We stumbled on this a while back when Kaixu was trying to fix allmodconfig
> >>> builds to run on real hardware, but never submitted it in the end when
> >>> Russell didn't like some of the other parts required for that to work.
> >>>
> >>> This one clearly makes sense independently.
> >>
> >> What about platforms where exclusives to strongly ordered memory do work?
> >
> > Do we have a comprehensive list of these platforms?
> 
> I haven't had a chance to go through all of the TRMs, but section
> A3.4.5 of the ARMv7-A ARM says:
> 
> "It is IMPLEMENTATION DEFINED whether LDREX and STREX operations can
> be performed to a memory region
> with the Device or Strongly-ordered memory attribute. Unless the
> implementation documentation explicitly
> states that LDREX and STREX operations to a memory region with the
> Device or Strongly-ordered attribute are
> permitted, the effect of such operations is UNPREDICTABLE ."
> 
> From 6.4.5 "Synchronization primitives" in the Cortex-A15 TRM:
> 
> "Use of synchronization primitives on addresses in regions marked as
> Strongly-ordered or
> Device is UNPREDICTABLE in the ARMv7-A Architecture. Code that makes
> such accesses
> is not portable."
> 
> It looks like this is not generally permissible for ARMv7, maybe
> someone else can check the other versions.  Perhaps it would make
> sense to disallow disabling the D-cache for !SMP in general and
> special-case those architectures which do support exclusives to
> strongly ordered memory.

Too many negations, I assume you meant on SMP rather than !SMP.

My guess is that any implementation that has working LDREX/STREX
on uncached memory does not support SMP, because these instructions
tend to be implemented through the cache coherency logic on SMP
systems but could be implemented more easily without a dcache
on uniprocessor cores.

	Arnd
