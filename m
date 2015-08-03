From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 03 Aug 2015 12:46:33 +0100
Subject: [PATCH v6 6/8] arm64: dts: add SRAM, MHU mailbox and SCPI
 support on Juno
In-Reply-To: <20150803112353.GV20890@e106497-lin.cambridge.arm.com>
References: <1438364591-1144-1-git-send-email-sudeep.holla@arm.com>
 <1438364591-1144-7-git-send-email-sudeep.holla@arm.com>
 <20150803112353.GV20890@e106497-lin.cambridge.arm.com>
Message-ID: <1438602393.5218.3.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-08-03 at 12:23 +0100, Liviu Dudau wrote:
> On Fri, Jul 31, 2015 at 06:43:09PM +0100, Sudeep Holla wrote:
> > This patch adds support for the MHU mailbox peripheral used on Juno by
> > application processors to communicate with remote SCP handling most of
> > the CPU/system power management. It also adds the SRAM reserving the
> > shared memory and SCPI message protocol using that shared memory.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
> > ---
> >  arch/arm64/boot/dts/arm/juno-base.dtsi | 54 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> > index e3ee96036eca..c624208edef6 100644
> > --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> > +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
[...]
> > +	scpi {
> > +		compatible = "arm,scpi";
> > +		mboxes = <&mailbox 1>;
> > +		shmem = <&cpu_scp_hpri>;
> > +
> > +		clocks {
> > +			compatible = "arm,scpi-clocks";
> > +
> > +			scpi_dvfs: scpi_clocks at 0 {
> > +				compatible = "arm,scpi-dvfs-clocks";
> > +				#clock-cells = <1>;
> > +				clock-indices = <0>, <1>, <2>;
> > +				clock-output-names = "atlclk", "aplclk","gpuclk";
> > +			};
> > +			scpi_clk: scpi_clocks at 3 {
> > +				compatible = "arm,scpi-variable-clocks";
> > +				#clock-cells = <1>;
> > +				clock-indices = <3>, <4>;
> > +				clock-output-names = "pxlclk0", "pxlclk1";
> > +			};
> > +		};
> > +	};
> > +
> 
> Sorry for noticing this after the ACK, is there any reason why the scpi node is not inside
> the juno-clocks.dtsi file?

Because SCPI is not just about clocks? Just happens that these first
patches are but there's thermal sensors and other things as well.

-- 
Tixy
