From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 21 Jul 2011 15:18:18 -0700
Subject: [PATCH] ARM: do not mark CPU 0 as hotpluggable
In-Reply-To: <20110721074511.GK26574@n2100.arm.linux.org.uk>
References: <1311204745-6276-1-git-send-email-mturquette@ti.com>
	<20110721074511.GK26574@n2100.arm.linux.org.uk>
Message-ID: <CAJOA=zN-PmFcdAwkoFsUv7t2_gBGtUiBipG7j=AbVH9K=smqwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 12:45 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 20, 2011 at 04:32:25PM -0700, Mike Turquette wrote:
>> A quick poll of the ARM platforms that implement CPU Hotplug support
>> shows that every platform treats CPU 0 as a special case that cannot be
>> hotplugged. ?In fact every platform has identical code for
>> platform_cpu_die which returns -EPERM in the case of CPU 0.
>
> Are you sure that's just not because everyone copied what Realview has
> been doing (highly likely)?

Copy/paste is always likely.  Would be nice for other platform folks
to weigh in on this.

> I suspect that there's no reason that CPU0 can't be taken down, especially
> on those platforms which don't take the CPU fully offline but just put it
> into a WFI loop.
>
> Those which restart the CPUs through the boot loader probably detect CPU0
> as the boot CPU, so they probably can't take CPU0 down.

OMAP does seem to have this limitation and Santosh/Richard can provide
much better details than me in the parallel thread.  Again, would be
nice to hear if other platforms have similar limitations from their
stakeholders.

The idea here is to not mark a CPU hotpluggable if it cannot be
hotplugged.  If the limitations turn out to be legitimate for some
platforms but not others, what's the best way to handle it?  Either
move the topology initialization to platform code or allow platforms
to set some config option.  Patches for the latter are below, but I
think the current discussion on whether or not other platforms can
actually hotplug CPU0 should run its course before considering below
patches too seriously.
