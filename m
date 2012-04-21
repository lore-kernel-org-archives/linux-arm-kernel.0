From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 21 Apr 2012 17:53:00 +0530
Subject: [PATCH 2/9] SPEAr13xx: Add source files
In-Reply-To: <201204201815.57556.arnd@arndb.de>
References: <cover.1334942163.git.viresh.kumar@st.com>
 <33fcf4e1f6f1d33bcfedc428e0feca74a340b580.1334942163.git.viresh.kumar@st.com>
 <201204201815.57556.arnd@arndb.de>
Message-ID: <CAOh2x=mFk4j3+5-gMG1gbpJ6tPMDz1ArYQyL2=cBGfH+B9eLWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/20/12, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 20 April 2012, Viresh Kumar wrote:
>
>> +static struct dw_dma_slave uart1_dma_param[] = {
>> +	{
> Again, I hope that we can remove this eventually when we have the DMA
> bindings, but it's ok for now.

Surely try do later, once those DT bindings are up.

>> +/* SATA device registration */
>> +static int sata_miphy_init(struct device *dev, void __iomem *addr)
>> +{
>> +	writel(SPEAR1340_SATA_CFG_VAL, SPEAR1340_PCIE_SATA_CFG);
>> +	writel(SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK,
>> +			SPEAR1340_PCIE_MIPHY_CFG);
>> +	/* Switch on sata power domain */
>> +	writel((readl(SPEAR1340_PCM_CFG) | (0x800)), SPEAR1340_PCM_CFG);
>> +	msleep(20);
>> +	/* Disable PCIE SATA Controller reset */
>> +	writel((readl(SPEAR1340_PERIP1_SW_RST) & (~0x1000)),
>> +			SPEAR1340_PERIP1_SW_RST);
>> +	msleep(20);
>> +
>> +	return 0;
>> +}
>> +
>> +void sata_miphy_exit(struct device *dev)
>> +{
>> +	writel(0, SPEAR1340_PCIE_SATA_CFG);
>> +	writel(0, SPEAR1340_PCIE_MIPHY_CFG);
>> +
>> +	/* Enable PCIE SATA Controller reset */
>> +	writel((readl(SPEAR1340_PERIP1_SW_RST) | (0x1000)),
>> +			SPEAR1340_PERIP1_SW_RST);
>> +	msleep(20);
>> +	/* Switch off sata power domain */
>> +	writel((readl(SPEAR1340_PCM_CFG) & (~0x800)), SPEAR1340_PCM_CFG);
>> +	msleep(20);
>> +}
>> +
>> +int sata_suspend(struct device *dev)
>> +{
>> +	if (dev->power.power_state.event == PM_EVENT_FREEZE)
>> +		return 0;
>> +
>> +	sata_miphy_exit(dev);
>> +
>> +	return 0;
>> +}
>
> I'd like to see this done differently, with a ahci_spear driver derived from
> ahci_platform that provides these functions in a modular driver that
> registers
> to a spear specific identifier string and is able to do the platform
> specific
> based on information it can find in the device tree. That would however
> require
> changes to the existing ahci_platform code and I'd first like to hear what
> Jeff and others have to say about this.

To get platform data for ahci with DT, we need to do as mentioned by you.
But for now maybe we can accept this approach. Once somebody fix ahci
DT support as you suggested, we could create such drivers.

--
viresh
