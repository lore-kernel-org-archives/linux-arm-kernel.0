From: jamie.iles@picochip.com (Jamie Iles)
Date: Tue, 15 Dec 2009 15:19:03 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <000201ca7d98$012826b0$03787410$@deacon@arm.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-3-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-4-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-5-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-6-git-send-email-jamie.iles@picochip.com>
	<20091215150205.GO4141@wear.picochip.com>
	<000201ca7d98$012826b0$03787410$@deacon@arm.com>
Message-ID: <20091215151903.GP4141@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Dec 15, 2009 at 03:05:13PM -0000, Will Deacon wrote:
> > Ok, is it a safe assumption that for ARMv6 if num_possible_cpus() returns >1
> > we are mpcore and need to use different ID's or is there a better way to test
> > for mpcore?
> 
> The bottom 16 bits of the cpuid field will read 0xB020 on an 11MPCore as it's a
> different chip to the other v6 cores.
> 
> You could cast the cpuid to a u16 and switch on that: 0xB360, 0xB560 and 0xB760
> are the single core ARM11s.
Ok, that sounds like a good idea. Another problem with mpcore support is that
with the v6 performance counters, you can't disable a single event counter.
If we receive lots of interrupts, the higher perf events layers will disable
the counter for a bit before reenabling/unthrottling it.

On the single core, I just disable the interrupt for the counter and tell it
to count the ETM cycle events with the event exporting disabled so that the
counter doesn't increment. mpcore doesn't have this event so the counter will
keep on incrementing. Is there an undocumented event number we can use to stop
the counter? If not we'll need to read the counter, disable it and stash the
value away for when we unthrottle it and write it back. I guess we'll lose
some accuracy so it would be nice not to do that.

Jamie
