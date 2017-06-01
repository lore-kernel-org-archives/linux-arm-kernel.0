From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Jun 2017 17:42:09 +0100
Subject: how can KAsan support arm32?
In-Reply-To: <e7d99272-bff0-59b9-f4ca-8b4482ef9bf4@virtuozzo.com>
References: <d202a49e-ee0f-4864-b24b-b185255c7f11@googlegroups.com>
 <CACT4Y+aEW+CNH40mwY_i-mzL3cRYHc8EdMyhQj6dAiS+=0TpXg@mail.gmail.com>
 <20170601112424.GA8718@leverpostej>
 <CACT4Y+b5OiNrQqK-A2qHquZo266eXykWROLP=qj_BW__S2Wi5w@mail.gmail.com>
 <ba9fb499-98c5-4cfe-b68e-48a8df8d4ca9@googlegroups.com>
 <e7d99272-bff0-59b9-f4ca-8b4482ef9bf4@virtuozzo.com>
Message-ID: <20170601164209.GD22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 01, 2017 at 07:37:26PM +0300, Andrey Ryabinin wrote:
> kasan needs at least 1/8 of the total memory, so it will be 32MB in
> your case.

Is that really the case?  It is if we want to account for every byte,
but I don't think that's necessary.

Memory is allocated not on a per-byte basis, but on a larger granule,
mainly determined by L1_CACHE_BYTES / ARCH_SLAB_MINALIGN etc.  While
it means that we would lose the ability to capture accesses that
happen strictly over the size requested from kmalloc() etc, if we
implemented this, it would at least allow the more seriously wrong
accesses to be trapped, while being cheaper.

So, for 1GB of kernel virtual space, we'd only need 4MB for the bitmap
for a 32-byte cache line system, which is much less of a problem.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
