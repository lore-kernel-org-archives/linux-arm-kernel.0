From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Feb 2018 11:08:08 +0000
Subject: [PATCH 1/2] dt-bindings: Documentation for qcom,llcc
In-Reply-To: <2c343b57bf3ee8aeb3338aee0d27dc06@codeaurora.org>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
 <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
 <20180201104808.rxgqcrlsevtotq55@lakrids.cambridge.arm.com>
 <2c343b57bf3ee8aeb3338aee0d27dc06@codeaurora.org>
Message-ID: <20180202110808.nnrawjhyvz273em3@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 12:47:01PM -0800, Channa wrote:
> On 2018-02-01 02:48, Mark Rutland wrote:
> > On Thu, Jan 25, 2018 at 03:55:12PM -0800, Channagoud Kadabi wrote:
> > > Documentation for last level cache controller device tree bindings,
> > > client bindings usage examples.
> > > 
> > > Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> > > ---
> > >  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 93
> > > ++++++++++++++++++++++
> > >  1 file changed, 93 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> > > 
> > > +Example:
> > > +
> > > +	qcom,system-cache at 1300000 {
> > > +		compatible = "qcom,llcc-core", "syscon", "simple-mfd";
> > > +		reg = <0x1300000 0x50000>;
> > > +		reg-names = "llcc_base";
> > > +
> > > +		llcc: qcom,sdm845-llcc {
> > > +			compatible = "qcom,sdm845-llcc";
> > > +			#cache-cells = <1>;
> > > +			max-slices = <32>;
> > > +		};
> > > +
> > > +		qcom,llcc-ecc {
> > > +			compatible = "qcom,llcc-ecc";
> > > +		};
> > > +
> > > +		qcom,llcc-amon {
> > > +			compatible = "qcom,llcc-amon";
> > > +			qcom,fg-cnt = <0x7>;
> > > +		};
> > > +
> > > +	};
> > 
> > The "qcom,llcc-ecc" and "qcom,llcc-amon" bindings doesn't seem to be
> > used by the driver in patch 2, and it's not clear how they are intended
> > to be used, so I think they should go from the binding for now.
> 
> Sure I can remove them for now and add them when the I push other drivers
> for review.
> 
> > I don't think you need syscon and simple-mfd, and I think you can
> 
> I used syscon and simple-mfd because three drivers touch the same address
> space.

As in my other reply, I don't think that's the right way to solve the
problem.

Please have one top-level driver and associated binding. That driver can
carve up the functional units and allow other drivers to access the
registers as necessary.

Thanks,
Mark.
