From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 Aug 2014 12:21:01 +0100
Subject: [PATCH] Arm64: convert part of soft_restart() to assembly
In-Reply-To: <CAFdej00kapRsQB+YSO4PPN5NODiKrxzYrczof34LUD3iqwXhbA@mail.gmail.com>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1407915801-8703-1-git-send-email-achandran@mvista.com>
 <20140813105829.GC32644@leverpostej>
 <CAFdej00kapRsQB+YSO4PPN5NODiKrxzYrczof34LUD3iqwXhbA@mail.gmail.com>
Message-ID: <20140813112101.GD32644@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 12:17:54PM +0100, Arun Chandran wrote:
> Hi Mark,
> 
> > On Wed, Aug 13, 2014 at 08:43:21AM +0100, Arun Chandran wrote:
> >> The current soft_restart() and setup_restart implementations incorrectly
> >> assume that compiler will not spill/fill values to/from stack. However
> >> this assumption seems to be wrong, revealed by the disassembly of the
> >> currently existing code.
> >>
> >> Pseudo code for disassembly looks like
> >>
> >> soft_restart(addr)
> >> {
> >>       __push_to_stack(addr)
> >>
> >>       branch to setup_mm_for_reboot()
> >>       branch to flush_cache_all() --> This is unnecessary
> >>       branch to cpu_cache_off()
> >>       branch to flush_cache_all() --> Not guaranteed of flushing to PoC
> >>
> >>       __pop_from_stack(addr) --> Fails here as addr is not at PoC
> >>
> >>       cpu_reset(addr) --> cpu_reset receives invalid reset address
> >> }
> >
> > As I mentioned before, I think having pseudocode here is confusing.
> > Either we should have a real disassembly or we should drop it. I get the
> > following when I build a v3.16 arm64 defconfig with Linaro GCC
> > 4.9-2014.05:
> >
> 
> Hmm. I think It is better to drop it as different compilers give different
> output. My compiler's output is according to the commit message, but
> your's is not. I will send another one soon.

Well, either output would be fine as an example. I'd just like to see
the real asm rather than pseudocode.

Cheers,
Mark.
