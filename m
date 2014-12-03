From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 18:06:08 +0100
Subject: Creating 16 MB super-sections for MMIO
In-Reply-To: <547F1C11.5090408@free.fr>
References: <547D97A5.4090302@free.fr>
 <20141203103211.GB7373@e104818-lin.cambridge.arm.com>
 <547F1C11.5090408@free.fr>
Message-ID: <2452742.elcJohDinR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 15:20:01 Mason wrote:
> 
> As far as I could tell, Linux does not create a super-section in the
> case outlined above. Perhaps I misread the source code?

I believe you are right, and I also agree that in theory implementing
what you say (both 64k and 16M mappings) can only help, but it's not
obvious if this makes a measurable difference in the end.

MMIO register accesses are usually slow for other reasons, and
they tend to be rare, so it's possible that you won't be able
to ever tell a difference because the MMIO TLB often gets evicted
by user mappings between accesses to different 1MB sections,
and the timing difference between a TLB-hot and cold MMIO access
might not be that great (depending on the latency of a particular
register).

I don't think there would be any objections to doing superpage
or supersection mappings for early page tables if you can show
any benefit whatsoever, but it may be hard to come up with a
scenario where it's actually measurable.

	Arnd
