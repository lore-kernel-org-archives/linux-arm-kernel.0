From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Mar 2017 16:46:19 +0000
Subject: [PATCH] of: Fix DMA mask assignment
In-Reply-To: <CAL_JsqKAuyePWUC-K21uZEjBU29EZA3WUQOYQdwAZUMOz+mEFg@mail.gmail.com>
References: <94ede94e98502a7948085fba5a16994d3805010c.1488910224.git.robin.murphy@arm.com>
 <CAL_JsqKAuyePWUC-K21uZEjBU29EZA3WUQOYQdwAZUMOz+mEFg@mail.gmail.com>
Message-ID: <20170322164619.GG21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 10:19:58AM -0500, Rob Herring wrote:
> On Tue, Mar 7, 2017 at 12:12 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> > As we start moving towards mandating that device DMA addressing
> > capabilities are correctly described in DT for platforms like arm64,
> 
> Why? There's no point to dma-ranges if the bus is not restricting the
> device. dma-ranges is supposed to apply to a bus, not a device. For
> example, using dma-ranges for a 32-bit device on a 64-bit platform is
> wrong. To put it another way, devices know their addressing
> capability, so we don't need to describe that in DT, only external
> restrictions outside of the device.
> 
> > it
> > turns out that actually assigning DMA masks wider than 32 bits from
> > "dma-ranges" is made largely impossible by the current code. New PCI
> > devices are passed in with 32-bit masks, while new platform devices are
> > passed in with their masks unset, so we install default 32-bit masks for
> > them. As a result, subsequently taking the minimum between any existing
> > mask and the size given by "dma-ranges" means that we can never exceed
> > 32 bits for the vast majority of devices.
> >
> > Since the DT can be assumed to describe the hardware appropriately, and
> > the device's driver is expected by the DMA API to explicitly set a mask
> > later when it probes, we can safely let "dma-ranges" unconditionally
> > override any initial mask from device creation (and as a small bonus
> > deduplicate the calculation in the process).
> >
> > CC: Arnd Bergmann <arnd@arndb.de>
> > CC: Murali Karicheri <m-karicheri2@ti.com>
> > Fixes: 9a6d7298b083 ("of: Calculate device DMA masks based on DT dma-range size")
> 
> Changing behavior since 4.1 doesn't really seem like a fix. A fix
> should generally be tagged for stable and I'd be nervous on this one.
> 
> Are we sure all the things a driver may do still work the same? A
> driver changing the default 32-bit mask to a 64-bit mask for example.

I'll re-iterate about the DMA API requirements.  All drivers that perform
DMA are expected to perform DMA mask negotiation with the architecture
code.  That means all drivers should use:

	dma_set_mask()

if they intend to use the streaming DMA APIs,

	dma_set_coherent_mask()

if they intend to use the coherent DMA API, or

	dma_set_mask_and_coherent()

if they intend to use both APIs.  Drivers that omit these calls are
buggy.

It is also required that drivers check the return value from these
calls, since failure means that (eg) they are not allowed to perform
64-bit DMA.

The mask that the driver passes in to these functions is determined
by two things:

(a) how many address lines the device supports
(b) the addressing mode that the driver wishes to enable for the device

For example, on PCI, to use 64-bit DMA, DAC addressing is necessary.
A PCI driver must have successfully negotiated a >32-bit DMA mask in
order to use DAC addressing, as this indicates whether the upstream
supports DAC addressing cycles.

There may be other restrictions that the device driver is unaware of.

So, these three functions are part of a negotiation that drivers are
expected to perform, and moving this information into DT does not
negate the need for drivers to perform this negotiation.

Drivers that use the DMA mask coerce() functions are fundamentally
buggy drivers that either (a) didn't set a DMA mask before there was
code in DT/elsewhere to provide the default mask, or (b) are overriding
the negotiation mechanism.  No new drivers should ever use the DMA mask
coerce functions.

Hope this helps.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
