From: vipin.kumar@st.com (Vipin Kumar)
Date: Mon, 21 Feb 2011 11:56:10 +0530
Subject: [PATCH V5 36/63] ST SPEAr : EMI (Extrenal Memory
	Interface)	controller driver
In-Reply-To: <20110219171320.GO29493@n2100.arm.linux.org.uk>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<942264b07d606a02eb68561c7be559b6a4904961.1295499395.git.viresh.kumar@st.com>
	<20110219171320.GO29493@n2100.arm.linux.org.uk>
Message-ID: <4D620582.40802@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/19/2011 10:43 PM, Russell King - ARM Linux wrote:
> On Thu, Jan 20, 2011 at 12:56:14PM +0530, Viresh Kumar wrote:
>> From: Vipin Kumar <vipin.kumar@st.com>
> 
> 
> Subject: [PATCH V5 36/63] ST SPEAr : EMI (Extrenal Memory Interface)
>         controller driver
> 
> "External"
> 

Sorry!!


>> +	clk = clk_get(NULL, "emi");
> 
> What is the platform device pointer passed into this function?  It seems
> unused - would using &pdev->dev here be appropriate?  Possibly not as it
> seems to be the physmap device.
> 

Yes, the platform device pointer is unused
I would remove it....


>> +void __init
>> +emi_init_board_info(struct platform_device *pdev, struct resource *resources,
>> +		int res_num, struct mtd_partition *partitions,
>> +		unsigned int nr_partitions, unsigned int width)
>> +{
>> +	struct physmap_flash_data *emi_plat_data = dev_get_platdata(&pdev->dev);
>> +
>> +	pdev->resource = resources;
>> +	pdev->num_resources = res_num;
>> +
>> +	if (partitions) {
>> +		emi_plat_data->parts = partitions;
>> +		emi_plat_data->nr_parts = nr_partitions;
>> +	}
>> +
>> +	emi_plat_data->width = width;
>> +}
> 
> I don't see why this has to be code rather than in the platform specific
> files as static initializers.  

The device is instantiated in the machine file and above information comes
from the board file. So we kept them this way.

> Also, you seem to be passing stuff like
> 'EMI_FLASH_WIDTH32' in for 'width', which seems very odd as this is the
> byte width.  I don't see why you need #defined constants for this.
> 
> It's waiting someone who doesn't realise that it has a proper meaning
> to change it to an enum or something like that.
> 
> If you think the physmap flash API is lacking some definitions for this,
> please talk to the MTD people.

Yes. We shouldn't have created new macro's for this. Will be removed.

vipin
