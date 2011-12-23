From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 23 Dec 2011 11:54:09 +0000
Subject: init_kprobes() takes too much time during boot up
In-Reply-To: <alpine.LFD.2.02.1112222212140.2907@xanadu.home>
References: <CAMPhdO8T5wwPBYp_n15A88o8YxkXv2t8WOumRyni6WDhJinS3A@mail.gmail.com>
 <alpine.LFD.2.02.1112222212140.2907@xanadu.home>
Message-ID: <1324641249.2215.25.camel@linaro1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-12-22 at 22:20 -0500, Nicolas Pitre wrote:
> On Fri, 23 Dec 2011, Eric Miao wrote:
> 
> > I was trying to improve the kernel boot performance of the boards at
> > my hands, while simply turning on initcall_debug, and found that
> > init_kprobes() won the crown of being the most hungry time gobbler.
> > 
> > Before I take my time to look into why it's taking so much time, I'd
> > post the question to the list to seek help first.
> 
> From a quick glance, the "Lookup and populate the kprobe_blacklist" 
> loops certainly have the potential to be costly.
> 
> There is nothing with notable complexity in the ARM specific part.

Linaro's kernels have CONFIG_KPROBES_SANITY_TEST enabled and I suspect
the slowness is due to these sanity tests.  The reason I think this is
that I recently noticed that my kprobes test code is 1000 times slower
on a Versatile Express than on a BeagleBoard. I suspect (without much
evidence) that on SMP systems, the use of stop_machine() to set and
clear breakpoints is causing this massive delay.

I was speculating that the slowness could be due to process scheduling
not happening until the next 'tick', or buggy code waking other CPUs
from sleep.

Does Linux have some general IPI interface we could use to synchronize
CPU rather than stop_machine? All we need to do is interrupt other cores
and make them wait until we write a new instruction to memory and do a
cache flush and relevant barrier instructions. That would propagate the
work case interrupt latency across all cores and add a little to that
value to boot though.

-- 
Tixy
