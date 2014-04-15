From: davem@davemloft.net (David Miller)
Date: Tue, 15 Apr 2014 14:53:56 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140415184726.GS24070@n2100.arm.linux.org.uk>
References: <20140415180311.GA11690@redhat.com>
 <20140415.143054.770827409393483803.davem@davemloft.net>
 <20140415184726.GS24070@n2100.arm.linux.org.uk>
Message-ID: <20140415.145356.1351037435109448467.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 15 Apr 2014 19:47:26 +0100

> However, unlike your "most braindead sparc" CPU, the i-cache doesn't
> snoop d-cache stores at all.

All that matters is remote snooping on SMP, not local snooping.

> However, this is something that we already deal with since
> self-modifying code has to work, so (from userspace) we have a
> syscall that is used to sort that out.  Internally in the kernel,
> this translates to:
> 
> 	ret = flush_cache_user_range(start, end)
> 
> This deals with whatever the CPU requires to be able to correctly execute
> code which has been previously written in the range - and only actions on
> the currently mapped userspace.

Looking around it seems the I-cache line mcr operation should do the
right thing for most chips.

You could simply make a new cpuc op for writing an instruction or two
to userspace and doing the I-cache line mcr op afterwards.
