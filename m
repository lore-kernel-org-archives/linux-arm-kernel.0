From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 02 Nov 2010 10:35:27 +0100
Subject: [patch v4 01/10] efikamx: read board id
In-Reply-To: <201010300948.51143.marek.vasut@gmail.com> (Marek Vasut's message
	of "Sat, 30 Oct 2010 09:48:51 +0200")
References: <20101027124044.980739780@rtp-net.org>
	<20101027124340.156430559@rtp-net.org>
	<201010300948.51143.marek.vasut@gmail.com>
Message-ID: <87hbg06pb4.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> On Wednesday 27 October 2010 14:40:46 Arnaud Patard wrote:
>> read board id value from the GPIO3_16/17/11
>> 
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Index: linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c
>> ===================================================================
>
> This is not git, is it ... what do you use to generate this stuff ?

I'm using quilt (http://savannah.nongnu.org/projects/quilt). 

>
>> --- linux-2.6-submit.orig/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-21
>> 08:29:23.000000000 +0200 +++
>> linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-21
>> 08:29:46.000000000 +0200 @@ -39,12 +39,26 @@
>> 
>>  #define	MX51_USB_PLL_DIV_24_MHZ	0x01
>> 
>> +#define EFIKAMX_PCBID0		(2*32 + 16)
>> +#define EFIKAMX_PCBID1		(2*32 + 17)
>> +#define EFIKAMX_PCBID2		(2*32 + 11)
>> +
>> +/* the pci ids pin have pull up. they're driven low according to board id
>> */ +#define MX51_PAD_PCBID0	IOMUX_PAD(0x518, 0x130, 3, 0x0,   0,
>> PAD_CTL_PUS_100K_UP) +#define MX51_PAD_PCBID1	IOMUX_PAD(0x51C, 0x134, 3,
>> 0x0,   0, PAD_CTL_PUS_100K_UP) +#define MX51_PAD_PCBID2	IOMUX_PAD(0x504,
>> 0x128, 3, 0x0,   0, PAD_CTL_PUS_100K_UP) +
>>  static struct pad_desc mx51efikamx_pads[] = {
>>  	/* UART1 */
>>  	MX51_PAD_UART1_RXD__UART1_RXD,
>>  	MX51_PAD_UART1_TXD__UART1_TXD,
>>  	MX51_PAD_UART1_RTS__UART1_RTS,
>>  	MX51_PAD_UART1_CTS__UART1_CTS,
>> +
>> +	/* board id */
>> +	MX51_PAD_PCBID0,
>> +	MX51_PAD_PCBID1,
>> +	MX51_PAD_PCBID2,
>>  };
>> 
>>  /* Serial ports */
>> @@ -92,10 +106,62 @@
>>  	.flags  = MXC_EHCI_INTERNAL_PHY,
>>  };
>> 
>> +/*   PCBID2  PCBID1 PCBID0  STATE
>> +	1       1      1    ER1:rev1.1
>> +	1       1      0    ER2:rev1.2
>> +	1       0      1    ER3:rev1.3
>> +	1       0      0    ER4:rev1.4
>> +*/
>> +static void __init mx51_efikamx_board_id(void)
>> +{
>> +	int id;
>> +
>> +	/* things are taking time to settle */
>> +	msleep(150);
>> +
>> +	gpio_request(EFIKAMX_PCBID0, "pcbid0");
>> +	gpio_direction_input(EFIKAMX_PCBID0);
>> +	gpio_request(EFIKAMX_PCBID1, "pcbid1");
>> +	gpio_direction_input(EFIKAMX_PCBID1);
>> +	gpio_request(EFIKAMX_PCBID2, "pcbid2");
>> +	gpio_direction_input(EFIKAMX_PCBID2);
>> +
>> +	id = gpio_get_value(EFIKAMX_PCBID0);
>> +	id |= gpio_get_value(EFIKAMX_PCBID1) << 1;
>> +	id |= gpio_get_value(EFIKAMX_PCBID2) << 2;
>> +
>> +	switch (id) {
>> +	case 7:
>> +		system_rev = 0x11;
>> +		break;
>> +	case 6:
>> +		system_rev = 0x12;
>> +		break;
>> +	case 5:
>> +		system_rev = 0x13;
>> +		break;
>> +	case 4:
>> +		system_rev = 0x14;
>> +		break;
>> +	default:
>> +		system_rev = 0x10;
>> +		break;
>> +	}
>> +
>> +	if ((system_rev == 0x10)
>> +		|| (system_rev == 0x12)
>> +		|| (system_rev == 0x14)) {
>> +		printk(KERN_WARNING
>> +			"EfikaMX: Unsupported board revision 1.%u!\n",
>> +			system_rev & 0xf);
>
> Use rather Unknown than Unsupported ... or make it sound more like a warning 
> than like a utter crash.

It's not unknown, iiuc, it's just that other boards have not been
available so they do exist but using them likely lead to troubles.

>
> Also, maybe you should free the GPIOs here again ?
>

afaik theses GPIOs are used only for that so it's not a big problem to
not free them and also this allows to look at their value through
/sys/kernel/debug/gpio easily.


Arnaud
