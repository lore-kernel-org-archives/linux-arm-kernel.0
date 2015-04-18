From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Apr 2015 10:08:45 +0100
Subject: [PATCH] ARM: mm: add imprecise abort non-deadly handler
In-Reply-To: <1429316083.8341.76.camel@xylophone.i.decadent.org.uk>
References: <1429316083.8341.76.camel@xylophone.i.decadent.org.uk>
Message-ID: <20150418090845.GH12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 18, 2015 at 01:14:43AM +0100, Ben Hutchings wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Given that imprecise aborts may be delivered after the action that
> caused them (or even for non-cpu related activities such as bridge
> faults from a bus-master) it is possible that the wrong process is
> terminated as a result.
> 
> Add a handler to take and print imprecise aborts and allow the process
> to continue. This should ensure that the abort is shown but not kill
> the process that was running on the cpu core at the time.

I'm not happy with this.

On older CPUs, you generally get the "imprecise" (aka external) aborts
within a few cycles of the faulting instruction, which is good enough
to ensure that the appropriate process gets terminated.

Yes, this is not true of ARMv7, where such faults can happen a longer
time after the access which caused them.

However, I would argue that merely printing a message to the kernel
log is insufficient - especially as the kernel networking layer can
spam the log so that such messages yet rotated out of the ring buffer.

An imprecise abort is a serious condition, one which _ought_ to be very
noticable, on the level of panic()ing the kernel.  It's a data loss
condition, one which _can_ result in corruption of user data or even
filesystems.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
