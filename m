From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2016 17:29:46 +0100
Subject: [PATCH 06/10] ARM: V7M: Implement cache macros for V7M
In-Reply-To: <575EDEF4.7000205@arm.com>
References: <1465830189-20128-1-git-send-email-vladimir.murzin@arm.com>
 <1465830189-20128-7-git-send-email-vladimir.murzin@arm.com>
 <20160613151845.GW1041@n2100.armlinux.org.uk>
 <575EDEF4.7000205@arm.com>
Message-ID: <20160613162946.GX1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 05:27:32PM +0100, Vladimir Murzin wrote:
> On 13/06/16 16:18, Russell King - ARM Linux wrote:
> > On Mon, Jun 13, 2016 at 04:03:05PM +0100, Vladimir Murzin wrote:
> >> From: Jonathan Austin <jonathan.austin@arm.com>
> >>
> >> This commit implements the cache operation macros for V7M, paving the way
> >> for caches to be used on V7 with a future commit.
> >>
> >> Because the cache operations in V7M are memory mapped, in most operations an
> >> extra register is required compared to the V7 version, where the type of
> >> operation is encoded in the instruction, not the address that is written to.
> >>
> >> Thus, an extra register argument has been added to the cache operation macros,
> >> that is required in V7M but ignored/unused in V7. In almost all cases there
> >> was a spare temporary register, but in places where the register allocation
> >> was tighter the M_CLASS macro has been used to avoid clobbering new
> >> registers.
> > 
> > It's probably way more efficient to just implement this as an entirely
> > separate implementation, rather than trying to bodge this into the v7
> > stuff.
> > 
> 
> It might be an option, but having all these as a macro make it possible
> to have cache support in decompresser (not presented in this series)
> too. If you don't buy it I'll think of moving to an entirely separate
> implementation as you've just suggested.

What I really don't like is shoe-horning v7m support into cache-v7.
v7m cache support should be in a separate file called cache-v7m.S.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
