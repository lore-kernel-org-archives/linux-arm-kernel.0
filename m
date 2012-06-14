From: snijsure@grid-net.com (Subodh Nijsure)
Date: Wed, 13 Jun 2012 21:40:30 -0700
Subject: MXS getting AUART to work with DT.
In-Reply-To: <CAOMZO5BDFD3hHt+HW_sdh-3hCEwgJJA9C0ecAJZSOUCw_725Jw@mail.gmail.com>
References: <4FD7EFFC.8010204@grid-net.com>
 <CAOMZO5BDFD3hHt+HW_sdh-3hCEwgJJA9C0ecAJZSOUCw_725Jw@mail.gmail.com>
Message-ID: <4FD96B3E.6080806@grid-net.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2012 07:57 PM, Fabio Estevam wrote:
> On Tue, Jun 12, 2012 at 10:42 PM, Subodh Nijsure<snijsure@grid-net.com>  wrote:
>> Hi,
>>
>> I am testing my mx28 hardware with arm-soc/for-next branch. I have made
>>   additions shown below to my dt file.
>>
>> What I see is only ttyAPP0 device gets created but not the ttyAPP1, do folks
>> who know DT much better than I, see any issues with this DT definition
>> below?
> Would something like the patch below be needed?
>
> ---
>   arch/arm/boot/dts/imx28.dtsi   |    5 +++++
>   drivers/tty/serial/mxs-auart.c |    9 +++++++++
>   2 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 4634cb8..d524377 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -404,30 +404,35 @@
>   			};
>
>   			auart0: serial at 8006a000 {
> +				compatible = "fsl,mxs-auart";
>   				reg =<0x8006a000 0x2000>;
>   				interrupts =<112 70 71>;
>   				status = "disabled";
>   			};
>
>   			auart1: serial at 8006c000 {
> +				compatible = "fsl,mxs-auart";
>   				reg =<0x8006c000 0x2000>;
>   				interrupts =<113 72 73>;
>   				status = "disabled";
>   			};
>
>   			auart2: serial at 8006e000 {
> +				compatible = "fsl,mxs-auart";
>   				reg =<0x8006e000 0x2000>;
>   				interrupts =<114 74 75>;
>   				status = "disabled";
>   			};
>
>   			auart3: serial at 80070000 {
> +				compatible = "fsl,mxs-auart";
>   				reg =<0x80070000 0x2000>;
>   				interrupts =<115 76 77>;
>   				status = "disabled";
>   			};
>
>   			auart4: serial at 80072000 {
> +				compatible = "fsl,mxs-auart";
>   				reg =<0x80072000 0x2000>;
>   				interrupts =<116 78 79>;
>   				status = "disabled";
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index ec56d83..6540f28 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -33,6 +33,8 @@
>   #include<linux/delay.h>
>   #include<linux/io.h>
>   #include<linux/pinctrl/consumer.h>
> +#include<linux/of.h>
> +#include<linux/of_address.h>
>
>   #include<asm/cacheflush.h>
>
> @@ -769,12 +771,19 @@ static int __devexit mxs_auart_remove(struct
> platform_device *pdev)
>   	return 0;
>   }
>
> +static struct of_device_id mxs_auart_dt_ids[] = {
> +	{.compatible = "fsl,mxs-auart", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mxs_auart_of_match);
> +
>   static struct platform_driver mxs_auart_driver = {
>   	.probe = mxs_auart_probe,
>   	.remove = __devexit_p(mxs_auart_remove),
>   	.driver = {
>   		.name = "mxs-auart",
>   		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(mxs_auart_dt_ids),
>   	},
>   };
>
With this change you will only see AUART0 being created all subsequent 
attempts fail.  I think we need to have dt specific probe, my colleague 
Matt Burtch has implemented that dt specific probe for AUART will 
request him to send his diff tomorrow AM.

I think something is broken in 3.5 as far as I can tell AUART goes it 
had worked for me in 3.4, I am novice at device-tree and was not sure if 
its because of DT or something else.

-Subodh
