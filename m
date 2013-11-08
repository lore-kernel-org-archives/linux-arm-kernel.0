From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 08 Nov 2013 10:10:37 +0100
Subject: [PATCH 03/11] devicetree: bindings: Document qcom,kpss-acc
In-Reply-To: <E034522B-A62C-40A4-800C-00D592AAEF47@codeaurora.org>
References: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
 <52792E78.4060600@codeaurora.org>
 <E034522B-A62C-40A4-800C-00D592AAEF47@codeaurora.org>
Message-ID: <1986087.9ItmqCgipJ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 of November 2013 11:51:07 Kumar Gala wrote:
> On Nov 5, 2013, at 11:44 AM, Stephen Boyd wrote:
> > On 11/05/13 09:13, Kumar Gala wrote:
> >> On Nov 1, 2013, at 5:08 PM, Stephen Boyd wrote:
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> >>> b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt new
> >>> file mode 100644
> >>> index 0000000..ed4a9c8
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> >>> @@ -0,0 +1,21 @@
> >>> +* Krait Processor Sub-system (KPSS) Application Clock Controller
> >>> (ACC)
> >>> +
> >>> +The KPSS ACC provides clock, power domain, and reset control to a
> >>> Krait CPU. +There is one ACC register region per CPU within the
> >>> KPSS remaped region as +well as an alias register region that
> >>> remaps accesses to the ACC associated +with the CPU accessing the
> >>> region.
> >>> +
> >>> +Required Properties:
> >>> +
> >>> +- compatible : Shall contain "qcom,kpss-acc-v1" or
> >>> "qcom,kpss-acc-v2".
> >>> +- reg: Specifies the base address and size of the banked register
> >>> region. +- cpu-offset : per-cpu offset used when the device is
> >>> accessed without the +		CPU remapping facilities.
> >>> +		The offset is cpu-offset + (0x10000 * cpu-nr).
> >>> +
> >>> +Example:
> >>> +
> >>> +	clock-controller at 2008000 {
> >>> +		compatible = "qcom,kpss-acc-v2";
> >>> +		reg = <0x02008000 0x1000>;
> >>> +	};
> >> 
> >> I don't get the cpu-offset business, shouldn't this just be:
> >> 	reg = <0x02008000 0x1000>, <0x02018000 0x1000>, <0x02028000 
0x1000>,
> >> 	<0x02038000 0x1000>;> 
> > (Sorry I forgot to add the cpu-offset to the example.)
> > 
> > Your reg property is one way to do it. I was following the example of
> > the GIC binding which just specifies the alias region of the GIC's CPU
> > registers and then has a cpu-offset property to describe how to reach
> > a
> > specific CPU's region.
> 
> Even in the gic's case I think we should have the reg property cover the
> memory map.

The GIC case was supposed to be a hack for Exynos SoCs that do not have 
banked per-CPU registers. Currently I consider it broken, because it does 
not scale for multi cluster configurations. I believe you should consider 
the same.

IMHO the way to provide per-CPU properties should involve CPU nodes to 
make sure that the same CPU ID namespace is always used.

Best regards,
Tomasz
