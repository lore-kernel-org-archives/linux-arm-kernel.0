From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Mar 2014 16:05:15 +0000
Subject: CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS and bcm2835_defconfig
In-Reply-To: <532080C4.2000801@wwwdotorg.org>
References: <alpine.DEB.2.10.1403101717050.31525@vincent-weaver-1.um.maine.edu>
 <531FE40C.1060709@wwwdotorg.org>
 <20140312110315.GG21483@n2100.arm.linux.org.uk>
 <532080C4.2000801@wwwdotorg.org>
Message-ID: <20140312160515.GK21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 09:44:04AM -0600, Stephen Warren wrote:
> On 03/12/2014 05:03 AM, Russell King - ARM Linux wrote:
> > On Tue, Mar 11, 2014 at 10:35:24PM -0600, Stephen Warren wrote:
> >> Hmm. I thought that ARMv6 didn't have efficient unaligned accesses, but
> >> I suppose it must; ARM selects HAVE_EFFICIENT_UNALIGNED_ACCESS for
> >> v6/v6k/v7. BUILTIN_BSWAP seems innocuous. Can you verify which of those
> >> two options actually causes problems for you?
> > 
> > What do you think is different between v6 and v7 for unaligned accesses?
> 
> I don't know the details of unaligned accesses; I'm just remembering
> (probably incorrectly and/or misinterpreting) some discussion in U-Boot
> about ARMv7 being able to do unaligned accesses OK, yet earlier
> generations not being able to (although I don't recall which), and hence
> the toolchain options are set up to disallow them, and the ARMv7(?)
> config bit that enables them is left disabled, so such accesses cause an
> exception, so it's easy to catch the problems that must happen on older
> HW even when running on newer HW, even though such access could be
> allows on ARMv7.

The ARM ARM indicates that there's no significant changes between v6 and v7
CPUs for unaligned accesses.  See Appendix L in DDI0406C, section L.3.1.
ARMv6 and v7 are the same, except v6 also supports the v5 model in this
regard, which can be appropriately configured via the U bit.

Effectively, for ARMv5 and earlier, U is always 0.  For ARMv6, U can be
0 or 1.  For ARMv7, U is always 1.

The kernel decompressor always sets U=1 A=0 for ARMv6 and above.  The
kernel does the same.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
