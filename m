From: tthayer@opensource.altera.com (Thor Thayer)
Date: Tue, 21 Jun 2016 09:46:40 -0500
Subject: [PATCHv4 4/7] Documentation: dt: socfpga: Add Arria10 Ethernet
 binding
In-Reply-To: <20160621133340.GA9073@rob-hp-laptop>
References: <1466434252-26107-1-git-send-email-tthayer@opensource.altera.com>
 <1466434252-26107-5-git-send-email-tthayer@opensource.altera.com>
 <20160621133340.GA9073@rob-hp-laptop>
Message-ID: <57695350.3050404@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 06/21/2016 08:33 AM, Rob Herring wrote:
> On Mon, Jun 20, 2016 at 09:50:49AM -0500, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Add the device tree bindings needed to support the Altera Ethernet
>> FIFO buffers on the Arria10 chip.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>> v2  No Change
>> v3  Change to common compatible string based on maintainer comments
>>      Add local IRQ values.
>> v4  Add compatible string for parent node.
>> ---
>>   .../bindings/arm/altera/socfpga-eccmgr.txt         |   24 ++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
>> index 15eb0df..7c714ba 100644
>> --- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
>> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
>> @@ -82,6 +82,14 @@ Required Properties:
>>   - interrupts : Should be single bit error interrupt, then double bit error
>>   	interrupt, in this order.
>>
>> +Ethernet FIFO ECC
>> +Required Properties:
>> +- compatible : Should be "altr,socfpga-eth-mac-ecc"
>> +- reg        : Address and size for ECC block registers.
>> +- parent     : phandle to parent (altr,socfpga-stmmac) Ethernet node.
>
> Sorry if I wasn't clear before, but I was suggesting changing 'parent'
> to 'altr,ethernet-mac':
>
> altr,ethernet-mac = <&gmac0>;
>
> Rob
>
Ahh, I see what you're saying.

I used parent as the tag because I have a generic function for 
validating that the parent status is "okay" using the "parent" string in 
my validate_parent_available() function (see below).

I will be submitting other peripheral FIFOs with EDAC protection in 
future patches (USB, DMA, etc).

static int validate_parent_available(struct device_node *np)
{
	struct device_node *parent;
	int ret = 0;

	/* Ensure parent device is enabled if parent node exists */
	parent = of_parse_phandle(np, "parent", 0);
	if (parent && !of_device_is_available(parent))
		ret = -ENODEV;
	of_node_put(parent);
	return ret;
}


I can change this to using a passed in data string but the code won't be 
as straightforward.

Thanks for reviewing,

Thor
