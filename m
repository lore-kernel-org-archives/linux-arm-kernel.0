From: mka@chromium.org (Matthias Kaehlcke)
Date: Tue, 17 Jul 2018 16:58:29 -0700
Subject: [PATCH v7 3/7] arm64: dts: msm8996: thermal: Initialise via DT
 and add second controller
In-Reply-To: <CAD=FV=WydRLs1pY_N+whP10qkqmu8tySPictRuxsLvrfdunFcg@mail.gmail.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <f6cb99e6b805b0850b039e4f5d469e761d84f6d0.1531384019.git.amit.kucheria@linaro.org>
 <20180717234213.GD129942@google.com>
 <CAD=FV=WydRLs1pY_N+whP10qkqmu8tySPictRuxsLvrfdunFcg@mail.gmail.com>
Message-ID: <20180717235829.GF129942@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 04:55:10PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jul 17, 2018 at 4:42 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > On Thu, Jul 12, 2018 at 02:09:04PM +0530, Amit Kucheria wrote:
> >> We also split up the regmap address space into two, for the TM and SROT
> >> registers. This was required to deal with different address offsets for the
> >> TM and SROT registers across different SoC families.
> >>
> >> 8996 has two TSENS IP blocks, initialise the second one too.
> >>
> >> Since tsens-common.c/init_common() currently only registers one address
> >> space, the order is important (TM before SROT). This is OK since the code
> >> doesn't really use the SROT functionality yet.
> >>
> >> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> >> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 14 ++++++++++++--
> >>  1 file changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >> index 8c7f9ca..688e752 100644
> >> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >> @@ -459,9 +459,19 @@
> >>                       status = "disabled";
> >>               };
> >>
> >> -             tsens0: thermal-sensor at 4a8000 {
> >> +             tsens0: thermal-sensor at 4a9000 {
> >                                        ~~~~~~
> >
> > I suppose the address of the TM block is used here instead of the SROT
> > address (which is lower) since SROT functionality is currently not
> > used. Would/should this change if/when the driver uses SROT?
> 
> For device tree you're always supposed to use the address of the first
> "reg" listed as the unit address in the node name.  It doesn't matter
> if it's bigger or smaller as long as it's the first one listed.
> 
> The bindings indicate that the TM block should be listed as the first
> register.  This won't change even if you start using SROT.

Thanks for the clarification, there is always something more to learn!

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
