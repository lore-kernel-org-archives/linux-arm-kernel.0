From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Sep 2014 16:56:55 +0100
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <9081864.6l1AHRQ5bg@wuerfel>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <11626142.L1WDF72bmp@wuerfel>
 <d856a7c55a0949cd918411f3f834bbe3@BN1PR03MB220.namprd03.prod.outlook.com>
 <9081864.6l1AHRQ5bg@wuerfel>
Message-ID: <20140903155654.GK3127@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Sep 03, 2014 at 04:39:07PM +0100, Arnd Bergmann wrote:
> On Wednesday 03 September 2014 15:36:44 bhupesh.sharma at freescale.com wrote:
> > > On Wednesday 03 September 2014 20:43:08 Bhupesh Sharma wrote:
> > > >
> > > > In this version, the enable-method for the CPU nodes is left for the
> > > > bootloader (u-boot or UEFI) to patch-up. This DTS has been tested for
> > > > PSCI v0.2 CPU_ON method (and corresponding secondary boot) using the
> > > > following ARMv8 u-boot patches:
> > > 
> > > What would be a reason for using something other than PSCI?
> > > 
> > 
> > We had originally gone ahead and implemented spin-table release method in ARMv8 u-boot
> > (see [1]) (the v3 of that patchset is still in works), but we have since been pointed towards
> > PSCI by Mark and Catalin, so we have implemented PSCI in ARMv8 u-boot and the v2 and v3
> > of the DTS patchset have been tested with both the spin-table and PSCI approaches.
> > 
> > [1] http://lists.denx.de/pipermail/u-boot/2014-June/182759.html
> > 
> 
> Would it be possible then to just mandate PSCI for the upstream-supported
> version?

I had asked for the FW to patch up the enable-method (and omit this in
the in-kernel dts) as this is something that may vary over the lifetime
of the SoC independently from the fixed HW properties (it's a firmware
property really).

Personally I'd like to see such things patched by the firmware/loader
where possible (ideally with some way of switching said patching off if
we really know better). We already expect the loader to patch memory
nodes where memory can be dynamically populated. 

I don't see why we should tie the in-kernel dts to a particular firmware
revision. Having such properties in the in-kernel dts is only going to
mislead. The arm64 boot-wrapper patches dts for PSCI, but for
compatibility with old wrappers the in-kernel dts must forever say
spin-table is used to bring up secondaries.

Mark.
