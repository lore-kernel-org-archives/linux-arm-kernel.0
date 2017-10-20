From: lsun@mellanox.com (Liming Sun)
Date: Fri, 20 Oct 2017 15:07:40 +0000
Subject: [PATCH 0/9] Enable dw-mmc multi-card support
In-Reply-To: <f71d94dc-7277-8675-c21e-9c2ec77174e7@samsung.com>
References: <cover.1507315433.git.lsun@mellanox.com>
 <8e433531-8f67-d575-635e-c6ced29f6804@rock-chips.com>
 <CGME20171017155217epcas3p4de2f27b921ce77234a2d3e46e4b17473@epcas3p4.samsung.com>
 <AM2PR05MB07533A822C7CCBA7111FD58FA14C0@AM2PR05MB0753.eurprd05.prod.outlook.com>
 <f71d94dc-7277-8675-c21e-9c2ec77174e7@samsung.com>
Message-ID: <AM2PR05MB07537D50A18D391CD2295D84A1430@AM2PR05MB0753.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Jaehoon. Please also see my response inline.

- Liming

> -----Original Message-----
> From: Jaehoon Chung [mailto:jh80.chung at samsung.com]
> Sent: Friday, October 20, 2017 10:06 AM
> To: Liming Sun <lsun@mellanox.com>; Shawn Lin <shawn.lin@rock-
> chips.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Kukjin Kim
> <kgene@kernel.org>; Krzysztof Kozlowski <krzk@kernel.org>; linux-
> mmc at vger.kernel.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> samsung-soc at vger.kernel.org; Chris Metcalf <cmetcalf@mellanox.com>
> Subject: Re: [PATCH 0/9] Enable dw-mmc multi-card support
> 
> Sorry for late this..
> 
> On 10/18/2017 12:52 AM, Liming Sun wrote:
> >>> Hrm.... it's so unlucky that your patchset comes a little late. As your patch
> 8 and 9 said, you need them to fix problem for multi-card support, so
> definitely there was no such use case, and even the code was buggy to
> support it right? That makes the code hard to read and maintain, so we
> decide to remove it.
> >
> > Thanks for the feedback. Yes, earlier the multi-card support was buggy
> indeed. We spent some time to debug it and got it working.
> >
> >>> Havn'e check the databook for details yet, but I think it's ok to re-
> introduce multi-slot support if a real user benefits from it. But you need a
> new patch to silent the log "num-slots property not found, assuming 1 slot is
> available" as we removed all the num-slots from DT at that time.
> >
> > The " num-slots property not found..." log message has already been
> removed by 8a629d26f back in 2016. Looks like we're good on this one. In
> dw_mci_probe (), it has code to check pdata->num_slots. If 0, the host-
> >num_slots will be set to 1. So the logic of setting default num_slots seems
> already there. But correct me if I am wrong.
> >
> > Thanks,
> > Liming
> >
> > -----Original Message-----
> > From: Shawn Lin [mailto:shawn.lin at rock-chips.com]
> > Sent: Monday, October 16, 2017 9:36 PM
> > To: Liming Sun <lsun@mellanox.com>; Jaehoon Chung
> > <jh80.chung@samsung.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring
> > <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Kukjin
> Kim
> > <kgene@kernel.org>; Krzysztof Kozlowski <krzk@kernel.org>;
> > shawn.lin at rock-chips.com; linux-mmc at vger.kernel.org;
> > devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> > linux-arm-kernel at lists.infradead.org;
> > linux-samsung-soc at vger.kernel.org
> > Subject: Re: [PATCH 0/9] Enable dw-mmc multi-card support
> >
> >
> > On 2017/10/7 3:21, Liming Sun wrote:
> >> This series of commits enables the multi-card support for the dw-mmc
> >> controller. It includes two parts as below.
> >>
> >> The first part (patches 1-7) reverts the series of recent commits
> >> that removed the multi-card support with comments saying there was no
> >> such use case in the real world. Actually this feature is being used
> >> in Mellanox Bluefield SoC and has been requested by customers.
> >
> > Hrm.... it's so unlucky that your patchset comes a little late. As your patch 8
> and 9 said, you need them to fix problem for multi-card support, so definitely
> there was no such use case, and even the code was buggy to support it right?
> That makes the code hard to read and maintain, so we decide to remove it.
> 
> Hmm..
> Well, if i missed your reply for my removing patch, it's my fault..but i didn't
> see any reply..
> At that time, we didn't see any usage and also now...

[Liming] It is definitely not anybody's fault. My apology that I should have made it very clear.
This is a new SoC which uses two eMMC cards. This feature has been requested by customer.
We made it working with patches, then realized that the support for the 2nd card was removed recently from upstream kernel.
To avoid reinventing the wheel, a better approach appears to bring back the changes.

> 
> Are there any patches for using multi slot?
> e,g) device-tree file or your own driver

[Liming] Patch 9/8 and 9/9 are the changes to fix the multi-slot support.
We follow the original "Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt" for device configuration.
There is no device-tree patches since there is no changes to any of the documentation syntax.

Just in case you might be interested, below is the ACPI table we used to include the two slots. It's defined according to synopsys-dw-mshc.txt and seems working.

    Device (MMC0) {
      Name (_HID, "PRP0001")
      Name (_UID, Zero)
      Name (_CCA, 1)
      Name (_CRS, ResourceTemplate() {
        Memory32Fixed(ReadWrite, 0x6008000, 0x400)
        Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive) { 64 }
      })

      // Common configuration
      Name(_DSD, Package() {
        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package() {
          Package () { "compatible", Package () {"snps,dw-mshc"}},
          Package () { "fifo-depth", 0x100 },
          Package () { "clock-frequency", 24000000 },
          Package () { "cap-mmc-highspeed", 1 },
          Package () { "card-detect-delay", 200 },
          Package () { "num-slots", 2 }
        }
      })

      // Slot-0
      Device (SLT0) {
        Name(_DSD, Package() {
          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
          Package() {
            Package () { "reg", 0 },              // physical slot number
            Package () { "bus-width", 8 }         // bus width (8-bit)
          }
        })
      }

      // Slot-1
      Device (SLT1) {
        Name(_DSD, Package() {
          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
          Package() {
            Package () { "reg", 1 },              // physical slot number
            Package () { "bus-width", 4 }         // bus width (4-bit)
          }
        })
      }
    }
> 
> If there are big benefits to revert them,  i don't want to back them..during
> almost 6 years, never use it..

[Liming] Yeah, I could imagine it. Earlier the multi-slot didn't work well at all.
We debug it on HW emulation to figure it out. The changes are not big though. 
We have customers asking for it. It'll be very helpful to re-enable the multi-card support.

> 
> >
> >>
> >> The second part (patches 8-9) fixes the DesignWare multi-card support
> >> according to the dw-mmc databook (synnopsys: DesignWare Cores
> Mobile
> >> Storage Host Databook, 2.70a). It has changes to set the card number
> >> into the CMD register to multiplex requests to different cards when
> >> working in SD_MMC_CEATA mode, set the CTYPE / CLKENA / CDTHRCTL
> >> registers properly according to the spec, and parse the per-card
> >> configuration to match the Linux Documentation
> >> (bindings/mmc/synopsys-dw-mshc.txt).
> 
> the second part seems that it's only support since v2.70a..?

[Liming] This one is the spec I used as reference for all the changes and testing.
I didn't go through previous versions due to the limitation of testing environment I have.
As you mentioned, there is no multi-card usage earlier and this SoC is probably the first
product to use it in real-world. So adding a version check seems safe (so it won't
unnecessarily break anything just in case) . Any suggestions?

> 
> >
> > Havn'e check the databook for details yet, but I think it's ok to re-introduce
> multi-slot support if a real user benefits from it. But you need a new patch to
> silent the log "num-slots property not found, assuming 1 slot is available" as
> we removed all the num-slots from DT at that time.
> >
> >
> >>
> >> Liming Sun (9):
> >>    Revert "Documentation: dw-mshc: deprecate num-slots"
> >>    Revert "mmc: dw_mmc: remove the unnecessary slot variable"
> >>    Revert "mmc: dw_mmc: use the 'slot' instead of 'cur_slot'"
> >>    Revert "mmc: dw_mmc: remove the 'id' arguments about functions
> >>      relevant to slot"
> >>    Revert "mmc: dw_mmc: change the array of slots"
> >>    Revert "mmc: dw_mmc: remove the loop about finding slots"
> >>    Revert "mmc: dw_mmc: deprecated the "num-slots" property"
> >>    mmc: dw_mmc: Support two SD_MMC_CE-ATA cards
> >>    mmc: dw_mmc: Parse slot-specific configuration
> >>
> >>   .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  16 +-
> >>   drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
> >>   drivers/mmc/host/dw_mmc.c                          | 277 ++++++++++++++++----
> -
> >>   drivers/mmc/host/dw_mmc.h                          |  17 +-
> >>   4 files changed, 236 insertions(+), 78 deletions(-)
> >>
> >
> >
> >
> >
