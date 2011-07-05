From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 05 Jul 2011 15:17:33 -0400 (EDT)
Subject: [PATCH] ARM: poison initmem when it is freed
In-Reply-To: <20110705184254.GH8286@n2100.arm.linux.org.uk>
References: <20110705184254.GH8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107051509490.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Jul 2011, Russell King - ARM Linux wrote:

> When the initmem is freed, we can no longer rely on its contents.  In
> lightly loaded systems, this memory may persist for some time, making
> it harder discover run-time issues (caused by the build warnings being
> ignored.)
> 
> Poison the initmem at the point where it is freed to encourage run-time
> problems when initmem is dereferenced as an aid to finding such problems.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

The default poison doesn't appear to be a judicious choice for ARM.

include/linux/poison.h:#define POISON_FREE_INITMEM      0xcc

   0:   cccccccc        stclgt  12, cr12, [ip], {204}   ; 0xcc

So if the gt condition is false this will execute nops until it falls 
out of the initmem section.  Would be nicer if a fault could be 
generated right at the accessed address which could be looked up.


Nicolas
