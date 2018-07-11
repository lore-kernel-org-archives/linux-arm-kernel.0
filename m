From: dianders@chromium.org (Doug Anderson)
Date: Wed, 11 Jul 2018 11:39:23 -0700
Subject: [PATCH v6 3/7] dt: qcom: 8996: thermal: Move to DT initialisation
In-Reply-To: <ee06e59ae84a9b9013480c58bd4678e44d201a42.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <ee06e59ae84a9b9013480c58bd4678e44d201a42.1531135999.git.amit.kucheria@linaro.org>
Message-ID: <CAD=FV=X3B3wKv3jNLM8f9YvdRNkp6CNF1JmE+bMTBnR4CMvyww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> We also split up the regmap address space into two, one for the TM
> registers, the other for the SROT registers. This was required to deal with
> different address offsets for the TM and SROT registers across different
> SoC families.

The splitting into two regions is actually optional and that should
probably be mentioned in the commit message.


> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT). This is OK since the code
> doesn't really use the SROT functionality yet.

Nowhere in the commit message does this say you're also adding a 2nd
block of thermal sensors.  It seems like you should say that
somewhere.

...and it should also be obvious in ${SUBJECT}.


> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 8c7f9ca..6c8a857 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -461,7 +461,17 @@
>
>                 tsens0: thermal-sensor at 4a8000 {
>                         compatible = "qcom,msm8996-tsens";
> -                       reg = <0x4a8000 0x2000>;
> +                       reg = <0x4a9000 0x1000>, /* TM */
> +                             <0x4a8000 0x1000>; /* SROT */

Note that the unit address is supposed to match the first "reg"
address, so either these should be reversed or you should update your
node name.  AKA your node name should be this now:

tsens0: thermal-sensor at 4a9000


> +                       #qcom,sensors = <13>;

As per my responses to other patches, " #qcom,sensors" is undocumented
and doesn't appear to be read by the driver.
