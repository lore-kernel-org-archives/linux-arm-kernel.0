From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 02 Feb 2012 16:38:02 -0500 (EST)
Subject: [PATCH] ARM: cache-v7: Disable preemption when reading CCSIDR
In-Reply-To: <20120202204411.GB14129@n2100.arm.linux.org.uk>
References: <1328210686-15909-1-git-send-email-sboyd@codeaurora.org>
 <20120202204411.GB14129@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1202021632400.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Feb 2012, Russell King - ARM Linux wrote:

> On Thu, Feb 02, 2012 at 11:24:46AM -0800, Stephen Boyd wrote:
> > Should we move get_thread_info into assembler.h? It seems odd
> > to include entry-header.S but I saw that vfp was doing the same.
> 
> Probably yes, and probably also have preempt_disable and preempt_enable
> assembler macros.  That's going to get rather icky if we have to
> explicitly call the scheduler though (to solve (1)).

What about a pair of helpers written in C instead?

v7_flush_dcache_all() could be renamed, and a wrapper function called 
v7_flush_dcache_all() would call the preemption disable helper, call the 
former v7_flush_dcache_all code, then call the preemption enable helper.

Then __v7_setup() could still call the core cache flush code without 
issues.


Nicolas
