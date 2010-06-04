From: jason77.wang@gmail.com (jason)
Date: Fri, 04 Jun 2010 20:50:03 +0800
Subject: [V2 1/3] mxc: Add support for the imx51 3-stack board
In-Reply-To: <20100604085320.GB25357@pengutronix.de>
References: <1275566746-6510-1-git-send-email-jason77.wang@gmail.com>
	<1275566746-6510-2-git-send-email-jason77.wang@gmail.com>
	<20100604085320.GB25357@pengutronix.de>
Message-ID: <4C08F67B.5040009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer wrote:
> On Thu, Jun 03, 2010 at 08:05:44PM +0800, Jason Wang wrote:
>   
>> +
>> +static void mxc_expio_irq_handler(u32 irq, struct irq_desc *desc)
>> +{
>>     
>
> I'm not willing to accept another 3ds_debug board support in the kernel
> given that it's no rocket science to seperate this into another file and
> we still have plenty of time before the next merge window.
> Jason, can you please move this to plat-mxc? I think we could find
> someone else to switch the mx31_3ds support to the generic debug board
> support then.
>
>
> [snip]
>
>   
OK, i will add a common part for debug board in V3.

Thanks,
Jason.
>>  #define MX51_PAD_EIM_D24__UART3_CTS	IOMUX_PAD(0x410, 0x07c, IOMUX_CONFIG_ALT3, 0x0, 0, MX51_UART3_PAD_CTRL)
>>  #define MX51_PAD_EIM_D25__UART3_RXD	IOMUX_PAD(0x414, 0x080, IOMUX_CONFIG_ALT3, 0x9f4, 0, MX51_UART3_PAD_CTRL)
>> +#define MX51_PAD_EIM_D25__UART2_CTS	IOMUX_PAD(0x414, 0x080, IOMUX_CONFIG_ALT4, 0x0, 0, MX51_UART2_PAD_CTRL)
>>  #define MX51_PAD_EIM_D26__UART3_TXD	IOMUX_PAD(0x418, 0x084, IOMUX_CONFIG_ALT3, 0x0, 0, MX51_UART3_PAD_CTRL)
>> -#define MX51_PAD_EIM_D27__UART3_RTS	IOMUX_PAD(0x41c, 0x088, IOMUX_CONFIG_ALT3, 0x9f0, 0, MX51_UART3_PAD_CTRL)
>> +#define MX51_PAD_EIM_D26__UART2_RTS	IOMUX_PAD(0x418, 0x084, IOMUX_CONFIG_ALT4, 0x9e8, 3, MX51_UART2_PAD_CTRL)
>>
>>     
<snip>
>
> Urgs, there really is something wrong here.
>
> First of all, this define should be named MX51_PAD_UART3_RXD__GPIO_1_22
> as it describes the pad UART3_RXD in GPIO_1_22 mode. This seems to be
> wrong with many (all?) defines in this file. Amit, you should have read
> the comment ontop of this file which you copied from the i.MX35 part:
>
> /*
>  * The naming convention for the pad modes is MX51_PAD_<padname>__<padmode>
>  * If <padname> or <padmode> refers to a GPIO, it is named
>  * GPIO_<unit>_<num> see also iomux-v3.h
>  */
>
> This should be fixed before doing any other change to this file.
>
> Then Jason, what you are looking for is the following:
>
> #define MX51_PAD_UART3_RXD__UART3_RXD
>
> because you want the UART3_RXD pad in its native mode.
>
> Here is how the defines in this file should look like (modulo bugs):
>
>
> #define MX51_PAD_EIM_D16__GPIO_2_0		(0x3f0, 0x05c, 1, 0x0,   0, NO_PAD_CTRL)
> #define MX51_PAD_EIM_D17__GPIO_2_1		(0x3f4, 0x060, 1, 0x0,   0, NO_PAD_CTRL)
> #define MX51_PAD_EIM_D18__GPIO_2_2		(0x3f8, 0x064, 1, 0x0,   0, NO_PAD_CTRL)
> #define MX51_PAD_EIM_D19__GPIO_2_3		(0x3fc, 0x068, 1, 0x0,   0, NO_PAD_CTRL)
> #define MX51_PAD_EIM_D20__GPIO_2_4		(0x400, 0x06c, 1, 0x0,   0, NO_PAD_CTRL)
>   
Yes, some pin names are wrong. It seems that you have already got a
update for cleanup of those pad names, but it haven't pushed to upstream,
i will cherry pick this update and basing on it add mx51_3ds specific pads.

Thanks,
Jason.
> #define MX51_PAD_EIM_D21__GPIO_2_5		(0x404, 0x070, 1, 0x0,   0, NO_PAD_CTRL)
> #define MX51_PAD_EIM_D22__GPIO_2_6		(0x408, 0x074, 1, 0x0,   0, NO_PAD_CTRL)
> #define MX51_PAD_EIM_D23__GPIO_2_7		(0x40c, 0x078, 1, 0x0,   0, NO_PAD_CTRL)
>   
<snip>
