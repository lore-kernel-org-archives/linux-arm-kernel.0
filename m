From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 5 Jan 2017 04:46:32 +0000
Subject: [PATCHv2 2/5] arm: mvebu: support for SMP on 98DX3336 SoC
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <20170105033641.6212-3-chris.packham@alliedtelesis.co.nz>
 <5edb6751-d15b-6654-f4ae-adf38fafb8a4@gmail.com>
Message-ID: <dd384eda81d2420dafe740bf5bb4dae0@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/17 17:04, Florian Fainelli wrote:
> Le 01/04/17 ? 19:36, Chris Packham a ?crit :
>> Compared to the armada-xp the 98DX3336 uses different registers to set
>> the boot address for the secondary CPU so a new enable-method is needed.
>> This will only work if the machine definition doesn't define an overall
>> smp_ops because there is not currently a way of overriding this from the
>> device tree if it is set in the machine definition.
>
> Not sure I follow you here, in theory, each individual CPU could have a
> different enable-method property, and considering how you leverage
> existing DTS include files, you should be able to override the DTS with
> the appropriate enable-method, or do you have a different problem?
>

The problem is I can't override the enable method if it's set in the 
machine definition. It's because the devicetree is looked up first then 
the machine definition overrides it.

Heres an old thread that basically outlines the problem.

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300371.html

I posted a few attempts to work around it but there never really was any 
consensus reached.

>  mv98dx3236_resume_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
>> +{
>> +	WARN_ON(hw_cpu != 1);
>> +
>> +	writel(0, mv98dx3236_resume_base + MV98DX3236_CPU_RESUME_CTRL_OFFSET);
>> +	writel(virt_to_phys(boot_addr), mv98dx3236_resume_base +
>> +	       MV98DX3236_CPU_RESUME_ADDR_OFFSET);
>
> I just submitted a patch series that switches such users to
> __pa_symbol() instead of virt_to_phys() because this is a kernel image
> symbol. For now this will work as-is, but depending on which patch
> series makes it first, it may be a good idea to keep this on someone's
> TODO list (yours or mine). I do expect having to make a second pass of
> conversions anyway.
>
> [1]: https://lkml.org/lkml/2017/1/4/1101

OK I'll keep that in mind.

>
>> +}
>> +
>> +static int __init mv98dx3236_resume_init(void)
>> +{
>> +	struct device_node *np;
>> +	struct resource res;
>> +	int ret = 0;
>> +
>> +	np = of_find_matching_node(NULL, of_mv98dx3236_resume_table);
>> +	if (!np)
>> +		return 0;
>> +
>> +	pr_info("Initializing 98DX3236 Resume\n");
>
> This can be probably be dropped, you should know fairly quickly if this
> succeeded or not.

Will do.

>
> Can't this function be implemented as a smp_ops::smp_init_cpus instead
> of having this initialization done at arch_initcall time?
>

I'll look into it. My initial reaction is no because I still need 
armada_xp_smp_init_cpus().

>> +
>> +	if (of_address_to_resource(np, 0, &res)) {
>> +		pr_err("unable to get resource\n");
>> +		ret = -ENOENT;
>> +		goto out;
>> +	}
>> +
>> +	if (!request_mem_region(res.start, resource_size(&res),
>> +				np->full_name)) {
>> +		pr_err("unable to request region\n");
>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>
> You should be able to use of_io_request_and_map() and here.
>

Will do.
