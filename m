From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Jan 2014 08:56:23 -0800
Subject: [PATCH v5 2/4] devicetree: bindings: Document Krait CPU/L1 EDAC
In-Reply-To: <20140115102701.GA27314@e102568-lin.cambridge.arm.com>
References: <1389735034-21430-1-git-send-email-sboyd@codeaurora.org>
 <1389735034-21430-3-git-send-email-sboyd@codeaurora.org>
 <20140115102701.GA27314@e102568-lin.cambridge.arm.com>
Message-ID: <20140115165623.GJ14405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15, Lorenzo Pieralisi wrote:
> On Tue, Jan 14, 2014 at 09:30:32PM +0000, Stephen Boyd wrote:
> > The Krait CPU/L1 error reporting device is made up a per-CPU
> > interrupt. While we're here, document the next-level-cache
> > property that's used by the Krait EDAC driver.
> > 
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Kumar Gala <galak@codeaurora.org>
> > Cc: <devicetree@vger.kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.txt | 52 ++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> > index 91304353eea4..c332b5168456 100644
> > --- a/Documentation/devicetree/bindings/arm/cpus.txt
> > +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> > @@ -191,6 +191,16 @@ nodes to be present and contain the properties described below.
> >  			  property identifying a 64-bit zero-initialised
> >  			  memory location.
> >  
> > +	- interrupts
> > +		Usage: required for cpus with compatible string "qcom,krait".
> > +		Value type: <prop-encoded-array>
> > +		Definition: L1/CPU error interrupt
> 
> I reckon you want this property to belong in the cpus node (example below),
> not in cpu nodes, right ?

Yes.

> 
> Are you relying on a platform device to be created for /cpus node in
> order for this series to work ? I guess that's why you want the
> interrupts property to be defined in /cpus so that it becomes a platform
> device resource (and you also add a compatible property in /cpus that is
> missing in these bindings).

Ah yes. I'll move this to the /cpus section.

> 
> > +
> > +	- next-level-cache
> > +		Usage: optional
> > +		Value type: <phandle>
> > +		Definition: phandle pointing to the next level cache
> > +
> >  Example 1 (dual-cluster big.LITTLE system 32-bit):
> >  
> >  	cpus {
> > @@ -382,3 +392,45 @@ cpus {
> >  		cpu-release-addr = <0 0x20000000>;
> >  	};
> >  };
> > +
> > +
> > +Example 5 (Krait 32-bit system):
> > +
> > +cpus {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	interrupts = <1 9 0xf04>;
> 
> In patch 4 you also add a compatible property here, and that's not documented,
> and honestly I do not think that's acceptable either. I guess you want a
> compatible property here to match the platform driver, right ?

Ah sorry, I forgot to put the compatible property here like in
the dts change. I'll do that in the next revision. Yes we need a
compatible property here to match the platform driver.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
