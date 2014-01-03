From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 03 Jan 2014 20:25:41 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <20140103194800.2d3ca026@skate>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>	<1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
 <20140103194800.2d3ca026@skate>
Message-ID: <52C70EB5.2000505@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2014 19:48, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Fri,  3 Jan 2014 10:59:44 +0100, Gregory CLEMENT wrote:
>> +static int __init mvebu_soc_id_init(void)
>> +{
>> +	struct device_node *np;
>> +	int ret = 0;
>> +
>> +	np = of_find_matching_node(NULL, mvebu_pcie_of_match_table);
>> +	if (np) {
> 
> Change this to:
> 
> 	if (!np)
> 		return 0;
> 
> so that you avoid indenting the entire function code inside the if
> { ... } block.

ok

> 
>> +		void __iomem *pci_base;
>> +		struct clk *clk;
>> +		/*
>> +		 * ID and revision are available from any port, so we
>> +		 * just pick the first one
>> +		 */
>> +		struct device_node *child = of_get_next_child(np, NULL);
> 
> Maybe check that child is not NULL here?

yes I was a little lazy with it: if child is NULL then of_clk_get_by_name
will return an error but then the error message will be a misleading.

> 
>> +
>> +		clk = of_clk_get_by_name(child, NULL);
>> +		if (IS_ERR(clk)) {
>> +			pr_err("%s: cannot get clock\n", __func__);
> 
> I think you should rather do:
> 
> #define pr_fmt(fmt) "mvebu-soc-id: " fmt
> 
> at the beginning of your C file and get rid of the "%s" for the
> __func__.

ok thanks for the tip
> 
>> +		/* SoC ID */
>> +		soc_dev_id = __raw_readl(pci_base + PCIE_DEV_ID_OFF) >> 16;
>> +
>> +		/* SoC revision */
>> +		soc_rev = __raw_readl(pci_base + PCIE_DEV_REV_OFF)
>> +			& SOC_REV_MASK;
> 
> Use readl() for both of these reads. __raw_readl() will not work
> properly when the system is booted big-endian.

ok

> 
>> +	return ret;
>> +}
>> +arch_initcall(mvebu_soc_id_init);
> 
>> +#ifdef CONFIG_ARCH_MVEBU
>> +int mvebu_get_soc_id(u32 *dev, u32 *rev);
>> +#else
>> +int mvebu_get_soc_id(u32 *dev, u32 *rev)
> 
> Missing "static inline". Without these, if this header file is included
> more than once, you will have two times the same symbol defined.
> 

ok
> Best regards,
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
