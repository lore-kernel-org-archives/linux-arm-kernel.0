From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 06 Jan 2014 11:28:11 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <201401051525.52459.arnd@arndb.de>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
 <201401051525.52459.arnd@arndb.de>
Message-ID: <52CA853B.5010200@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2014 15:25, Arnd Bergmann wrote:
> On Friday 03 January 2014, Gregory CLEMENT wrote:
>> All the mvebu SoCs have information related to their variant and
>> revision that can be read from the PCI control register.
>>
>> This patch adds support for Armada XP and Armada 370. This reading of
>> the revision and the ID are done before the PCI initialization to
>> avoid any conflicts. Once these data are retrieved, the resources are
>> freed to let the PCI subsystem use it.
> 
> I like the idea of identifying the soc version for any number of
> reasons, but I would hope there was some way of doing this that didn't
> involve probing the PCI device. I know this is the traditional way
> on orion/kirkwood/dove/... but it always felt wrong to me.

Unfortunately there is no other way to get this ID. It is not a
"traditional" way of doing it, it just the only way to get this
information given the design of the hardware

> 
>> +static u32 soc_dev_id;
>> +static u32 soc_rev;
>> +static bool is_id_valid;
> 
> Would it be reasonable to reuse the global "system_rev" variable for this
> rather than a platform specific exported function?
> 
>> +static const struct of_device_id mvebu_pcie_of_match_table[] = {
>> +	{ .compatible = "marvell,armada-xp-pcie", },
>> +	{ .compatible = "marvell,armada-370-pcie", },
>> +	{},
>> +};
>> +
>> +int mvebu_get_soc_id(u32 *dev, u32 *rev)
>> +{
>> +	if (is_id_valid) {
>> +		*dev = soc_dev_id;
>> +		*rev = soc_rev;
>> +		return 0;
>> +	} else
>> +		return -1;
>> +}
>> +
>> +EXPORT_SYMBOL(mvebu_get_soc_id);
> 
> Maybe EXPORT_SYMBOL_GPL, out of principle?
> 
>> +static int __init mvebu_soc_id_init(void)
>> +{
>> +	struct device_node *np;
>> +	int ret = 0;
>> +
>> +	np = of_find_matching_node(NULL, mvebu_pcie_of_match_table);
>> +	if (np) {
>> +		void __iomem *pci_base;
>> +		struct clk *clk;
>> +		/*
>> +		 * ID and revision are available from any port, so we
>> +		 * just pick the first one
>> +		 */
>> +		struct device_node *child = of_get_next_child(np, NULL);
> 
> I guess all this will fail if for some reason the PCIe node is not
> present on machines that don't use PCIe.

yes it fails but then this function exits with an error (a more accurate
error in the next version). It will be the responsibility of the code which
need this information to check that this function won't fail. For the i2c
driver, for instance, we will switch on the safe mode and it won(y use
the offload mechanism.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
