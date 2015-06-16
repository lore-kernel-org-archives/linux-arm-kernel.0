From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Jun 2015 16:10:51 +0200
Subject: [PATCH] ARM: mm: enable L1 prefetch on Cortex-A9
In-Reply-To: <CAL_JsqKTC+BO6bin3Qekjn37Np6F86Uvv1-194VGTyYxcNfjHw@mail.gmail.com>
References: <1434023550-20147-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_JsqKTC+BO6bin3Qekjn37Np6F86Uvv1-194VGTyYxcNfjHw@mail.gmail.com>
Message-ID: <20150616161051.1f46464f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob Herring,

On Tue, 16 Jun 2015 08:47:33 -0500, Rob Herring wrote:

> > This commit enables this L1 prefetch feature unconditionally on all
> > Cortex-A9 by setting bit 2 in the Auxiliary Control CP15
> > register. Note that since this bit only exists on Cortex-A9 but not on
> > Cortex-A5 or Cortex-R7, we separate the handling of Cortex-A9 from the
> > one of those two other cores.
> 
> Does this work in non-secure mode? Perhaps it is just ignored. If so,
> it deserves a comment along the lines of "This bit should be set by
> the bootloader and setting it has no effect in non-secure mode."

According to
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388i/CIHCHFCG.html,
bit 0 (which was already set by the code before my patch) and bit 2
don't have any difference in terms of secure/non-secure access.

The CP15 register as a whole is RO in non-secure if NSACR.NS_SMP = 0.
If NSACR.NS_SMP = 1, all bits are write-ignored in non-secure, except
the SMP bit (bit 6).

So I assume that if this piece of code is currently setting bit 0,
we can assume that setting bit 2 in the same place is also OK. However,
setting bit 0 or 2 is probably going to raise an undefined instruction
exception in non-secure when NSACR.NS_SMP = 0, but that is not a
behavior introduced by my patch.

Thanks for the review!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
