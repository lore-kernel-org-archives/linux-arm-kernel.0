From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Oct 2014 11:09:19 +0100
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <20141009032130.GB2690@darkstar.nay.redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141001151947.GB14991@redhat.com>
 <1412370971.32313.30.camel@smoke>
 <20141007134006.GC27464@redhat.com>
 <20141008094258.GG27216@leverpostej>
 <20141009032130.GB2690@darkstar.nay.redhat.com>
Message-ID: <20141009100919.GF3869@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 04:21:30AM +0100, Dave Young wrote:
> On 10/08/14 at 10:42am, Mark Rutland wrote:
> > [Cc'ing the arm efi guys]
> > 
> > On Tue, Oct 07, 2014 at 02:40:06PM +0100, Vivek Goyal wrote:
> > > On Fri, Oct 03, 2014 at 02:16:11PM -0700, Geoff Levand wrote:
> > > > Hi,
> > > > 
> > > > On Wed, 2014-10-01 at 11:19 -0400, Vivek Goyal wrote:
> > > > > On Thu, Sep 25, 2014 at 12:23:26AM +0000, Geoff Levand wrote:
> > > > > > Hi All,
> > > > > > 
> > > > > > This series adds the core support for kexec re-boots on arm64.  I have tested
> > > > > > with the ARM VE fast model using various kernel config options for both the
> > > > > > first and second stage kernels.
> > > > > 
> > > > > Does this patch series work with kexec on UEFI machines?
> > > > 
> > > > I have not done much more than some simple re-boot tests using the
> > > > base model (FVP_Base_AEMv8A-AEMv8A) and the Linaro 14.08 efi build,
> > > > but yes, it should work.
> > > 
> > > [CC Dave Young ]
> > > 
> > > I have not looked at the user space patches but are you preparing efi
> > > setup data and passing all the runtime map information to second kernel.
> > > 
> > > I am hoping on arm64 we have the CONFIG_EFI_RUNTIME_MAP=y and it works
> > > well.
> > 
> > From a quick look at mainline that config option just gates exposing
> > that info under sysfs, and we never call efi_runtime_map_setup on arm64.
> > I gues the x86 kexec tool parses that and sets up some data structure?
> > 
> > For arm64 we have runtime map information in the initial DTB, and this
> > should have been copied into the DTB we pass to the second kernel. See
> > Documentation/arm/uefi.txt and drivers/firmware/efi/libstub/fdt.c.
> > 
> > Is that sufficient?
> 
> That will be sufficient for runtime maps, but several phys addresses need to be
> saved: /sys/firmware/efi/{fw_vendor,runtime,config_table}
> 
> From uefi spec these addresses are updated to virtual addresses after entering
> virtual mode.

Ouch. That sounds painful.

I'd prefer to not have to duplicate these in the DTB if we can. Given we
should have the memmmap with the virtual<->physical mappings, could we
not do a lookup there before early dereferences if we happen to already
be in virtual mode?

> Though it should work without the runtime map exporting to sysfs, It's not bad
> to export them, it's good to have for debugging purpose and it will be consistant
> across different arches.

Exporting the sysfs entries makes sense for debug, but I'd very much
prefer that it were not our default solution for passing the maps to the
next kernel.

Thanks,
Mark.
