From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 May 2015 15:24:39 -0500
Subject: [PATCH 1/2] arm: boot: dts: am4372: add operating points
In-Reply-To: <554D18AB.6060901@ti.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
 <554D17F3.7090008@ti.com> <554D18AB.6060901@ti.com>
Message-ID: <20150508202439.GA25459@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 03:12:27PM -0500, Nishanth Menon wrote:
> On 05/08/2015 03:09 PM, Nishanth Menon wrote:
> > On 05/08/2015 02:57 PM, Felipe Balbi wrote:
> >> By adding operating points, cpufreq-dt has a
> >> chance of running and doing something useful.
> >>
> >> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> ---
> >>  arch/arm/boot/dts/am4372.dtsi | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> >> index c80a3e233792..ea1db20f64fc 100644
> >> --- a/arch/arm/boot/dts/am4372.dtsi
> >> +++ b/arch/arm/boot/dts/am4372.dtsi
> >> @@ -38,6 +38,15 @@
> >>  			clocks = <&dpll_mpu_ck>;
> >>  			clock-names = "cpu";
> >>  
> >> +			operating-points = <
> >> +				/* kHz		uV */
> >> +				1000000		1325000 /* OPP_NITRO */
> >> +				 800000		1260000 /* OPP_TURBO */
> >> +				 720000		1200000 /* OPP_120 */
> >> +				 600000		1100000 /* OPP_100 */
> >> +				 300000		 950000 /* OPP_50 */
> >> +			>;
> >> +
> >>  			clock-latency = <300000>; /* From omap-cpufreq driver */
> >>  		};
> >>  	};
> >>
> > which of these OPPs need AVS? which of these are dependent on Efuse bit
> > dependent?
> >
> 
> 
> You can use
> http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-3.14.y/arch/arm/mach-omap2/opp43xx_data.c
> for reference.

heh, why isn't that upstream yet ? Seems to be ready already. The point
is that as of now, u-boot will set maximum OPP it can find and, for
AM437x, that will be 800MHz or 1GHz depending on your board. 1GHz might
not be supported in all SoCs and letting that be used all the time is
likely going to reduce silicon lifetime.

At least allowing ondemand governor run, we will be mostly running at
300MHz and only jump to "invalid" OPPs under load which, granted, is
still not perfect, but better than running at 1GHz all the time, don't
you agree ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150508/84baa977/attachment.sig>
