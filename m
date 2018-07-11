From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed, 11 Jul 2018 14:51:29 -0700
Subject: [PATCH v6 7/7] arm64: dts: sdm845: Add tsens nodes
In-Reply-To: <CAD=FV=XpfJyd8hUT45+J=EVY1Bs28Mk7m2TBJy8J=HO63n2_qw@mail.gmail.com>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <65c39c405076627bd43ec94c211c6998191b9f16.1531136000.git.amit.kucheria@linaro.org>
 <CAD=FV=XpfJyd8hUT45+J=EVY1Bs28Mk7m2TBJy8J=HO63n2_qw@mail.gmail.com>
Message-ID: <20180711215129.GT129942@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 11:44:13AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> > sensors. It uses version 2 of the TSENS IP, so use the fallback property to
> > allow more common code.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index cdaabeb..ba2899c 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -221,6 +221,22 @@
> >                         #interrupt-cells = <2>;
> >                 };
> >
> > +               tsens0: tsens at c263000 {
> 
> As per my comments in the bindings, nit that this should probably be
> "thermal-sensor" not "tsens", AKA:
> 
> tsens0: thermal-sensor at c263000 {
> 
> > +                       compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> > +                       reg = <0xc263000 0x1ff>, /* TM */
> > +                             <0xc222000 0x1ff>; /* SROT */
> > +                       #qcom,sensors = <13>;
> 
> As per my comment in the bindings and the code, I'm confused about the
> whole "#qcom,sensors" bit.  It's not documented and doesn't seem
> hooked up in the code either.
> 
> ...but if people have tested this, perhaps I'm confused.  How can
> things work if num_sensors is 0???

The mystery is resolved by:

commit 6d7c70d1cd6526dc79e3d3b3faae1c40c1681168
Author: Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Mon May 7 16:53:39 2018 -0700

    thermal: qcom: tsens: Allow number of sensors to come from DT

    For platforms that has multiple copies of the TSENS hardware block it's
    necessary to be able to specify the number of sensors per block in DeviceTree.

    Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
    Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
    Reviewed-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Eduardo Valentin <edubezval@gmail.com>


I bumped into this during testing ;-)
