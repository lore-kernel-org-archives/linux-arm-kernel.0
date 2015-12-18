From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2015 19:56:17 +0000
Subject: [PATCH 0/3] Batched user access support
In-Reply-To: <alpine.LFD.2.20.1512171016510.27310@i7>
References: <alpine.LFD.2.20.1512171016510.27310@i7>
Message-ID: <20151218195617.GQ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 10:33:21AM -0800, Linus Torvalds wrote:
> So this patch series introduces a model for batching that SMAP overhead on 
> x86, and the reason the ARM people are involved is that the same _may_ be 
> true of the PAN overhead. I don't know - for all I know, the pstate "set 
> pan" instruction may be so cheap on ARM64 that it doesn't really matter.

I think it may be of use on 32-bit ARM, so we don't have to keep switching
the domain register between allowing and denying userspace access across
a batch of userspace operations.

The area I'm specifically thinking that it'd be useful is in the ARM
signal handling code, where we already have our special "__get_user_error"
which tries to be as efficient as possible, though that may be a false
optimisation.  Since the SW PAN stuff, I've been debating about converting
that to use copy_to_user()/copy_from_user() instead, but haven't yet found
the time to do any analysis.

See restore_sigframe() and setup_sigframe() in arch/arm/kernel/signal.c.

I'm not sure I'll have any time to look into this before the new year
though.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
