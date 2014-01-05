From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 05 Jan 2014 18:37:21 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <20140105172756.GA11280@obsidianresearch.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
 <201401051525.52459.arnd@arndb.de> <20140105154023.GA2048@lunn.ch>
 <20140105172756.GA11280@obsidianresearch.com>
Message-ID: <52C99851.70806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2014 06:27 PM, Jason Gunthorpe wrote:
> On Sun, Jan 05, 2014 at 04:40:23PM +0100, Andrew Lunn wrote:
>>>> +static int __init mvebu_soc_id_init(void)
>>>> +{
>>>> +	struct device_node *np;
>>>> +	int ret = 0;
>>>> +
>>>> +	np = of_find_matching_node(NULL, mvebu_pcie_of_match_table);
>>>> +	if (np) {
>>>> +		void __iomem *pci_base;
>>>> +		struct clk *clk;
>>>> +		/*
>>>> +		 * ID and revision are available from any port, so we
>>>> +		 * just pick the first one
>>>> +		 */
>>>> +		struct device_node *child = of_get_next_child(np, NULL);
>>>
>>> I guess all this will fail if for some reason the PCIe node is not
>>> present on machines that don't use PCIe.
>>
>> That would be rather odd. These nodes are in the top level SoC dtsi
>> file. When they are not used, they have status = "disabled" and are in
>> the dtb blob with this state.
>
> Hang on, you can't safely read from a disabled PCI node, it could have been
> powered down by the bootloader..

If you mean clock-gated with "powered down", the code is safe. It
enables the clock gate prior reading from the controller. Or is there
another way to power down the controller, so you cannot read from the
controller registers?

Sebastian

Sebastian
