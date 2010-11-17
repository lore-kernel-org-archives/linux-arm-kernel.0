From: shawn.gsc@gmail.com (Shawn Guo)
Date: Wed, 17 Nov 2010 19:17:39 +0800
Subject: [PATCH 03/11] ARM: imx: Add reset routine for i.MX28
In-Reply-To: <20101115163646.GK8942@pengutronix.de>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
	<1289831795-4373-4-git-send-email-shawn.guo@freescale.com>
	<20101115163646.GK8942@pengutronix.de>
Message-ID: <AANLkTimpvmRLhWuDdZVLGcyro5bfNGEDYx509RLbC_nq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/16 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Mon, Nov 15, 2010 at 10:36:27PM +0800, Shawn Guo wrote:
>> +#ifdef CONFIG_ARCH_MX28
>> +int mxc_reset_block(void __iomem *reg_addr)
>> +{
>> + ? ? u32 reg;
>> + ? ? int timeout;
>> +
>> + ? ? /*
>> + ? ? ?* The process of software reset of IP block is done
>> + ? ? ?* in several steps:
>> + ? ? ?*
>> + ? ? ?* 1) clear SFTRST and wait it cleared;
>> + ? ? ?* 2) clear CLKGATE, set SFTRST, wait CLKGATE set;
>> + ? ? ?* 3) clear SFTRST and wait it cleared;
>> + ? ? ?* 4) clear CLKGATE and wait it cleared.
>> + ? ? ?*/
>> +
>> + ? ? /* Clear SFTRST */
>> + ? ? reg = __raw_readl(reg_addr);
>> + ? ? reg &= ~(1 << 31);
>> + ? ? __raw_writel(reg, reg_addr);
>> + ? ? /* Wait SFTRST cleared */
>> + ? ? timeout = 1000;
>> + ? ? do {
>> + ? ? ? ? ? ? mdelay(1);
>> + ? ? ? ? ? ? if ((__raw_readl(reg_addr) & (1 << 31)) == 0)
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? } while (--timeout > 0);
> Does the mdelay make sence here?
>
i.MX28 Application Processor Reference Manual, Chapter 39.5.10
"Correct Way to Software Reset a Block".

-- 
Regards,
Shawn
