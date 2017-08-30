From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 30 Aug 2017 11:11:24 +0200
Subject: [RESEND PATCH 2/3] regulator: Add support for stm32-vrefbuf
In-Reply-To: <20170829185719.h5fxvzmxbysyxwml@sirena.org.uk>
References: <1503925133-30722-1-git-send-email-fabrice.gasnier@st.com>
 <1503925133-30722-3-git-send-email-fabrice.gasnier@st.com>
 <20170829185719.h5fxvzmxbysyxwml@sirena.org.uk>
Message-ID: <fd883990-cc87-f8cb-ebe7-5c4c4e51d6f6@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2017 08:57 PM, Mark Brown wrote:
> On Mon, Aug 28, 2017 at 02:58:52PM +0200, Fabrice Gasnier wrote:
> 
>> +	ret = clk_prepare_enable(priv->clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "clk prepare failed\n");
> 
> If you're printing an error include the error code, it'll help users
> figure out what went wrong.
Hi Mark,

Thanks for reviewing,
I'll add it in v2.
> 
>> +	dev_info(&pdev->dev, "STM32 VREFBUF initialized\n");
> 
> This is just noise, remove it.

I'll remove it in v2.
> 
>> +static int __init stm32_vrefbuf_init(void)
>> +{
>> +	return platform_driver_register(&stm32_vrefbuf_driver);
>> +}
>> +subsys_initcall(stm32_vrefbuf_init);
> 
> Why is this at subsys_initcall()?
> 
Several consumers depend on it when it's being used, among which: STM32
internal ADC and DAC, but also external components. Purpose is to ensure
it's ready before these drivers gets probed, instead of being deferred.
Is it ok to keep it ?

Please let me know,
Best Regards,
Fabrice
