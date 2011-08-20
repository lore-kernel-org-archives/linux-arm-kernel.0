From: robherring2@gmail.com (Rob Herring)
Date: Sat, 20 Aug 2011 13:21:01 -0500
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <20110820144806.GB13302@S2100-06.ap.freescale.net>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
	<20110820144806.GB13302@S2100-06.ap.freescale.net>
Message-ID: <4E4FFB0D.9060707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2011 09:48 AM, Shawn Guo wrote:
> On Tue, Aug 16, 2011 at 03:34:54PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This adds basic support for the Calxeda Highbank platform.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
> [...]
>> +void highbank_init_irq(void)
>> +{
>> +	struct device_node *node;
>> +	struct of_intc_desc desc;
>> +	int n = 0;
>> +
>> +	memset(&desc, 0, sizeof(desc));
>> +	desc.controller = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
>> +	gic_of_init(&desc);
>> +	node = desc.controller;
>> +	for_each_child_of_node(node, desc.controller) {
>> +		gic_of_ppi_init(&desc);
>> +	}
>> +
>> +	for_each_compatible_node(node, NULL, "arm,pl061") {
>> +		irq_domain_add_simple(node, 160 + (8 * n));
>> +		n++;
>> +	}
>> +
> 160, magic number?  I guess it's the GIC IRQ number has been
> discovered in gic_dist_init().  I'm not sure if we should simply
> define a macro for it or manage to retrieve it from GIC.

It's the number of GIC irqs. This is temporary until we have dynamic
assignment of linux irq numbers.

Rob
