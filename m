From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 25 Aug 2015 22:04:50 +0800
Subject: [PATCH v1 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <55DC532C.3020005@arm.com>
References: <1439977055-1747-1-git-send-email-leo.yan@linaro.org>
 <1439977055-1747-4-git-send-email-leo.yan@linaro.org>
 <55DC532C.3020005@arm.com>
Message-ID: <20150825140450.GB28262@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Tue, Aug 25, 2015 at 12:36:12PM +0100, Sudeep Holla wrote:
> 
> 
> On 19/08/15 10:37, Leo Yan wrote:
> >On Hi6220, below memory regions in DDR have specific purpose:
> >
> >   0x05e0,0000 - 0x05ef,ffff: For MCU firmware using at runtime;
> >   0x0740,f000 - 0x0740,ffff: For MCU firmware's section;
> >   0x06df,f000 - 0x06df,ffff: For mailbox message data.
> >
> 
> Unless I am reading the DTS file completely wrong, I don't think the
> above memory regions are in DDR as per the memory node.

i'm not sure if understand correctly for your question; Hikey board
has DDR 1GB at 0x0, but there have some memory regions are used for MCU.

So this patch is to reserve these memory regions so that make sure
kernel will not map and allocate them.

Will remove these memory regions from memory node in next version.

> >This patch reserves these memory regions and add device node for
> >mailbox in dts.
> >
> >Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >---
> >  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 20 +++++++++++++++++---
> >  arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |  8 ++++++++
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> >
> >diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> >index e36a539..d5470d3 100644
> >--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> >+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> >@@ -7,9 +7,6 @@
> >
> >  /dts-v1/;
> >
> >-/*Reserved 1MB memory for MCU*/
> >-/memreserve/ 0x05e00000 0x00100000;
> >-
> >  #include "hi6220.dtsi"
> >
> >  / {
> >@@ -28,4 +25,21 @@
> >  		device_type = "memory";
> >  		reg = <0x0 0x0 0x0 0x40000000>;
> >  	};
> 
> I have no access to the spec, but I read this as 1GB RAM @0x0
> Unless this entry is completely wrong, what your commit log claims is
> incorrect. If this entry is wrong I wonder how is it booting with this
> DT then.

Do you mean should remove all reserved memory regions from memory
node? Will submit next version's patch for this.

Kernel can boot successfully on Hikey with this patch [1].

[1] https://github.com/96boards/linux

> >+
> >+	reserved-memory {
> >+		#address-cells = <2>;
> >+		#size-cells = <2>;
> >+		ranges;
> >+
> >+		mcu-buf at 05e00000 {
> >+			no-map;
> >+			reg = <0x0 0x05e00000 0x0 0x00100000>,	/* MCU firmware buffer */
> >+			      <0x0 0x0740f000 0x0 0x00001000>;	/* MCU firmware section */
> 
> So I don't see how can this be part of DDR ? Or at-least part of DDR
> that's mapped by kernel ?

Here use reserved-memory node to remove these regions from memblock
during kernel's boot up; kernel also will not map for them with
property "no-map".

I think this is the same question which have been brought up by Mark
in his early mail and suggested to use UEFI to do this.

Thanks,
Leo Yan
