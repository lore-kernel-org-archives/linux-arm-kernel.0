From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Nov 2016 18:45:32 +0000
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <20161124180751.GA5258@afzalpc>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
 <16587553.f9R1mxJih5@wuerfel> <583478FB.4020008@arm.com>
 <20161123154829.GA2489@afzalpc>
 <20161123191621.GD14217@n2100.armlinux.org.uk>
 <20161124172535.GA3524@afzalpc>
 <20161124173532.GH14217@n2100.armlinux.org.uk>
 <20161124180751.GA5258@afzalpc>
Message-ID: <20161124184532.GI14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 11:37:51PM +0530, Afzal Mohammed wrote:
> Hi,
> 
> On Thu, Nov 24, 2016 at 05:35:32PM +0000, Russell King - ARM Linux wrote:
> 
> > Right, so Freescale's iMX6, RAM starts at 0x10000000, so when building
> > for noMMU, you need to specify DRAM_START as 0x10000000 and DRAM_SIZE
> > to be the appropriate size of RAM.
> 
> Hmm.., i had thought that Vybrid's memory mappings starts from
> 0x80000000 (same TI Sitara's), just rechecked the older boot logs of
> Vybrid & Data manual, it seems it is @0x80000000, probably iMX6 has a
> different map.

Right, so if you build a multiplatform kernel which covers TI Sitara
and iMX6, then you have a choice:

- Set DRAM_START to 0x10000000, and have a kernel which will boot on
  iMX6 but fail on TI Sitara.
- Set DRAM_START to 0x80000000, and have a kernel which will boot on
  TI Sitara, but fail on iMX6 with less than 2GiB of memory (0x70000000
  bytes to be exact.)

This is why multiplatform doesn't make sense for noMMU - you can't
actually build a multiplatform kernel that will work across all
these platforms.

You'd have to re-link it (at the very least) to place the data section
elsewhere in physical memory to make it work.

It's this reason that I don't like removing the "depends on MMU" from
multiplatform - it gives the incorrect impression that we _can_ support
a wide range of systems, but what it will lead to is a kernel that will
work on some platforms but not others.  The result will be more "bug"
reports because the kernel fails to boot...

In any case, I think kernelci and similar would first need to be updated
to avoid trying to boot noMMU kernels on hardware which it just can't
boot on - we _really_ do not want to be randomly scribbling into physical
memory, potentially hitting devices, especially with devices that contain
OTP fuses that set options as security features.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
