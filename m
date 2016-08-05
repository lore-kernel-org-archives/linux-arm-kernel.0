From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 4 Aug 2016 17:57:48 -0700
Subject: [PATCH 2/3] regulator: qcom_smd: Fix voltage ranges for pma8084
 ftsmps and pldo
In-Reply-To: <20160711223827.GA6053@hector.attlocal.net>
References: <20160711215009.4519-1-sboyd@codeaurora.org>
 <20160711215009.4519-3-sboyd@codeaurora.org>
 <20160711223827.GA6053@hector.attlocal.net>
Message-ID: <20160805005748.GC15690@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11, Andy Gross wrote:
> On Mon, Jul 11, 2016 at 02:50:08PM -0700, Stephen Boyd wrote:
> > The voltage ranges listed here are wrong. The pma8084 pldo
> > supports three different overlapping voltage ranges with
> > differing step sizes and the pma8084 ftsmps supports two. These
> > ranges can be seen in the "native" spmi regulator driver
> > (qcom_spmi-regulator.c) at pldo_ranges[] and ftsmps_ranges[]
> > respectively. Port these ranges over to the RPM SMD regulator
> > driver so that we list the appropriate set of supported voltages
> > on these types of regulators.
> > 
> > Cc: Andy Gross <andy.gross@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Fixes: ee01d0c91ef1 ("regulator: qcom-smd: Add support for PMA8084")
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> <snip>
> 
> >  static const struct regulator_desc pma8084_pldo = {
> >  	.linear_ranges = (struct regulator_linear_range[]) {
> > -		REGULATOR_LINEAR_RANGE(750000,  0,  30, 25000),
> > -		REGULATOR_LINEAR_RANGE(1500000, 31, 99, 50000),
> > +		REGULATOR_LINEAR_RANGE( 750000,  0,  63, 12500),
> 
> It was my understanding that the PMOS ldos only support 25mV and 50mV
> incremements.
> 

Unfortunately that isn't true. It also supports 12.5mV steps for
the lower voltage ranges.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
