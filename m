From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 21 Apr 2010 16:47:13 -0700
Subject: udelay() broken for SMP cores?
In-Reply-To: <20100421193305.GB26616@n2100.arm.linux.org.uk>
References: <4BCE60C4.8020505@codeaurora.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C4FEED81@dbde02.ent.ti.com>
	<4BCE9E8B.2070103@codeaurora.org>
	<20100421072243.GA913@n2100.arm.linux.org.uk>
	<ea62885d30e4bbfb84db59758fa9e946.squirrel@www.codeaurora.org>
	<20100421095036.GA13971@n2100.arm.linux.org.uk>
	<d6e7a481ba26beb786f922f95a75875d.squirrel@www.codeaurora.org>
	<20100421193305.GB26616@n2100.arm.linux.org.uk>
Message-ID: <4BCF8E81.4080906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Apr 21, 2010 at 03:31:03AM -0700, skannan at codeaurora.org wrote:
>>> Well, the assumption is that the CPUs will be running at their fastest
>>> speed at boot time, and therefore loops_per_jiffy will be calibrated
>>> such that we guarantee _at least_ the asked-for delay - which is the
>>> only guarantee udelay has.
>> Even if the boot assumption is true, cpufreq actively changes the
>> loops_per_jiffy value when it changes freq. So, this could still mess up
>> the _at least_ guarantee.
> 
> Actually, it doesn't on SMP - if you build the kernel with SMP enabled,
> the code which fiddles with loops_per_jiffy is disabled.  See the
> #ifndef wrapping around adjust_jiffies() in drivers/cpufreq/cpufreq.c.

My comment above was for the non-SMP case (it was a reply to your 
comment about non-SMP case). In non-SMP case, cpufreq changes LPJ and 
the freq switch can happen while udelay is looping. That would mess up 
the minimum delay guarantee of udelay.

I was aware that cpufreq doesn't change LPJ for SMP. But I think they do 
that because they don't know where the arch specific per-CPU 
loops_per_jiffy is located. They expect the cpufreq driver to do the lpj 
scaling. So, per-CPU lpj is still going to change. At least, that's what 
I took out of the following comment:

/*
  * This function alters the system "loops_per_jiffy" for the clock
  * speed change.  Note that loops_per_jiffy cannot be updated on SMP
  * systems as each CPU might be scaled differently. So, use the arch
  * per-CPU loops_per_jiffy value wherever possible.
  */


> So, on SMP with cpufreq, the global loops_per_jiffy is a fixed value.
> Provided it was calibrated with the CPU running at max clock rate,
> the guarantee is satisfied for all CPUs in the system.

As mentioned earlier, I think the cpufreq driver for that specific arch 
is supposed to handle the LPJ changes. But let's assume that's not true. 
So, wouldn't this still be a problem? You could be doing udelay as if 
you are running at 1 GHz but you are actually running at 100 MHz. I 
would think that would be bad for performance and power (wasting cycles 
without going into WFI, etc).

Thanks,
Saravana
