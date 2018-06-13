From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Wed, 13 Jun 2018 11:13:10 +0300
Subject: [PATCH v2 2/5] dt: qcom: 8996: thermal: Move to DT initialisation
In-Reply-To: <20180612193507.GO14924@minitux>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
 <683ceb9a7d283bcad47fc6e8e4fcfbd7e76c1018.1528799892.git.amit.kucheria@linaro.org>
 <20180612193507.GO14924@minitux>
Message-ID: <CAHLCerOaQ6LmuGkBNu6SuVXXX8hQ+yJJ9-N6NAyLhtTp_yCK-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 10:35 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Tue 12 Jun 03:54 PDT 2018, Amit Kucheria wrote:
>
>> We also split up the regmap address space into two, one for the TM
>> registers, the other for the SROT registers. This was required to deal with
>> different address offsets for the TM and SROT registers across different
>> SoC families.
>>
>> Since tsens-common.c/init_common() currently only registers one address space, the order is important (TM before SROT).This is OK since the code doesn't really use the SROT functionality yet.
>
> Please line wrap this.
>
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
>>  drivers/thermal/qcom/tsens-8996.c     |  1 -
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> index 410ae78..b4aab18 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> @@ -451,7 +451,17 @@
>>
>>               tsens0: thermal-sensor at 4a8000 {
>>                       compatible = "qcom,msm8996-tsens";
>> -                     reg = <0x4a8000 0x2000>;
>> +                     reg = <0x4a9000 0x1000>, /* TM */
>> +                           <0x4a8000 0x1000>; /* SROT */
>> +                     #qcom,sensors = <13>;
>> +                     #thermal-sensor-cells = <1>;
>> +             };
>> +
>> +             tsens1: thermal-sensor at 4ac000 {
>> +                     compatible = "qcom,msm8996-tsens";
>> +                     reg = <0x4ad000 0x1000>, /* TM */
>> +                           <0x4ac000 0x1000>; /* SROT */
>> +                     #qcom,sensors = <8>;
>>                       #thermal-sensor-cells = <1>;
>>               };
>>
>> diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
>> index e1f7781..6e59078 100644
>> --- a/drivers/thermal/qcom/tsens-8996.c
>> +++ b/drivers/thermal/qcom/tsens-8996.c
>> @@ -79,6 +79,5 @@ static const struct tsens_ops ops_8996 = {
>>  };
>>
>>  const struct tsens_data data_8996 = {
>> -     .num_sensors    = 13,
>
> This will cause the current 8996 dts to fail probing the tsens. I think
> you should just leave this as is, because specifying qcom,sensors in dts
> will overwrite this number regardless.

Ack, I didn't consider backword compatility of the code with the
current dts. Will fix.

> It also would make this change dts specific, which is convenient as it
> breaks the interdependency between the different subsystems.
>
>>       .ops            = &ops_8996,
>
> Regards,
> Bjorn
