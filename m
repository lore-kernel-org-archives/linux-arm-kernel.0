From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Tue, 10 Aug 2010 10:27:15 -0000
Subject: [PATCH v2] OpenRD: Enable SD/UART selection for serial port 1
In-Reply-To: <20100810085821.GF21175@chipmunk>
References: <1281428973-28957-1-git-send-email-tanmay.upadhyay@einfochips.com>
	<20100810085643.GE21175@chipmunk> <20100810085821.GF21175@chipmunk>
Message-ID: <4C612856.6090405@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2010 02:28 PM, Alexander Clouter wrote:
> Hi,
>
> Just a quick amendment;
>
> * Alexander Clouter<alex@digriz.org.uk>  [2010-08-10 09:56:43+0100]:
>    
>> * Tanmay Upadhyay<tanmay.upadhyay@einfochips.com>  [2010-08-10 13:59:33+0530]:
>>      
>>> This patch enables user to use serial port 1 of the OpenRD device for SDIO
>>> or UART(RS232/RS485). The selection can be done through kernel parameter.
>>>
>>> By default the port would be used for SDIO. To select RS232 or RS485 mode,
>>> pass string "uart=232" or "uart=485" respectively in the kernel parameters.
>>> "uart=485" is ignored on OpenRD-Base as it doesn't have RS485 port.
>>>
>>> Signed-off-by: Tanmay Upadhyay<tanmay.upadhyay@einfochips.com>
>>> ---
>>>   arch/arm/mach-kirkwood/openrd-setup.c |   92 ++++++++++++++++++++++++++++++++-
>>>   1 files changed, 91 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
>>> index fd06be6..cd061ab 100644
>>> --- a/arch/arm/mach-kirkwood/openrd-setup.c
>>> +++ b/arch/arm/mach-kirkwood/openrd-setup.c
>>> @@ -19,6 +19,7 @@
>>>   #include<asm/mach-types.h>
>>>   #include<asm/mach/arch.h>
>>>   #include<mach/kirkwood.h>
>>> +#include<mach/gpio.h>
>>>   #include<plat/mvsdio.h>
>>>   #include "common.h"
>>>   #include "mpp.h"
>>> @@ -57,7 +58,15 @@ static struct mvsdio_platform_data openrd_mvsdio_data = {
>>>   };
>>>
>>>   static unsigned int openrd_mpp_config[] __initdata = {
>>> +	MPP12_SD_CLK,
>>> +	MPP13_SD_CMD,
>>> +	MPP14_SD_D0,
>>> +	MPP15_SD_D1,
>>> +	MPP16_SD_D2,
>>> +	MPP17_SD_D3,
>>> +	MPP28_GPIO,
>>>   	MPP29_GPIO,
>>> +	MPP34_GPIO,
>>>   	0
>>>   };
>>>
>>> @@ -67,6 +76,71 @@ static struct i2c_board_info i2c_board_info[] __initdata = {
>>>   	},
>>>   };
>>>
>>> +static int __initdata uart1;
>>>        
>>      
> static int __initdata uart1 = -EINVAL;
>
>    
>>> +
>>> +static int __init sd_uart_selection(char *str)
>>> +{
>>> +	/* Default is SD. Change if required, for UART */
>>> +	if (!str)
>>> +		return 0;
>>> +
>>> +	if (!strncmp(str, "232", 3)) {
>>> +		uart1 = 232;
>>> +	} else if (!strncmp(str, "485", 3)) {
>>> +		/* OpenRD-Base doesn't have RS485. Treat is as an
>>> +		 * unknown argument&  just have default setting -
>>> +		 * which is SD */
>>> +		if (machine_is_openrd_base())
>>> +			return 1;
>>> +
>>>
>>>        
>> uart1 = -ENODEV;
>> return 1;
>>
>>      
>>> +		uart1 = 485;
>>> +	}
>>> +	return 1;
>>>
>>>        
>> uart1 = -EINVAL;
>> return 1;
>>
>>      
> Drop this suggested amendment.
>
> Cheers
>
>    
Intention here is to provide SD support by default. It will be switched 
to UART mode only if someone asks to do so via kernel parameter. If 
someone doesn't give OR gives improper kernel parameter, he/she won't 
get UART1. It will simply fall-back to the default setting - which is SD 
support.

Does this make sense? Please suggest.

Thanks,

Tanmay
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100810/d3ec9071/attachment-0001.html>
