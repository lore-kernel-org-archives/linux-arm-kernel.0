From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jul 2015 22:00:44 +0100
Subject: [PATCH] ARM: BCM: Restrict Broadcom BCM470X / BCM5301X to non-LPAE
In-Reply-To: <5941809.XWvPzT6esn@wuerfel>
References: <1436897535-3782-1-git-send-email-f.fainelli@gmail.com>
 <9845978.JUsldTlF3B@wuerfel> <55A68C9C.8000303@gmail.com>
 <5941809.XWvPzT6esn@wuerfel>
Message-ID: <20150715210044.GH7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 10:41:51PM +0200, Arnd Bergmann wrote:
> On Wednesday 15 July 2015 09:38:52 Florian Fainelli wrote:
> > 
> > I like the idea in general, but I think this is going to be a very
> > tedious job to collect every single CR values for ARMv7 processors to
> > determine whether they are pure v7 or v7e... Maybe we could use
> > kernelci.org to start extracting the relevant lines in bootlogs and
> > people can start adding their own chips one by one?
> 
> No, we know most of them:
> 
> Cortex-A5, A8, A9: ARMv7, no LPAE, no IDIV
> Cortex-A7, A15, A12, A17: ARMv7VE, no LPAE, no IDIV
> 
> 
> Almost everyone uses the above cores unmodified.
> 
> The ones I'm not 100% sure about are:
> 
> Marvell PJ4 (almost certainly ARMv7)
> Marvell PJ4B (probably ARMv7 plus IDIV without LPAE)

Dove (PJ4B iirc):

Features        : half thumb fastmult vfp edsp iwmmxt thumbee vfpv3
		  vfpv3d16 tls idivt

So, thumb-only idiv, no LPAE.

> If my list above is correct, there are no CPUs that have
> LPAE but don't have IDIV, and we just need to decide how
> to represent that.

GCC ARMv7VE selects ARM idiv and Thumb idiv support, so you need to
check for idiva and idivt support from the CPU, otherwise we're into
even more Kconfig dependency hell trying to work out the dependencies
for T2 kernel builds vs ARM kernel builds.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
