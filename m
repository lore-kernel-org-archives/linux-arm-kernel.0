From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Apr 2014 19:47:26 +0100
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140415.143054.770827409393483803.davem@davemloft.net>
References: <20140415174330.GA10558@redhat.com>
 <20140415.134627.1895466146177627985.davem@davemloft.net>
 <20140415180311.GA11690@redhat.com>
 <20140415.143054.770827409393483803.davem@davemloft.net>
Message-ID: <20140415184726.GS24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 02:30:54PM -0400, David Miller wrote:
> Russell, if for example userland stores into the instruction stream
> to patch an instruction, what needs to be done on ARM?

Hi David,

I'm afraid I won't be too responsive this week, but I'll try to provide
input where I can.  So I'll try to cover all points in the previous
discussion in this reply.

I think your suggestion that we should be writing directly to userspace
from uprobes is definitely the correct way forward, as that nicely takes
any d-cache aliasing issues completely out of the picture.

However, unlike your "most braindead sparc" CPU, the i-cache doesn't
snoop d-cache stores at all.  However, this is something that we already
deal with since self-modifying code has to work, so (from userspace) we
have a syscall that is used to sort that out.  Internally in the kernel,
this translates to:

	ret = flush_cache_user_range(start, end)

This deals with whatever the CPU requires to be able to correctly execute
code which has been previously written in the range - and only actions on
the currently mapped userspace.

I hope this helps.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
