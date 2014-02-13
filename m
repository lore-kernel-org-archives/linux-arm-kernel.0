From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 13 Feb 2014 11:26:54 -0700
Subject: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <4110788.UI9TADVhpa@wuerfel>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <20140213110721.GC13576@mudshark.cambridge.arm.com>
 <BA5E6077-77F8-4BE8-80E5-BAB9FE111387@codeaurora.org>
 <4110788.UI9TADVhpa@wuerfel>
Message-ID: <20140213182654.GA20043@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 05:28:20PM +0100, Arnd Bergmann wrote:

> > Huh?  The reg property clearly has the size in it (as shown in the
> > example below).  I guess I was just asking for the description
> > here to say what the size was for the 2 compatibles since its
> > fixed and known.
> 
> It's still an open question whether the config space in the reg
> property should cover all 256 buses or just the ones in the
> bus-range. In the latter case, it would be variable (but
> predictable) size.

The 'describe the hardware principle' says the reg should be the
entire available ECAM/CAM region the hardware is able to support.

This may be less than 256 busses, as ECAM allows the implementor to
select how many upper address bits are actually supported.

IMHO, the bus-range should be used to indicate the range of busses
discovered by the firmware, but we have historically tweaked it to
indicate the max range of bus numbers available on this bus (I think
to support the hack where two physical PCI domains were roughly glued
into a single Linux domain).

Which is not necessary when the DT stanza maps 1:1 into a PCI
domain. The driver default for bus-range should just be 0 to 255, and
it shouldn't be included in most cases.

The max busnr resource passed to the PCI core should be the lower of
the busnr property and the reg limit, IMHO.

The issue with burning VM in Linux is a Linux issue and shouldn't leak
into the DT... Ideally the solution here would be to have the PCI core
call back to the host driver when it allocates/deallocates a bus
number and then the driver can manage the config space VM mapping on a
bus by bus basis.

Jason
