From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Feb 2015 17:34:40 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150205170228.GZ5370@linux.vnet.ibm.com>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <20150205170228.GZ5370@linux.vnet.ibm.com>
Message-ID: <20150205173440.GR8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 09:02:28AM -0800, Paul E. McKenney wrote:
> On Thu, Feb 05, 2015 at 04:11:00PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Feb 05, 2015 at 06:29:18AM -0800, Paul E. McKenney wrote:
> > > Works for me, assuming no hidden uses of RCU in the IPI code.  ;-)
> > 
> > Sigh... I kind'a new it wouldn't be this simple.  The gic code which
> > actually raises the IPI takes a raw spinlock, so it's not going to be
> > this simple - there's a small theoretical window where we have taken
> > this lock, written the register to send the IPI, and then dropped the
> > lock - the update to the lock to release it could get lost if the
> > CPU power is quickly cut at that point.
> > 
> > Also, we _do_ need the second cache flush in place to ensure that the
> > unlock is seen to other CPUs.
> > 
> > We could work around that by taking and releasing the lock in the IPI
> > processing function... but this is starting to look less attractive
> > as the lock is private to irq-gic.c.
> > 
> > Well, we're very close to 3.19, we're too close to be trying to sort
> > this out, so I'm hoping that your changes which cause this RCU error
> > are *not* going in during this merge window, because we seem to have
> > something of a problem right now which needs more time to resolve.
> 
> Most likely into the 3.20 merge window.  But please keep in mind that
> RCU is just the messenger here -- the current code will break if any
> CPU for whatever reason takes more than a jiffy to get from its
> _stop_machine() handler to the end of its last RCU read-side critical
> section on its way out.  A jiffy may sound like a lot, but it is not
> hard to exceed this limit, especially in virtualized environments.

What I'm saying is that we can't likely get a good fix prepared before
the 3.20 merge window opens.

I don't term the set_bit/clear_bit solution a "good fix" because it is
far too complex - I've not done a thorough review on it, but the idea
of setting and clearing a couple of bits in unison, making sure that
their state is set appropriately through multiple different code paths
does not strike me as a provably correct replacement for this completion.
The reason for that complexity is because there is no pre-notification
to arch code that a CPU might be going down, so there's no way for the
"CPU is dead" flag to be properly reset (which is why there's all the
manipulation in lots of possible failure paths.)

The idea that we could reset it in the CPU up code doesn't fly - that
would only work if we had one secondary CPU (which would guarantee a
strict up/down/up ordering on it) but as soon as you have more than one
CPU, that doesn't hold true.

We could hook into the CPU hotplug notifiers - which would be quite a
lot of additional code to achieve the reset early enough in the hot
unplug path, though it would probably be the most reliable solution to
the wait-for-bit solution.

However, any of those solutions needs writing and thorough testing,
which, if Linus opens the merge window on Sunday, isn't going to
happen before hand (and we know Linus doesn't like extra development
appearing which wasn't in -next prior to the merge window - he's taken
snapshots of -next to check during the merge window in the past - so
it's not something I'm going to be adding during that time, not even
as a "fix" because we know about the problem right now, before the
merge window.  To me, to treat this as a "fix" would be wilfully
deceitful.)

I don't think the existing code is a big problem at the moment - it's
been like this for about 10 years, and no one has ever reported an
issue with it, although there have been changes over that time:

aa033810461ee56abbef6cef10aabd6b97f5caee
ARM: smp: Drop RCU_NONIDLE usage in cpu_die()

	This removed the RCU_NONIDLE() from the completion() call.

ff081e05bfba3461119cd280201d163b6858eda2
ARM: 7457/1: smp: Fix suspicious RCU originating from cpu_die()

	This added the RCU_NONIDLE() to the completion() call.

3c030beabf937b1d3b4ecaedfd1fb2f1e2aa0c70
ARM: CPU hotplug: move cpu_killed completion to core code

	This moved the completion code from Realview (and other ARM
	platforms) into core ARM code.

and 97a63ecff4bd06da5d8feb8c0394a4d020f2d34d
[ARM SMP] Add CPU hotplug support for Realview MPcore

	The earliest current introduction of CPU hotplug in 2005.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
