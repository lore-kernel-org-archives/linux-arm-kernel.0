From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Nov 2015 09:36:01 +0000
Subject: armv7 + lpae broken in 4.1.12+ ?
In-Reply-To: <5657952E.906@heeltoe.com>
References: <5657952E.906@heeltoe.com>
Message-ID: <20151127093601.GA25781@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 06:26:38PM -0500, Brad Parker wrote:
> I was recently building a 4.1.12 kernel for a generic V7 platform with LPAE.
> I could not get it to boot and then discovered two things:
> 
> - the early printk code in tty/serial call ioremap very early and it fails
> because there's no heap
> - the code in proc-v7-3level.S/cpu_v7_set_pte_ext doesn't work
> 
> The printk issue is no big deal.  The pte issue is more important.
> 
> I found that the pte entries were garbage, which really confused me.  I
> finally discovered that the code in proc-v7-3level.S expects data in r0, r2
> & r3, but in fact it comes in on r0, r1 & r2.
> 
> My guess is that this is some vestige of the change made to
> cpu_v7_switch_mm() some time ago to make the PA a 64 bit value (hence using
> r0,r1).  But this change was not made to cpu_v7_set_pte_ext, so it writes
> garbage.
> 
> lol.  I guess I'm the only one who turns on LPAE for v7 cpu's...

FWIW, anybody using virtualisation with a v7 CPU has LPAE enabled. Whilst
that's admittedly not the majority of users, you're certainly not alone.

You are, however, the only person who seems to be hitting this problem.

As Russell says, AEABI requires the 64-bit pte value to be passed in r2
and r3 for cpu_v7_set_pte_ext:

  C.3 If the argument requires double-word alignment (8-byte), the NCRN
      is rounded up to the next even register number.

> The simple fix is to add "mov r3, r2; mov r2,r1" at the begining of
> cpu_v7_set_pte_ext(), but that's a hack (but it does solve the problem and
> the kernel boots).

... so this would actually cause breakage for other people.

Which toolchain are you using?

Will
