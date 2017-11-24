From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Fri, 24 Nov 2017 15:49:46 +0100
Subject: [PATCH v4 08/12] IIO: ADC: add STM32 DFSDM sigma delta ADC support
In-Reply-To: <20171119142935.044a0764@archlinux>
References: <1510222354-15290-1-git-send-email-arnaud.pouliquen@st.com>
 <1510222354-15290-9-git-send-email-arnaud.pouliquen@st.com>
 <20171119142935.044a0764@archlinux>
Message-ID: <e05656e4-6ac4-b249-670f-98f2c42d7968@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/19/2017 03:29 PM, Jonathan Cameron wrote:
> On Thu, 9 Nov 2017 11:12:30 +0100
> Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
> 
>> Add DFSDM driver to handle sigma delta ADC.
>> 
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>? drivers/iio/adc/Kconfig?????????? |? 13 +
>>? drivers/iio/adc/Makefile????????? |?? 1 +
>>? drivers/iio/adc/stm32-dfsdm-adc.c | 741 ++++++++++++++++++++++++++++++++++++++
>>? 3 files changed, 755 insertions(+)
>>? create mode 100644 drivers/iio/adc/stm32-dfsdm-adc.c

[...]

>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
>> new file mode 100644
>> index 0000000..f9419ab
>> --- /dev/null
>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
>> @@ -0,0 +1,741 @@

[...]

>> +static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
>> +{
>> +???? struct stm32_dfsdm_adc *adc = platform_get_drvdata(pdev);
>> +???? struct iio_dev *indio_dev = iio_priv_to_dev(adc);
>> +
>> +???? iio_device_unregister(indio_dev);
> Given that all we have here is device unregister, you could
> use the devm_iio_device_register call and drop the remove entirely.
> (of course you may add stuff here in later patches - I haven't
> looked yet ;)
Yes, the next patch makes devm_iio_device_register useless, so i don't
use it here.

Regards

Arnaud
>> +
>> +???? return 0;
>> +}
>> +
>> +static struct platform_driver stm32_dfsdm_adc_driver = {
>> +???? .driver = {
>> +???????????? .name = "stm32-dfsdm-adc",
>> +???????????? .of_match_table = stm32_dfsdm_adc_match,
>> +???? },
>> +???? .probe = stm32_dfsdm_adc_probe,
>> +???? .remove = stm32_dfsdm_adc_remove,
>> +
>> +};
>> +module_platform_driver(stm32_dfsdm_adc_driver);
>> +
>> +MODULE_DESCRIPTION("STM32 sigma delta ADC");
>> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
>> +MODULE_LICENSE("GPL v2");
> 
