From: robdclark@gmail.com (Rob Clark)
Date: Tue, 28 Jul 2015 14:30:25 -0400
Subject: [PATCH v1 4/7] ARM: dts: apq8064: Add MDP support
In-Reply-To: <55B7BC79.1060504@suse.de>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438088049-17479-1-git-send-email-srinivas.kandagatla@linaro.org>
 <55B7BC79.1060504@suse.de>
Message-ID: <CAF6AEGtz8o_spTLd_4kUoOrExrpSkqkvqRWSd3Fh3Zd79Kjuwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 1:31 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Hi,
>
> Am 28.07.2015 um 14:54 schrieb Srinivas Kandagatla:
>> From: Rob Clark <robdclark@gmail.com>
>>
>> This patch adds MDP node to APQ8064 dt.
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> [Srinivas Kandagatla] : updated with new style rpm regulators
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>  arch/arm/boot/dts/qcom-apq8064.dtsi | 87 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 87 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
>> index cba4ccb..7d2cc45 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
>> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> [...]
>> +             gpu: qcom,adreno-3xx at 4300000 {
>> +                     compatible = "qcom,adreno-3xx";
>
> I thought that wildcards were forbidden in compatible strings? Then this
> should be replaced by the real number, with a fallback to the first
> compatible one.

That would at least result in a big number of different compatibles,
esp. when you consider patchlevels of the different gpu's, which in
some cases needs to be known (esp. to userspace).. ie. a320.0 is not
the same thing as a320.2.  And the "real numbers" themselves are
confusing as a result of meddling by marketeers.. (ie. a305 vs a305b
vs a306.. which actually map to 305.x, 306.x and 307.x).  The current
scheme is easy to figure out how to setup the dt nodes, ie. easy to
know a3xx vs a4xx, and then copy the chipid property from downstream
dt, and everything works.

The current scheme groups by major gpu revision (ie. things where
basically all the registers change, ie. a3xx/a4xx/a5xx) with using
chipid and a few if statements here and there (kernel and userspace)
to deal with the intra-generation differences.  (The chipid is
something which in theory should be read out of a version register,
but seems that cannot be trusted.)

Not to mention that a3xx/a4xx/etc is how userspace code in mesa is partitioned.

BR,
-R

> And can't we just name the node qcom,adreno without version suffix?
>
> Regards,
> Andreas
>
>> +                     reg = <0x04300000 0x20000>;
>> +                     reg-names = "kgsl_3d0_reg_memory";
>> +                     interrupts = <GIC_SPI 80 0>;
>> +                     interrupt-names = "kgsl_3d0_irq";
>> +                     clock-names =
>> +                         "core_clk",
>> +                         "iface_clk",
>> +                         "mem_clk",
>> +                         "mem_iface_clk";
>> +                     clocks =
>> +                         <&mmcc GFX3D_CLK>,
>> +                         <&mmcc GFX3D_AHB_CLK>,
>> +                         <&mmcc GFX3D_AXI_CLK>,
>> +                         <&mmcc MMSS_IMEM_AHB_CLK>;
>> +                     qcom,chipid = <0x03020002>;
>> +                     qcom,gpu-pwrlevels {
>> +                             compatible = "qcom,gpu-pwrlevels";
>> +                             qcom,gpu-pwrlevel at 0 {
>> +                                     qcom,gpu-freq = <450000000>;
>> +                             };
>> +                             qcom,gpu-pwrlevel at 1 {
>> +                                     qcom,gpu-freq = <27000000>;
>> +                             };
>> +                     };
>> +             };
>> +
>> +             mdp: qcom,mdp at 5100000 {
>> +                     compatible = "qcom,mdp";
>> +                     reg = <0x05100000 0xf0000>;
>> +                     interrupts = <GIC_SPI 75 0>;
>> +                     connectors = <&hdmi>;
>> +                     gpus = <&gpu>;
>> +                     clock-names =
>> +                         "core_clk",
>> +                         "iface_clk",
>> +                         "lut_clk",
>> +                         "src_clk",
>> +                         "hdmi_clk",
>> +                         "mdp_clk",
>> +                         "mdp_axi_clk";
>> +                     clocks =
>> +                         <&mmcc MDP_CLK>,
>> +                         <&mmcc MDP_AHB_CLK>,
>> +                         <&mmcc MDP_LUT_CLK>,
>> +                         <&mmcc TV_SRC>,
>> +                         <&mmcc HDMI_TV_CLK>,
>> +                         <&mmcc MDP_TV_CLK>,
>> +                         <&mmcc MDP_AXI_CLK>;
>> +             };
>>       };
>>  };
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
> 21284 (AG N?rnberg)
