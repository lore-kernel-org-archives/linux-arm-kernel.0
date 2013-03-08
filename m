From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 8 Mar 2013 09:14:39 +0100
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130306230412.GA5870@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
Message-ID: <20130308091439.15c7bafd@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Wed, 6 Mar 2013 16:04:12 -0700, Jason Gunthorpe wrote:

> The discussion was around the SOC specific tables in the driver and if
> they should be in DT or C code. These tables very much describe the
> hardware, and are copied from similar tables in the Marvell manuals.
> 
> For instance I repeated this idea:
> 
>    ranges =<MAPDEF(1, 0xe0, MAPDEF_NOMASK)  0xFE000000  0x10000 // boot rom
>             MAPDEF(1, 0x3f, MAPDEF_NOMASK)  0xFD000000  0x10000 // devbus-boot
>             MAPDEF(1, 0xxx, MAPDEF_NOMASK)  0xFF000000  0x10000 // internal-regs
>              [..]

A few other issues with this:

 * It forces us to repeat the base address of the NOR twice in the
   Device Tree. Once in the ranges = <...> property of the MBus DT node,
   and once in the reg = <...> property of the NOR DT node. Duplication
   of identical information, isn't that something that sounds broken?

 * If we do dynamic allocation of the base address, it means that the
   DT is no longer an accurate representation of what happens for real.
   The user will write 0xDEADBEEF in the DT, and will get its NOR
   mapped at 0xBEEFDEAD. Isn't that uselessly confusing?

Sorry, but your proposal still has many, many disadvantages over the
currently proposed solution, and no compelling argument other than your
own perception that the DT should describing the address mapping.

With MBus, the DT cannot describe the address mapping because it is
fundamentally dynamic. Why the heck would we describe NOR windows in
the DT and not the PCIe ones? They are both dynamic in the exact same
way.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
