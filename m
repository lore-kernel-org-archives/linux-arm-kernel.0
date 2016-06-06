From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jun 2016 13:18:12 +0100
Subject: [RFC v2 1/4] ARM: mm: add early page table attribute
 modification ability
In-Reply-To: <1465183229-24147-2-git-send-email-wmills@ti.com>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
 <1465183229-24147-2-git-send-email-wmills@ti.com>
Message-ID: <20160606121812.GK1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 05, 2016 at 11:20:26PM -0400, Bill Mills wrote:
> Allow early-init to specify modifications to be made to the boot time page
> table. Any modifications specified will be done with MMU off at the same
> time that any Phy<->Virt fixup is done.

I think this is rather over-engineered - do we need to support multiple
different fixups to the page tables like this?

Given how this has grown, I think it would be better to duplicate the
existing swapper_pg_dir, modify the new copy, and then have the
pv-fixup-asm code merely copy the new to the old with the MMU off.
That way, the only two things that the assembly code has to do is to
deal with the page table update, and updating the TTBR registers.
Most of the complexity can then be kept in the C code.

I think we also need to modify the TTBCR to match the sharability of
memory - currently, TTB walks will be inner sharable, but my
understanding is that if we switch memory to be outer sharable, we
also need to update the TTB walks to match.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
