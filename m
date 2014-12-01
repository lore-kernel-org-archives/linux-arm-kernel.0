From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon, 1 Dec 2014 10:57:09 -0700
Subject: [PATCH v13 03/10] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <1417077863.10282.3.camel@mm-sol.com>
References: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org>
 <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
 <1417077863.10282.3.camel@mm-sol.com>
Message-ID: <20141201175709.GA499@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivan,

On Thu, Nov 27 2014 at 01:43 -0700, Ivan T. Ivanov wrote:
>
>Hi,
>
>On Wed, 2014-11-26 at 22:24 -0700, Lina Iyer wrote:
>>
>
>>  - compatible:
>> @@ -14,10 +23,13 @@ PROPERTIES
>>         Value type: <string>
>>         Definition: shall contain "qcom,saw2". A more specific value should be
>>                                                 one of:
>
>Which driver is supposed to handle this property?
>
drivers/soc/qcom/spm.c - SAW power controller driver.
>> -                               "qcom,saw2-v1"
>> -                               "qcom,saw2-v1.1"
>> -                               "qcom,saw2-v2"
>> -                               "qcom,saw2-v2.1"
>> +                       "qcom,saw2-v1"
>> +                       "qcom,saw2-v1.1"
>> +                       "qcom,saw2-v2"
>> +                       "qcom,saw2-v2.1"
>
>Doesn't seems to be used or supported?
>
Used for identify the version of the SAW that does voltage changes.  Any
SAW that can change the voltage would use one of the above compatible
strings. We only need a generic version number for regulator
functionality as opposed to the ones used for idle control (like below),
which needs to correctly identify the version number (saw2-v1.1), cpu/L2
(-cpu_variant of the SAW on a particlar SoC (qcom,apq/msmXXXX) to set
the correct register values for that SoC.

L2 SAW is currently not upstream or part of this series. Will follow
suit, when we have the power domains to control cluster low power modes.
The regulator functionality is currently not available upstream, as well
for 8084 and 8074.

Thanks,
Lina

>> +                       "qcom,apq8064-saw2-v1.1-cpu"
>> +                       "qcom,msm8974-saw2-v2.1-cpu"
>> +                       "qcom,apq8084-saw2-v2.1-cpu"
>>
>
><snip>
>
>> -???????regulator at 2099000 {
>> +???????power-controller at 2099000 {
>>                 compatible = "qcom,saw2";
>>                 reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
>> +               regulator;
>>
>
><snip>
>
>> +static const struct of_device_id spm_match_table[] = {
>> +       { .compatible = "qcom,msm8974-saw2-v2.1-cpu",
>> +                       .data = &spm_reg_8974_8084_cpu },
>> +       { .compatible = "qcom,apq8084-saw2-v2.1-cpu",
>> +                       .data = &spm_reg_8974_8084_cpu },
>> +       { .compatible = "qcom,apq8064-saw2-v1.1-cpu",
>> +                       .data = &spm_reg_8064_cpu },
>> +       { },
>> +};
>> +
>
>Regards,
>Ivan
