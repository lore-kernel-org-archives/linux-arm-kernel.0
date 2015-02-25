From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Feb 2015 17:00:11 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <alpine.LFD.2.11.1502250941210.25484@knanqh.ubzr>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <20150225125610.GY8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502250941210.25484@knanqh.ubzr>
Message-ID: <20150225170011.GC8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 11:47:48AM -0500, Nicolas Pitre wrote:
> I completely agree with the r/w spinlock. Something like this ought to 
> be sufficient to make gic_raise_softirq() reentrant which is the issue 
> here, right?  I've been stress-testing it for a while with no problems 
> so far.

No.  The issue is that we need a totally lockless way to raise an IPI
during CPU hot-unplug, so we can raise an IPI in __cpu_die() to tell
the __cpu_kill() code that it's safe to proceed to platform code.

As soon sa that IPI has been received, the receiving CPU can decide
to cut power to the dying CPU.  So, it's entirely possible that power
could be lost on the dying CPU before the unlock has become visible.

It's a catch-22 - the reason we're sending the IPI is for synchronisation,
but right now we need another form of synchronisation because we're
using a form of synchronisation...

We could just use the spin-and-poll solution instead of an IPI, but
I really don't like that - when you see the complexity needed to
re-initialise it each time, it quickly becomes very yucky because
there is no well defined order between __cpu_die() and __cpu_kill()
being called by the two respective CPUs.

The last patch I saw doing that had multiple bits to indicate success
and timeout, and rather a lot of complexity to recover from failures,
and reinitialise state for a second CPU going down.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
