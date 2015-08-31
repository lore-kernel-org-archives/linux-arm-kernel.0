From: jonmason@broadcom.com (Jon Mason)
Date: Mon, 31 Aug 2015 15:44:04 -0400
Subject: [PATCH v3 2/5] ARM: NSP: add minimal Northstar Plus device tree
In-Reply-To: <55E3FFB5.6090703@broadcom.com>
References: <1440805644-18241-1-git-send-email-jonmason@broadcom.com>
 <55E0FAC4.2040108@broadcom.com>
 <20150831022417.GA27066@broadcom.com>
 <55E3FFB5.6090703@broadcom.com>
Message-ID: <20150831194404.GA28848@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 31, 2015 at 12:18:13AM -0700, Ray Jui wrote:
> 
> 
> On 8/30/2015 7:24 PM, Jon Mason wrote:
> > On Fri, Aug 28, 2015 at 05:20:20PM -0700, Ray Jui wrote:
> >>
> >>
> >> On 8/28/2015 4:47 PM, Jon Mason wrote:
> >>> Add a very minimalistic set of Northstar Plus Device Tree files which
> >>> describes the SoC and the BCM958625 implementation.  The perpherials
> >>> described are:
> >>>
> >>> ARM Cortex A9 CPU
> >>> 2 8250 UARTs
> >>> ARM GIC
> >>> PL310 L2 Cache
> >>> ARM A9 Global timer
> >>>
> >>> Signed-off-by: Kapil Hali <kapilh@broadcom.com>
> >>> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> >>> ---
> >>>  arch/arm/boot/dts/Makefile       |   2 +
> >>>  arch/arm/boot/dts/bcm-nsp.dtsi   | 120 +++++++++++++++++++++++++++++++++++++++
> >>>  arch/arm/boot/dts/bcm958625k.dts |  57 +++++++++++++++++++
> >>>  3 files changed, 179 insertions(+)
> >>>  create mode 100644 arch/arm/boot/dts/bcm-nsp.dtsi
> >>>  create mode 100644 arch/arm/boot/dts/bcm958625k.dts
> >>>
> >>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >>> index 246473a..adb5732 100644
> >>> --- a/arch/arm/boot/dts/Makefile
> >>> +++ b/arch/arm/boot/dts/Makefile
> >>> @@ -82,6 +82,8 @@ dtb-$(CONFIG_ARCH_BCM_CYGNUS) += \
> >>>  dtb-$(CONFIG_ARCH_BCM_MOBILE) += \
> >>>  	bcm28155-ap.dtb \
> >>>  	bcm21664-garnet.dtb
> >>> +dtb-$(CONFIG_ARCH_BCM_NSP) += \
> >>> +	bcm958625k.dtb
> >>>  dtb-$(CONFIG_ARCH_BERLIN) += \
> >>>  	berlin2-sony-nsz-gs7.dtb \
> >>>  	berlin2cd-google-chromecast.dtb \
> >>> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
> >>> new file mode 100644
> >>> index 0000000..f5f494f
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
> >>> @@ -0,0 +1,120 @@
> >>> +/*
> >>> + *  BSD LICENSE
> >>> + *
> >>> + *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
> >>> + *
> >>> + *  Redistribution and use in source and binary forms, with or without
> >>> + *  modification, are permitted provided that the following conditions
> >>> + *  are met:
> >>> + *
> >>> + *    * Redistributions of source code must retain the above copyright
> >>> + *      notice, this list of conditions and the following disclaimer.
> >>> + *    * Redistributions in binary form must reproduce the above copyright
> >>> + *      notice, this list of conditions and the following disclaimer in
> >>> + *      the documentation and/or other materials provided with the
> >>> + *      distribution.
> >>> + *    * Neither the name of Broadcom Corporation nor the names of its
> >>> + *      contributors may be used to endorse or promote products derived
> >>> + *      from this software without specific prior written permission.
> >>> + *
> >>> + *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> >>> + *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> >>> + *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> >>> + *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> >>> + *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> >>> + *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> >>> + *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> >>> + *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> >>> + *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> >>> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> >>> + *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> >>> + */
> >>> +
> >>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >>> +#include <dt-bindings/interrupt-controller/irq.h>
> >>> +
> >>> +#include "skeleton.dtsi"
> >>> +
> >>> +/ {
> >>> +	compatible = "brcm,nsp";
> >>> +	model = "Broadcom Northstar Plus SoC";
> >>> +	interrupt-parent = <&gic>;
> >>> +
> >>> +	mpcore {
> >>> +		compatible = "simple-bus";
> >>> +		ranges = <0x00000000 0x19020000 0x00003000>;
> >>> +		#address-cells = <1>;
> >>> +		#size-cells = <1>;
> >>> +
> >>> +		cpus {
> >>> +			#address-cells = <1>;
> >>> +			#size-cells = <0>;
> >>> +
> >>> +			cpu at 0 {
> >>> +				device_type = "cpu";
> >>> +				compatible = "arm,cortex-a9";
> >>> +				next-level-cache = <&L2>;
> >>> +				reg = <0x0>;
> >>> +			};
> >>> +		};
> >>> +
> >>> +		L2: l2-cache {
> >>> +			compatible = "arm,pl310-cache";
> >>> +			reg = <0x2000 0x1000>;
> >>> +			cache-unified;
> >>> +			cache-level = <2>;
> >>> +		};
> >>> +
> >>> +		gic: interrupt-controller at 19021000 {
> >>> +			compatible = "arm,cortex-a9-gic";
> >>> +			#interrupt-cells = <3>;
> >>> +			#address-cells = <0>;
> >>> +			interrupt-controller;
> >>> +			reg = <0x1000 0x1000>,
> >>> +			      <0x0100 0x100>;
> >>> +		};
> >>> +
> >>> +		timer at 19020200 {
> >>> +			compatible = "arm,cortex-a9-global-timer";
> >>> +			reg = <0x0200 0x100>;
> >>> +			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
> >>> +			clocks = <&periph_clk>;
> >>> +		};
> >>> +	};
> >>> +
> >>> +	clocks {
> >>> +		#address-cells = <1>;
> >>> +		#size-cells = <1>;
> >>> +		ranges;
> >>> +
> >>> +		periph_clk: periph_clk {
> >>> +			compatible = "fixed-clock";
> >>> +			#clock-cells = <0>;
> >>> +			clock-frequency = <500000000>;
> >>> +		};
> >>> +	};
> >>> +
> >>> +	apb {
> >>> +		compatible = "arm,amba-bus", "simple-bus";
> >>
> >> Should "arm,amba-bus" has a separate bus node with AMBA compatible
> >> devices declared in there (e.g, pl330, spi-pl022, and etc.) in the
> >> future after they are brought up? To my best knowledge, "ns16550a" UART
> >> is NOT an AMBA compatible device.
> > 
> > APB is an AMBA bus, so this part is accurate.  The block diagram of
> > the SoC has the UARTs (and other perpherials) hanging off of the APB
> > bus.  So, this organization follows the block diagram.
> 
> Okay so the "apb" node can be used for amba compatible devices
> (arm,amba-bus) and/or simple platform devices (simple-bus). I guess
> that's fine and I now see that there are some other dtsi also doing it
> this way.
> 
> > While the
> > UART drivers are not AMBA aware, there appears to be no issues with
> > this layout (as the HW/drivers come up without issue). Unless there
> > is an unforeseen issue with having non-AMBA aware devices on the DT
> > AMBA bus, I would think it best to organize it to match the block
> > disgram.
> > 
> 
> UART runs fine because you also have "simple-bus" listed as the
> compatible string so uart is populated as standard platform device.
> 
> >>> +		interrupt-parent = <&gic>;
> >>> +		ranges = <0x00000000 0x18000000 0x00001000>;
> >>
> >> Does the 'apb' bus mean to cover all peripherals connected through APB?
> >> If so, the size is only 0x1000 and that seems to be too small...
> > 
> > This is all that is currently needed.  I was planning on expanding it
> > as I added more devices.
> 
> Sure.
> 
> I haven't checked the datahsheet but based on the layout (which seems
> quite similar to Cygnus), I assume the range for these devices should be
> 0x18000000 - 0x18ffffff? Just want to make sure there are no other
> devices come before 0x18000000 so you don't need to change all these reg
> offsets in the future.

Based on the devices listed in the block diagram (and not including
those on the AXI bus):
i2c 0x18038000
spi 0x18027200
gpio 0x18000060
pwm 0x18031000
wdt 0x18039000

and a few others.  

Looking at the sources, all the ARM IP is 0x19000000 and the rest is
0x18000000.  The only part that is a little harry is the clocks, which
have BCM and ARM (which causes the addresses to be both 0x19000000 and
0x18000000).  But, we can handle that when we upstream that part (which
should be very soon).

Thanks,
Jon

> > 
> > Thanks,
> > Jon
> > 
> 
> Thanks,
> 
> Ray
