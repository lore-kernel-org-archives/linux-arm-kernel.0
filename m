From: dyoung@redhat.com (Dave Young)
Date: Thu, 9 Oct 2014 11:21:30 +0800
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <20141008094258.GG27216@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141001151947.GB14991@redhat.com>
 <1412370971.32313.30.camel@smoke>
 <20141007134006.GC27464@redhat.com>
 <20141008094258.GG27216@leverpostej>
Message-ID: <20141009032130.GB2690@darkstar.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/14 at 10:42am, Mark Rutland wrote:
> [Cc'ing the arm efi guys]
> 
> On Tue, Oct 07, 2014 at 02:40:06PM +0100, Vivek Goyal wrote:
> > On Fri, Oct 03, 2014 at 02:16:11PM -0700, Geoff Levand wrote:
> > > Hi,
> > > 
> > > On Wed, 2014-10-01 at 11:19 -0400, Vivek Goyal wrote:
> > > > On Thu, Sep 25, 2014 at 12:23:26AM +0000, Geoff Levand wrote:
> > > > > Hi All,
> > > > > 
> > > > > This series adds the core support for kexec re-boots on arm64.  I have tested
> > > > > with the ARM VE fast model using various kernel config options for both the
> > > > > first and second stage kernels.
> > > > 
> > > > Does this patch series work with kexec on UEFI machines?
> > > 
> > > I have not done much more than some simple re-boot tests using the
> > > base model (FVP_Base_AEMv8A-AEMv8A) and the Linaro 14.08 efi build,
> > > but yes, it should work.
> > 
> > [CC Dave Young ]
> > 
> > I have not looked at the user space patches but are you preparing efi
> > setup data and passing all the runtime map information to second kernel.
> > 
> > I am hoping on arm64 we have the CONFIG_EFI_RUNTIME_MAP=y and it works
> > well.
> 
> From a quick look at mainline that config option just gates exposing
> that info under sysfs, and we never call efi_runtime_map_setup on arm64.
> I gues the x86 kexec tool parses that and sets up some data structure?
> 
> For arm64 we have runtime map information in the initial DTB, and this
> should have been copied into the DTB we pass to the second kernel. See
> Documentation/arm/uefi.txt and drivers/firmware/efi/libstub/fdt.c.
> 
> Is that sufficient?

That will be sufficient for runtime maps, but several phys addresses need to be
saved: /sys/firmware/efi/{fw_vendor,runtime,config_table}

>From uefi spec these addresses are updated to virtual addresses after entering
virtual mode.

Though it should work without the runtime map exporting to sysfs, It's not bad
to export them, it's good to have for debugging purpose and it will be consistant
across different arches.

Thanks
Dave
