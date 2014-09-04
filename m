From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 4 Sep 2014 18:48:40 +0100
Subject: [PATCH] clocksource: arch_timer: Fix code to use physical timers
 when requested
In-Reply-To: <CAPz6YkVv1nbEumt9Q8gHAWddmECOm7DL=WLWfZKxBmzTfLQ00A@mail.gmail.com>
References: <CAPz6YkWAPtuy4sAuAK9GtpDgfGsccxeS+pqqe_t_R818Jt01qA@mail.gmail.com>
 <53FE5B09.2020403@codeaurora.org>
 <CAOesGMhTivDzJFuxONggcJ6N5UvZopKa=+tv9PoPX593cpnm0A@mail.gmail.com>
 <53FE7E3B.1010500@codeaurora.org>
 <CAOesGMgXnsqttHwAxEW4a7-Rx-nmSwpJd_Dt1iCcFOvzDwbzdA@mail.gmail.com>
 <CAD=FV=VjN6Xam-nRRcxvOoN-gokU6DbGVjoPXN_fkTJssH1RWA@mail.gmail.com>
 <20140828093505.GC14650@leverpostej>
 <CAPz6YkUZkqgEBsPtX0uGpU+OzF5qdv1hGMXLo4iThUv-7B-Jbw@mail.gmail.com>
 <20140829100414.GA19424@leverpostej>
 <CAPz6YkVv1nbEumt9Q8gHAWddmECOm7DL=WLWfZKxBmzTfLQ00A@mail.gmail.com>
Message-ID: <20140904174840.GB14822@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 06:01:27PM +0100, Sonny Rao wrote:

[...]

> > If an OS is booted at PL2 it can access the physical counters, and
> > should do so in case something like KVM will be used later. The OS can
> > write to CNTVOFF at PL2, and if it sets CNTVOFF to zero the physical and
> > virtual counters are equivalent. Thus it can use the virtual counters
> > and doesn't need to have additional code in several places (including
> > the VDSO) where it needs to choose to read which counters to read.
> >
> > The problem only exists where PL2 exists and the firmware/bootloader
> > skipped PL2 without initialising the necessary PL2 state. This is in
> > general a stupid thing to do; it introduces a problem that need not
> > exist and throws away the option of using the features PL2 provides.
> > This is a firmware/bootloader bug.
> 
> Well it's not quite that simple, this is actually an issue with the
> hardware that the CNTVOFF comes up with different values on different
> cores.  This happens not only at boot, but any time the core is
> powered on, which could include deep sleep or CPU hotplug and suspend
> to ram.  The firmware may not be involved in all these cases, so we
> cannot rely on it to fix this problem.

And why isn't firmware involved in those cases if it _is_ involved in
cold boot ? Resuming from low-power means resuming the machine/core as it
was when it was running before power down, anything that deviates from that
behaviour is a programming bug.

Lorenzo
