From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 22 Jul 2015 17:06:25 +0100
Subject: [PATCH v4 6/8] arm64: dts: add SRAM, MHU mailbox and SCPI
 support on Juno
In-Reply-To: <55AFB96E.1050406@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-7-git-send-email-sudeep.holla@arm.com>
 <20150722132809.GG14923@e106497-lin.cambridge.arm.com>
 <55AFB96E.1050406@arm.com>
Message-ID: <20150722160625.GJ14923@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 04:40:30PM +0100, Sudeep Holla wrote:
> 
> 
> On 22/07/15 14:28, Liviu Dudau wrote:
> > On Mon, Jun 08, 2015 at 11:40:00AM +0100, Sudeep Holla wrote:
> >> This patch adds support for the MHU mailbox peripheral used on Juno by
> >> application processors to communicate with remote SCP handling most of
> >> the CPU/system power management. It also adds the SRAM reserving the
> >> shared memory and SCPI message protocol using that shared memory.
> >>
> >> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> >> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >> ---
> >>   arch/arm64/boot/dts/arm/juno-base.dtsi   | 31 +++++++++++++++++++++++++++++++
> >>   arch/arm64/boot/dts/arm/juno-clocks.dtsi | 23 +++++++++++++++++++++++
> >>   2 files changed, 54 insertions(+)
> >>
> 
> [..]
> 
> >> diff --git a/arch/arm64/boot/dts/arm/juno-clocks.dtsi b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> >> index 25352ed943e6..64af7370815a 100644
> >> --- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> >> +++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> >> @@ -42,3 +42,26 @@
> >>   		clock-frequency = <400000000>;
> >>   		clock-output-names = "faxi_clk";
> >>   	};
> >> +
> >> +	scpi {
> >> +		compatible = "arm,scpi";
> >> +		mboxes = <&mailbox 1>;
> >> +		shmem = <&cpu_scp_hpri>;
> >> +
> >> +		clocks {
> >> +			compatible = "arm,scpi-clocks";
> >> +
> >> +			scpi_dvfs: scpi_clocks at 0 {
> >> +				compatible = "arm,scpi-dvfs-clocks";
> >> +				#clock-cells = <1>;
> >> +				clock-indices = <0>, <1>, <2>;
> >> +				clock-output-names = "vbig", "vlittle", "vgpu";
> >> +			};
> >> +			scpi_clk: scpi_clocks at 3 {
> >> +				compatible = "arm,scpi-variable-clocks";
> >> +				#clock-cells = <1>;
> >> +				clock-indices = <3>, <4>;
> >
> > Subject to you addressing Mark's comments regarding the indices values (maybe choose
> > a different property to show the fact that the index is actually an SCPI index
> > rather than the clock's), you can add my
> >
> 
> I don't understand why we need to do that. I will anyway follow up on
> that thread.

Because indices are per clock node, i.e. spi_clk should have clock-indices = <0>, <1>.
Of course, you could have a gap in the indices, but that is both awkard and not clearly
explained in this documentation.

The index that you declare here is actually what you pass to SCPI. But the way the device
tree is presented it declares that there are two clock blocks, one for DVFS and one for
PXLCLK. As far as SCPI is concerned there is only one block of clocks, with 3 of them
having a discrete set of values, so we are at the intersection of two concepts.

BTW, for what is worth, the PXLCLK is not really that smooth in its coverage of the range.
It might have more accepted frequency values, but the way it is implemented it tends to
favour VESA clock values and falls back to a really slow algorithm to generate all other
values. Even so, it can fail to find the correct parameters for the PLLs so it will generate
a frequency that is different from the requested one.

Best regards,
Liviu


> 
> > Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> Thanks for all the ACKs.
> 
> Regards,
> Sudeep
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
