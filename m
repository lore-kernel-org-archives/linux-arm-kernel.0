From: jason77.wang@gmail.com (jason)
Date: Thu, 03 Jun 2010 08:01:33 +0800
Subject: [PATCH 1/3] mxc: Add support for the imx51 3-stack board
In-Reply-To: <20100602172334.GS26820@pengutronix.de>
References: <1275405043-18230-1-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-2-git-send-email-jason77.wang@gmail.com>
	<20100602073650.GK26820@pengutronix.de>
	<002e01cb025f$b3daf110$9b00a8c0@wuef10f27ebed8>
	<20100602172334.GS26820@pengutronix.de>
Message-ID: <4C06F0DD.4000005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer wrote:
> On Wed, Jun 02, 2010 at 10:27:03PM +0800, jason wang wrote:
>   
>>     
>>> Hi Jason,
>>>
>>> On Tue, Jun 01, 2010 at 11:10:41PM +0800, Jason Wang wrote:
>>>       
>>>> 3-stack is a reference board from Freescale for their i.MX51 SoC.
>>>>
>>>> Add board definition, Kconfig and Makefile to enable Freescale 3-stack
>>>> board.
>>>>         
>>> The debug board code looks the same like in mach-mx31_3ds.c. Does
>>> anybody know how similar the different debug boards for the 3ds boards
>>> are? ATM we only have the mx31_3ds with debug board support in the
>>> kernel. This could be the moment to go for a arch/arm/plat-mxc/3ds-debugboard.c
>>>
>>>       
>> Besides mx31_3ds and mx51_3ds, the mx31_ads and mx27_ads also have the similar CPLD expanding device.
>> They have similar functions but different CPLD image version. That is to say, except base_addr and parent_irq_pin,
>> the CPLD implemented device controller(like uart and interrupt controller) will be a little bit different.
>> I think the software for this part could be moved to a common file like plat-mxc/mxc-debugboard.c
>>
>> Because this is a big action, it will affect some exsiting platforms. How about leave this work to next
>> action?
>>
>> Thanks,
>> Jason.
>>     
>>> Several other comments inline.
>>>
>>>       
>> Except following 1 comment, all others will be addressed in V2.
>>
>> <snip>
>>     
>>>> Boot tested on a i.MX51 3-stack Rev2.0 board
>>>> + __raw_writew(0xFFFF, brd_io + INTR_RESET_REG);
>>>> + __raw_writew(0, brd_io + INTR_RESET_REG);
>>>> + __raw_writew(0x1F, brd_io + INTR_MASK_REG);
>>>> + for (i = MXC_BOARD_IRQ_START;
>>>> +      i < (MXC_BOARD_IRQ_START + MXC_BOARD_IRQS); i++) {
>>>>         
>>> MXC_BOARD_IRQS is the maximum number of interrupts available for the
>>> board. What you need here instead is the number of interrupts the expio
>>> actually has.
>>>
>>>       
>> It seems MXC_BOARD_IRQS is the number of CPLD expanding irq(or debugboard expanding irq).
>>     
>
> Not exactly. See mach/irqs.h:
>
> /*
>  * The next 16 interrupts are for board specific purposes.  Since
>  * the kernel can only run on one machine at a time, we can re-use
>  * these.  If you need more, increase MXC_BOARD_IRQS, but keep it
>  * within sensible limits.
>  */
> #define MXC_BOARD_IRQ_START     (MXC_INTERNAL_IRQS + MXC_GPIO_IRQS)
>
> #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
> #define MXC_BOARD_IRQS  80
> #else
> #define MXC_BOARD_IRQS  16
> #endif
>
>
> Remember that we can compile the kernel for more than one board at a
> time. So if MACH_MX31ADS_WM1133_EV1 is compiled in we will have 60 board
> irqs. Ok, you will hardly compile a kernel for mx31ads and mx51, but
> there could well come a mx51 board with more irqs in which case your
> expio handler goes nuts.
>
> Sascha
>
>
>   
OK, clear, thanks for your explanation.

Thanks,
Jason.
