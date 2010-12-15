From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 14 Dec 2010 21:03:24 -0700 (MST)
Subject: [PATCH 6/8] OMAP2+: hwmod: upgrade per-hwmod mutex to a spinlock
In-Reply-To: <20101116101809.22777.92945.stgit@twilight.localdomain>
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
	<20101116101809.22777.92945.stgit@twilight.localdomain>
Message-ID: <alpine.DEB.2.00.1012142059230.15971@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Beno?t,

On Tue, 16 Nov 2010, Paul Walmsley wrote:

> Change the per-hwmod mutex to a spinlock.  (The per-hwmod lock
> serializes most post-initialization hwmod operations such as enable,
> idle, and shutdown.)  Spinlocks are needed, because in some cases,
> hwmods must be enabled from timer interrupt disabled-context, such as
> an ISR.  The current use-case that is driving this is the OMAP GPIO
> block ISR: it can trigger interrupts even with its clocks disabled,
> but these clocks are needed for register accesses in the ISR to succeed.

The more I think about this patch, the less I like it.  At some point it 
would be good to try to convert the OMAP clock code to using mutexes in as 
many places as possible, rather than spinlocks.  When that happens, this 
is going to be a liability.  Nevertheless I will leave it this patch in 
for now by request, but this is just a simultaneous request: as we review 
these hwmod conversions, we need to be very careful with any code that 
will attempt to call the hwmod functions from timer-interrupt-disabled 
context ... we should try to discourage it if at all possible and if that 
is not possible, to put a big fat XXX comment there to review the 
situation...


- Paul
