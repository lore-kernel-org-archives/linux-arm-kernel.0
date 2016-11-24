From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Nov 2016 17:35:32 +0000
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <20161124172535.GA3524@afzalpc>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
 <16587553.f9R1mxJih5@wuerfel> <583478FB.4020008@arm.com>
 <20161123154829.GA2489@afzalpc>
 <20161123191621.GD14217@n2100.armlinux.org.uk>
 <20161124172535.GA3524@afzalpc>
Message-ID: <20161124173532.GH14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 10:55:35PM +0530, Afzal Mohammed wrote:
> Hi,
> 
> On Wed, Nov 23, 2016 at 07:16:21PM +0000, Russell King - ARM Linux wrote:
> 
> > Well, !MMU and multiplatform _are_ exclusive in reality.  One of the
> > things we work around in multiplatform is the different physical
> > address space layouts of the platforms, particularly with where RAM
> > is located.  That's not possible in !MMU configurations.  A kernel
> > built to support every platform in multiplatform will not boot on
> > most of them.
> > 
> > So efforts to make !MMU work with multiplatform are IMHO rather
> > misguided.
> > 
> > !MMU makes sense with classifications of systems (like the Cortex-M*
> > based systems) but not everything.
> 
> Okay, seems you were referring to AUTO_ZRELADDR or if you had
> something else in mind, please let me know.

No, I'm talking about the kernel proper itself.

> The plan was to use Image instead of zImage. Here there are 2
> platforms, Freescale's, oh no, NXP's, oh no no, Qualcomm's Vybrid
> (vf610) and TI's Sitara siblings (am335x beagle & am437x).

Right, so Freescale's iMX6, RAM starts at 0x10000000, so when building
for noMMU, you need to specify DRAM_START as 0x10000000 and DRAM_SIZE
to be the appropriate size of RAM.

You'll be able to run the same "Image" kernel on the other platforms
_if_ and _only_ _if_ they have RAM covering the same region.

That's my point - the kernel image will be linked to place its
read-write data at a certain location in the address space, and if
you have the MMU disabled (or in 1:1 translation mode) you _must_
have RAM at that location.

The reason multiplatform works is because we use the MMU to abstract
away the differences in the location of RAM on the platform (amongst
other things.)

Also note that Cortex-A class CPUs don't perform well with the MMU
off, because you can't enable the data cache - and you must have the
data cache enabled for SMP to be functional, and it's also required
for exclusives to work.

There's also some cases where "Device, non-shared" must be used to
access some devices, which can only be done with the MMU enabled.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
