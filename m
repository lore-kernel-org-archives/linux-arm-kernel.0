From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Oct 2012 08:29:14 +0100
Subject: alignment faults in 3.6
In-Reply-To: <506E1762.3010601@gmail.com>
References: <506E1762.3010601@gmail.com>
Message-ID: <20121005072914.GE4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 06:10:26PM -0500, Rob Herring wrote:
> I would think the scheduling while atomic messages are harmless in this
> case. However, in addition to spewing out BUG messages this commit also
> seems to eventually cause a kernel panic in __napi_complete. That panic
> seems to go away if I put barrier() between the 2 accesses above which
> eliminates the alignment faults. I haven't figured that part out yet.
> 
> There's at least a couple of problems here:
> 
> This seems like an overly aggressive compiler optimization considering
> unaligned accesses are not supported by ldm/stm.
> 
> The alignment fault handler should handle kernel address faults atomically.

This is bad news.  do_alignment() can be called in almost any kernel
context, and it must work.  die() and oops dumps - specifically dump_mem()
and dump_instr() will suffer from exactly the same problem.

Will, can you take a look please?
