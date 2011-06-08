From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Jun 2011 21:01:06 +0100
Subject: [PATCH] ARM: mm: ensure TTBR0 is restored when changing ASID
	on rollover
In-Reply-To: <1307443118-11573-1-git-send-email-will.deacon@arm.com>
References: <1307443118-11573-1-git-send-email-will.deacon@arm.com>
Message-ID: <20110608200106.GA13151@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 11:38:38AM +0100, Will Deacon wrote:
> Russell - I've reposted this to the list because it somehow got lost in
> the archive and you've expressed some concerns over the code via the
> patch system. I think the only opportunity for a race is when a CPU
> doing switch_mm is interrupted by a rollover event occurring on another
> core, but this is something that exists in the current code anyway and
> is not affected by this patch.

However, these patches are introducing a brand new race between the
switch_mm code and the reset_context code.

With the new switch_mm() code, we switch TTBR0 to be the same as TTBR1.
If we then receive an IPI for reset_context(), we will change TTBR0
to point at a set of page tables which don't contain just global mappings.

After returning from reset_context(), we will resume switch_mm(), and
change the ASID value with the page tables pointing to non-global
mappings, violating the whole reason for the switch_mm() change.

The only way around this is to make reset_context() preserve the TTBR0
value across itself, by reading it initially and then restoring before
returning.

So, even though the current code is broken, I'm not applying this patch
as it isn't anywhere near right - and we can do right quite easily here.
