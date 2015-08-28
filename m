From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 28 Aug 2015 14:37:19 +0800
Subject: [PATCH v1 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <20150827163108.GA31748@leverpostej>
References: <20150824114903.GT10728@bivouac.eciton.net>
 <1440490427.10987.29.camel@linaro.org>
 <20150825094630.GU10728@bivouac.eciton.net>
 <1440497710.10987.42.camel@linaro.org>
 <20150825104256.GB13471@leverpostej>
 <1440510194.10987.52.camel@linaro.org>
 <20150825160030.GA3774@leoy-linaro>
 <1440552341.10987.53.camel@linaro.org>
 <20150826065950.GB19594@leoy-linaro>
 <20150827163108.GA31748@leverpostej>
Message-ID: <20150828063719.GA22886@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Aug 27, 2015 at 05:31:09PM +0100, Mark Rutland wrote:
> On Wed, Aug 26, 2015 at 07:59:50AM +0100, Leo Yan wrote:
> > Hi Haojian,
> > 
> > On Wed, Aug 26, 2015 at 09:25:41AM +0800, Haojian Zhuang wrote:
> > > On Wed, 2015-08-26 at 00:00 +0800, Leo Yan wrote:
> > > > On Tue, Aug 25, 2015 at 09:43:14PM +0800, Haojian Zhuang wrote:
> > > > > On Tue, 2015-08-25 at 11:42 +0100, Mark Rutland wrote:
> > > > > > > > Are you then going to hack GRUB, release a special HiKey version of
> > > > > > > > GRUB, not support any other versions, and still can your firmware
> > > > > > > > UEFI?
> > > > > > > 
> > > > > > > I don't need to hack GRUB at all.
> > > > > > 
> > > > > > Then it is working for you by pure chance alone.
> > > > > > 
> > > > > > Please listen to the advice you are being given here; we're trying to
> > > > > > ensure that your platform functions (and continues to function) as best
> > > > > > it can.
> > > > > 
> > > > > Since we discussed a lot on this, let's make a conclusion on it.
> > > > > 
> > > > > 1. UEFI could append the reserved buffer in it's memory mapping.
> > > > > 2. These reserved buffer must be declared in DT, since we also need to
> > > > >    support non-UEFI (uboot) at the same time.
> > > > > 3. Mailbox node should reference reserved buffer by phandle in DT. Then
> > > > >    map the buffer as non-cacheable in driver.
> > > > > 4. These reserved buffer must use "no-map" property since it should be
> > > > >    non-cacheable in driver.
> > > > 
> > > > For more specific discussion for DTS, i list two options at here;
> > > > 
> > > > - Option 1: just simply reserve memory regions through memory node,
> > > >   and mailbox node will directly use the buffer through reg ranges;
> > > > 
> > > > - Option 2: use reserved-memory and mailbox node will refer phandle
> > > >   of reserved-memory;
> > > > 
> > > > These two options both can work well with UEFI and Uboot, but option 1
> > > > is more simple and straightforward; so i personally prefer it. But
> > > > look forwarding your guys' suggestion.
> > > > 
> > > > Option 1:
> > > > 
> > > > 	memory at 0 {
> > > > 		device_type = "memory";
> > > > 		reg = <0x00000000 0x00000000 0x00000000 0x05e00000>,
> > > > 		      <0x00000000 0x05f00000 0x00000000 0x00eff000>,
> > > > 		      <0x00000000 0x06e00000 0x00000000 0x0060f000>,
> > > > 		      <0x00000000 0x07410000 0x00000000 0x38bf0000>;
> > > > 	};
> > > > 
> > > >         [...]
> > > > 
> > > > 	mailbox: mailbox at f7510000 {
> > > > 		#mbox-cells = <1>;
> > > > 		compatible = "hisilicon,hi6220-mbox";
> > > > 		reg = <0x0 0xf7510000 0x0 0x1000>, /* IPC_S */
> > > > 		      <0x0 0x06dff800 0x0 0x0800>; /* Mailbox buffer */
> > > > 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> > > > 	};
> > > > 
> > > > Option 2:
> > > > 
> > > > 	memory at 0 {
> > > > 		device_type = "memory";
> > > > 		reg = <0x0 0x0 0x0 0x40000000>;
> > > > 	};
> > > > 
> > > > 	reserved-memory {
> > > > 		#address-cells = <2>;
> > > > 		#size-cells = <2>;
> > > > 		ranges;
> > > > 
> > > > 		mcu_reserved: mcu_reserved at 06dff000 {
> > > > 			no-map;
> > > > 			reg = <0x0 0x06dff000 0x0 0x00001000>,	/* MCU mailbox buffer */
> > > > 			      <0x0 0x05e00000 0x0 0x00100000>,	/* MCU firmware buffer */
> > > > 			      <0x0 0x0740f000 0x0 0x00001000>;	/* MCU firmware section */
> > > > 		};
> > > > 	};
> > > > 
> > > >         [...]
> > > > 
> > > > 	mailbox: mailbox at f7510000 {
> > > > 		#mbox-cells = <1>;
> > > > 		compatible = "hisilicon,hi6220-mbox";
> > > > 		reg = <0x0 0xf7510000 0x0 0x1000>; /* IPC_S */
> > > > 		memory-region = <&mcu_reserved>;   /* Mailbox buffer */
> > > > 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> > > > 	};
> > > 
> > > I prefer the second one. From my view, memory node should only describe
> > > the hardware information of memory.
> > 
> > Yes, option 2 will be more simple for memory node.
> > 
> > But option 2 also will introduce complexity for mailbox node, due mailbox
> > driver need use property "reg" and "memory-region" to sepeately depict
> > the regions for mailbox's ipc and slots. If later mailbox is designed to
> > use SRAM for both ipc and slots, then it will no matter with DDR anymore,
> > in this case option 1 will easily switch to support it.
> > 
> > Another question is a general question: for Linux kernel, which is the
> > best method to reserve memory regions? According to previous discussion,
> > we can use /memory/ node or /reseved-memory/ node to reserve memory
> > regions.
> 
> If the memory is truly reserved for a purpose and cannot be used for
> anything else, I don't think it should be in the memory node at all, and
> should be carved out. That aligns with what you'd do in UEFI (either not
> listing the region in the memory map, or listing it with attributes such
> that it may not be mapped and/or used).
> 
> I don't see much of a reason for /memreserve/, as it can cause issues
> (by allowing the OS to map the region with cacheable attributes), and is
> not as rigorously specified for ARM as it is for Power in ePAPR.
> 
> I understand that reserved-memory is for carving out (potentially
> reusable) memory pools for devices or other special uses (perhaps a
> panic log). Usually such memory may also be used by the kernel for its
> own purposes if not presently required by the device.
> 
> Having an entry in reserved-memory does not necessitate the region also
> appears in memory nodes, and if a region cannot be used by an OS (or
> other software) for other purposes, I would not expect it to be describe
> in any memory node. That will prevent other software (e.g. bootloaders)
> from erroneously using the memory.
> 
> If you have a region described with no-map, I would expect that this
> doesn't exist in any memory node or the UEFI memory map, and is only
> under reserved-memory so it may be referred to by phandle in a
> consistent manner.
> 
> > when review Juno's dts, i also see there have reserved 16MB DDR for secure
> > world. If so, looks like /reserved-memory/ node is unnecessary. if have some
> > specific scenarios will we use reserved-memory node to help reserve memory
> > regions?
> 
> I'd expect shared DMA pools to appear in reserved-memory. The OS can
> choose to use these or ignore them if it chooses (or is otherwise forced
> to, e.g. were it loaded over one).

Thanks a lot for detailed explain; it's quite clear now.

Thanks,
Leo Yan
