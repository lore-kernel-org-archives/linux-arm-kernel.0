From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 21 May 2010 15:01:48 -0700
Subject: [PATCH V2] [ARM] Add ARCH_PROVIDES_UDELAY config option
In-Reply-To: <20100501100148.GE12172@n2100.arm.linux.org.uk>
References: <1272654736-28837-1-git-send-email-ccross@android.com>
	<u2pd73d4eaf1004301237k3ceb859dobe74fe53abec774d@mail.gmail.com>
	<87d3xgd20n.fsf@deeprootsystems.com>
	<20100501100148.GE12172@n2100.arm.linux.org.uk>
Message-ID: <4BF702CC.5000401@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Fri, Apr 30, 2010 at 03:11:20PM -0700, Kevin Hilman wrote:
>> Colin Cross <ccross@android.com> writes:
>>
>>> An alternative to this patch would be to add a config option to use
>>> sched_clock() to provide the counter instead of the cycle loop.  The
>>> same loops_per_jiffy calibration could be done to  determine the
>>> sched_clock frequency.  Any machine with an available constant tick
>>> rate counter, which is likely to be used for sched_clock() already,
>>> can enable CONFIG_UDELAY_USES_SCHED_CLOCK.
>> Or even better, why not have an option to use the clocksource which is
>> most likely using the constant tick timer as well.
> 
> We may be running into the same problem which we did with the printk
> clock - that is using a machine provided sched_clock() or clocksource
> requires MMIO accesses, which can only be done after the IO mappings
> have been initialized.
> 
> Let's hope no one ever uses udelay() before the necessary IO mappings
> are present.

Is the patch that uses CONFIG_ARCH_PROVIDES_UDELAY acceptable? I don't 
care much for how each arch decides to implement it, but I think we 
should have this config to let each arch decide how they want to handle 
udelay.

I personally prefer not to use the sched clock source due to the 
unnecessary complexities. If you have a some kind of constant counter, 
it sounds much simpler to just use it instead of adding dependencies 
between udelay and sched clock.

-Saravana
