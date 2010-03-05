From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Mar 2010 21:01:36 +0000
Subject: [PATCH] make the default alignment trap behavior configurable
	for user space
In-Reply-To: <20100305150101.GC23225@pengutronix.de>
References: <alpine.LFD.2.00.0812092312130.14328@xanadu.home>
	<200812111015.28688.siarhei.siamashka@nokia.com>
	<alpine.LFD.2.00.0812110915230.14328@xanadu.home>
	<20100305150101.GC23225@pengutronix.de>
Message-ID: <20100305210136.GD4885@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 05, 2010 at 04:01:01PM +0100, Uwe Kleine-K?nig wrote:
> I like that patch.  (And I'd choose SIGBUS.)
> 
> Is it still considered?

Absolutely not.

Alignment faults _remain_ a reality.  I've recently built a new glibc -
and guess what, it _relies_ upon alignment faults - I'm up to 2321607
userspace alignment faults.

If you decide to make alignment faults create a SIGBUS, then you kill any
system booting using some glibc's and with gconv support.

The hard fact is: the correct setting of the alignment fault handler is
_entirely_ _specific_ to the userspace you are running.  There is no one
correct setting for it.

To this end, recent kernels now have a kernel command line option to
chose the correct alignment fault handling behaviour - which is the right
thing to do since a multi-platform kernel may require different options
for their different userspaces.
