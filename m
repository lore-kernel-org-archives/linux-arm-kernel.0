From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu, 11 Jan 2018 15:03:50 -0800
Subject: [linux, dev-4.10, 6/6] drivers/hwmon: Add a driver for a generic
 PECI hwmon
In-Reply-To: <20180111214035.GA14748@roeck-us.net>
References: <20180109223126.13093-7-jae.hyun.yoo@linux.intel.com>
 <20180110214747.GA25248@roeck-us.net>
 <261ac28e-813c-a058-c81f-ad4e718d0233@linux.intel.com>
 <20180111214035.GA14748@roeck-us.net>
Message-ID: <7c9ba56d-bd1a-c9cb-8986-4f749ae55edb@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/11/2018 1:40 PM, Guenter Roeck wrote:
> On Thu, Jan 11, 2018 at 11:47:01AM -0800, Jae Hyun Yoo wrote:
>> On 1/10/2018 1:47 PM, Guenter Roeck wrote:
>>> On Tue, Jan 09, 2018 at 02:31:26PM -0800, Jae Hyun Yoo wrote:
>>>> This commit adds driver implementation for a generic PECI hwmon.
>>>>
>>>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> [ ... ]
> 
>>>> +
>>>> +	if (priv->temp.tcontrol.valid &&
>>>> +	    time_before(jiffies, priv->temp.tcontrol.last_updated +
>>>> +				 UPDATE_INTERVAL_MIN))
>>>> +		return 0;
>>>> +
>>>
>>> Is the delay necessary ? Otherwise I would suggest to drop it.
>>> It adds a lot of complexity to the driver. Also, if the user polls
>>> values more often, that is presumably on purpose.
>>>
>>
>> I was intended to reduce traffic on PECI bus because it's low speed single
>> wired bus, and temperature values don't change frequently because the value
>> is sampled and averaged in CPU itself. I'll keep this.
>>
> Then please try to move the common code into a single function.
> 

That makes sense. I'll move the common code into a single function.

> [ ... ]
> 
>>>> +
>>>> +	rc = of_property_read_u32(np, "cpu-id", &priv->cpu_id);
>>>
>>> What entity determines cpu-id ?
>>>
>>
>> CPU ID numbering is determined by hardware SOCKET_ID strap pins. In this
>> driver implementation, cpu-id is being used as CPU client indexing.
>>
> Seems to me the necessary information to identify a given CPU should
> be provided by the PECI core. Also, there are already "cpu" nodes
> in devicetree which, if I recall correctly, may include information
> such as CPU Ids.
> 

This driver is implemented to support only BMC (Baseboard Management 
Controllers) chipset which is running on a separated linux kernel from a 
host server system. Through a PECI connection between them, this driver 
collects the host server system's CPU and DIMM temperature information 
which is running on a separated OS. That could be a linux, a Windows OS 
or any other OSes. I mean, there is no shared devicetree data between 
them so it is why the 'cpu_id' was added into dt configuration of this 
driver.

Using quite limited hardware connections such as PECI, KSC, eSPI and 
SMBus, the BMC manages the host server and this hwmon is one of features 
of BMC.

>>>> +	if (rc || priv->cpu_id >= CPU_ID_MAX) {
>>>> +		dev_err(dev, "Invalid cpu-id configuration\n");
>>>> +		return rc;
>>>> +	}
>>>> +
>>>> +	rc = of_property_read_u32(np, "dimm-nums", &priv->dimm_nums);
>>>
>>> This is an odd devicetree attribute. Normally the number of DIMMs
>>> is dynamic. Isn't there a means to get all that information dynamically
>>> instead of having to set it through devicetree ? What if someone adds
>>> or removes a DIMM ? Who updates the devicetree ?
>>>
>>
>> It means the number of DIMM slots each CPU has, doesn't mean the number of
>> currently installed DIMM components. If a DIMM is inserted a slot, CPU
>> reports its actual temperature but on empty slot, CPU reports 0 instead of
>> reporting an error so it is the reason why this driver enumerates all DIMM
>> slots' attribute.
>>
> And there is no other means to get the number of DIMM slots per CPU ?
> It just seems to be that this is the wrong location to provide such
> information.
> 

This devicetree attribute will be configured at runtime using dt overlay 
based on the host server's hardware configuration which will be parsed 
and managed by a userspace BMC service.

> [ ... ]
> 
>>>> +
>>>> +static const struct of_device_id peci_of_table[] = {
>>>> +	{ .compatible = "peci-hwmon", },
>>>
>>> This does not look like a reference to some piece of hardware.
>>>
>>
>> This driver provides generic PECI hwmon function to which controller has
>> PECI HW such as Aspeed or Nuvoton BMC chip so it's not dependant on a
>> specific hardware. Should I remove this or any suggestion?
>>
> 
> I don't really know enough about the system to make a recommendation.
> It seems to me that the PECI core should identify which functionality
> it supports and instantiate the necessary driver(s). Maybe there should
> be sub-nodes to the peci node with relevant information. Those sub-nodes
> should specify the supported functionality in more detail, though -
> such as indicating the supported CPU and/or DIMM sensors.
> 
> Guenter
> 

As I explained above, BMC and host server are running on separated OSes 
so this driver cannot be (actually, doesn't need to be) directly 
associated with other kernel modules in the BMC side OS for identifying 
the host server system's functionality. My thought is, this driver will 
use PECI only for identifying the host server's CPU and DIMM information 
and the userspace BMC service could deliver any additional host server 
information thru dt overlay if needed before the BMC service initiates 
this driver at runtime.

Thanks a lot,

Jae
