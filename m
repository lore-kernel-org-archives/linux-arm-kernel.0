From: mkl0301@gmail.com (Lin Mac)
Date: Wed, 22 Dec 2010 17:27:20 +0800
Subject: [PATCH 1/1] ARM: cns3xxx: ahci: Fixup for softwreset failures
	with direct connected disks with CONFIG_SATA_PMP enabled.
In-Reply-To: <20101220170217.GA1333@oksana.dev.rtsoft.ru>
References: <1291481021-23317-1-git-send-email-mkl0301@gmail.com>
	<20101220170217.GA1333@oksana.dev.rtsoft.ru>
Message-ID: <AANLkTi=Lk1vAxxTJQpXNvtbLCFs0Gy+ZAJadxv_mLQ6C@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/21 Anton Vorontsov <cbouatmailru@gmail.com>:
> On Sun, Dec 05, 2010 at 12:43:41AM +0800, mkl0301 at gmail.com wrote:
> [...]
>
> Thanks for the patch!
>
> There are few issues though.
>
>> +static int cns3xxx_ahci_init(struct device *dev, void __iomem *addr)
>> +{
>> + ? ? u32 tmp;
>> +
>> + ? ? DPRINTK("ENTER\n");
>> +
>> + ? ? tmp = __raw_readl(MISC_SATA_POWER_MODE);
>> + ? ? tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
>> + ? ? tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
>> + ? ? __raw_writel(tmp, MISC_SATA_POWER_MODE);
>> +
>> + ? ? /* Enable SATA PHY */
>> + ? ? cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
>> + ? ? cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
>> +
>> + ? ? /* Enable SATA Clock */
>> + ? ? cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
>> +
>> + ? ? /* De-Asscer SATA Reset */
>> + ? ? cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
>> +
>> + ? ? return 0;
>> +}
>> +
> [...]
>> -void __init cns3xxx_ahci_init(void)
>> -{
>> - ? ? u32 tmp;
>> -
>> - ? ? tmp = __raw_readl(MISC_SATA_POWER_MODE);
>> - ? ? tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
>> - ? ? tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
>> - ? ? __raw_writel(tmp, MISC_SATA_POWER_MODE);
>> -
>> - ? ? /* Enable SATA PHY */
>> - ? ? cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
>> - ? ? cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
>> -
>> - ? ? /* Enable SATA Clock */
>> - ? ? cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
>> -
>> - ? ? /* De-Asscer SATA Reset */
>> - ? ? cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
>> -
>> - ? ? platform_device_register(&cns3xxx_ahci_pdev);
>> -}
>
> This is not good because cns3xxx_pwr_*() calls aren't thread-safe.
> We must use them only from the "single-threaded" platform code,
> i.e. very early.
> Once we add proper clocks (clkapi) and power management (regulators)
> support for CNS3xxx, we may move this into ahci->init() callback.
Almost every device driver needs to change those power/clk/reset bits,
and it's strange to enable everything on init phase. BTW, the  EHCI
and OHCI that I sent previously also used these cns3xxx_pwr_*() calls.

Would they be supported in near future? If not, I would like look into those.

> Plus, unfortunately this patch breaks build when AHCI_PLATFORM is
> set to =m.
> arch/arm/mach-cns3xxx/built-in.o: In function 'cns3xxx_ahci_softreset':
> cns3420vb.c:(.text+0x36c): undefined reference to 'ahci_do_softreset'
> cns3420vb.c:(.text+0x390): undefined reference to 'ahci_do_softreset'
> cns3420vb.c:(.text+0x3a0): undefined reference to 'ahci_check_ready'
> arch/arm/mach-cns3xxx/built-in.o:(.data+0x35c): undefined reference to 'ahci_ops'
> make: *** [.tmp_vmlinux1] Error 1
Sorry that I didn't notice this. I was trying to reuse ahci-platform
as possible.
Building platform device as module seems strange to me, therefore I
would add a new ahci-platform alike platform driver.

Best Regards,
Mac Lin
