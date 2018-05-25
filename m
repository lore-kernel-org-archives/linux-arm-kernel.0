From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Fri, 25 May 2018 18:21:50 +0530
Subject: [PATCH] arm64: dts: qcom: msm8996: Use UFS_GDSC for UFS
In-Reply-To: <20180524223122.12601-1-bjorn.andersson@linaro.org>
References: <20180524223122.12601-1-bjorn.andersson@linaro.org>
Message-ID: <CAFp+6iH5bS5rmqZ1oy09COb2Rzuz6zbN7pFwxz0WTJNOYTTbkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Fri, May 25, 2018 at 4:01 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> The UFS host controller occationally (20%) fails to enable
> gcc_ufs_axi_clk because the UFS GDSC is not enabled. In most cases it's
> enabled through the UFS phy driver, but to make sure it's enabled let's
> enable it directly from the UFS host controller directly as well.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 380e14591686..03c7904bda14 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -674,6 +674,8 @@
>                         vccq-max-microamp = <450000>;
>                         vccq2-max-microamp = <450000>;
>
> +                       power-domains = <&gcc UFS_GDSC>;
> +

We shouldn't need power-domain with the phy. UFS_GDSC should
be attached to the controller, as the phy is powered up only after
the controller is power-up, and during collapse too, we turn off
the phy first.
Can you try testing keeping UFS_GDSC only with ufs controller and
remove it from the ufs-phy node? We are doing same on the 4.14 release
branch too for db820.
I apologize to have missed this in your patch for ufs-related dt nodes.
Can we please fix this now?

Best regards
Vivek

>                         clock-names =
>                                 "core_clk_src",
>                                 "core_clk",
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
