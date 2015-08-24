From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 24 Aug 2015 18:19:56 +0800
Subject: [PATCH v1 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <20150824095144.GA7139@leverpostej>
References: <1439977055-1747-1-git-send-email-leo.yan@linaro.org>
 <1439977055-1747-4-git-send-email-leo.yan@linaro.org>
 <20150821184059.GB2000@svinekod> <20150824091845.GA28290@leoy-linaro>
 <20150824095144.GA7139@leverpostej>
Message-ID: <1440411596.3517.12.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-08-24 at 10:51 +0100, Mark Rutland wrote:
> On Mon, Aug 24, 2015 at 10:18:45AM +0100, Leo Yan wrote:
> > Hi Mark,
> > 
> > On Fri, Aug 21, 2015 at 07:40:59PM +0100, Mark Rutland wrote:
> > > On Wed, Aug 19, 2015 at 10:37:35AM +0100, Leo Yan wrote:
> > > > On Hi6220, below memory regions in DDR have specific purpose:
> > > > 
> > > >   0x05e0,0000 - 0x05ef,ffff: For MCU firmware using at runtime;
> > > >   0x0740,f000 - 0x0740,ffff: For MCU firmware's section;
> > > >   0x06df,f000 - 0x06df,ffff: For mailbox message data.
> > > > 
> > > > This patch reserves these memory regions and add device node for
> > > > mailbox in dts.
> > > > 
> > > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 20 +++++++++++++++++---
> > > >  arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |  8 ++++++++
> > > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> > > > index e36a539..d5470d3 100644
> > > > --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> > > > +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> > > > @@ -7,9 +7,6 @@
> > > >  
> > > >  /dts-v1/;
> > > >  
> > > > -/*Reserved 1MB memory for MCU*/
> > > > -/memreserve/ 0x05e00000 0x00100000;
> > > > -
> > > >  #include "hi6220.dtsi"
> > > >  
> > > >  / {
> > > > @@ -28,4 +25,21 @@
> > > >  		device_type = "memory";
> > > >  		reg = <0x0 0x0 0x0 0x40000000>;
> > > >  	};
> > > > +
> > > > +	reserved-memory {
> > > > +		#address-cells = <2>;
> > > > +		#size-cells = <2>;
> > > > +		ranges;
> > > > +
> > > > +		mcu-buf at 05e00000 {
> > > > +			no-map;
> > > > +			reg = <0x0 0x05e00000 0x0 0x00100000>,	/* MCU firmware buffer */
> > > > +			      <0x0 0x0740f000 0x0 0x00001000>;	/* MCU firmware section */
> > > > +		};
> > > > +
> > > > +		mbox-buf at 06dff000 {
> > > > +			no-map;
> > > > +			reg = <0x0 0x06dff000 0x0 0x00001000>;	/* Mailbox message buf */
> > > > +		};
> > > > +	};
> > > 
> > > As far as I can see, it would be simpler to simply carve these out of the
> > > memory node.
> > > 
> > > I don't see why you need reserved-memory here, given you're not referring to
> > > these regions by phandle anyway.
> > 
> > - Now we have enabled EFI_STUB, so the memory node will be removed in
> >   kernel:
> >     efi_entry()
> >       \-> allocate_new_fdt_and_exit_boot()
> >             \-> update_fdt();
> > 
> >   Finally in kernel it cannot use memory node to carve out reseved
> >   memory regions.
> > 
> > - On the other hand, DTS's the memory node is to "describes the
> >   physical memory layout for the system"; so it's better to use it only
> >   to describe the hardware info for memory. We can use reserved-memory
> >   to help manage the memory regions which are reserved from software
> >   perspective.
> 
> The fact that you have no-map means that the memory should not be
> described to the kernel as mappable in the first place. It's wrong to
> place such memory in the memory node, even if listed in reserved-memory.
> 
> If your EFI memory map describes the memory as mappable, it is wrong.

When kernel is working, kernel will create its own page table based on
UEFI memory map. Since it's reserved in DTS file as Leo's patch, it'll
be moved to reserved memblock. Why is it wrong?

In the second, UEFI is firmware. When it's stable, nobody should change
it without any reason. These reserved memory are used in mailbox driver.
Look. It's driver, so it could be changed at any time. Why do you want
to UEFI knowing this memory range? Do you hope UEFI to change when
mailbox driver is changed?

> 
> > According to upper info, we still need to use reserved-memory node to
> > depict the reserved memory regions. i have no knowledge about EFI_STUB,
> > so please confirm or correct as needed.
> 
> If the memory shouldn't be mapped, it should neither be in the memory
> node nor EFI memory map (with attributes allowing it to be mapped) to
> begin with.

As I said above, kernel will create its own page table. When kernel's
page table is working, UEFI's page table is destroying. So the memory
won't be mapped twice at the same time. What's wrong?
> 
> As far as I can see you do not need to use reserved-memory.

1. Are we talking on the same thing? Leo already mentioned that all
memory node in DTB will be destroyed by kernel when EFI_STUB is enabled
on arm. Did you read the source code after his reply?
And you suggested that Leo to use discrete memory region in DTB. It is
really wrong. Kernel only gets memory map information from UEFI, not
DTB.

2. The working flow is in below.
   a. Kernel gets memory map information from UEFI.
   b. Kernel loads the memory reserved information from DTB.

3. Do you mean the reserved-memory is totally wrong? If it's wrong,
please submit patches to remove all reserved-memory in linux kernel
first.

4. Again and again. Memory node should be only used to describe the
RAM information.
