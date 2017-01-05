From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 5 Jan 2017 04:34:55 +0000
Subject: [PATCHv2 4/5] arm: mvebu: Add device tree for 98DX3236 SoCs
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <20170105033641.6212-5-chris.packham@alliedtelesis.co.nz>
 <1ee850ee-f771-1aeb-6b96-dfbe3118f2fc@gmail.com>
Message-ID: <ac117de5855d45ffa39cf7f7fd8cfbe8@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/17 17:06, Florian Fainelli wrote:
> Le 01/04/17 ? 19:36, Chris Packham a ?crit :
>> The Marvell 98DX3236, 98DX3336, 98DX4521 and variants are switch ASICs
>> with integrated CPUs. They are similar to the Armada XP SoCs but have
>> different I/O interfaces.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>> +
>> +		switch {
>> +			packet-processor at 0 {
>> +				compatible = "marvell,prestera-98dx4521";
>> +			};
>> +		};
>
> This may be a bit premature if you are not providing a binding document
> for this sub-node, you might as well add it once you also add a
> corresponding driver (or if this will remain out of tree, at least
> submitting a separate binding document).

I also see that I made a typo 4521 should be 4251.

The driver that uses this is an out of tree one so I will add a binding 
document for it for now.

It wouldn't he hard to whip up a simple uio based driver that provides 
mmap access to the switch register space so I might look at that if I 
get time. It would be useful for testing if nothing else.

>
> Also, if this node's unit address is 0, you would expect at least a reg
> property whose address cell is 0 to be present.
>

The reg property is in the base 98dx3236 dsti file. The 3 devices have 
the same IO footprint but the switching functionality is quite different 
between them hence the different compatible strings (all of which I need 
to add binding documentation for). I guess I could make the 3236 entry

   pp0: packet-processor at 0 {
       compatible = "marvell,prestera-98dx3236";
       reg = <0 0x4000000>;
       ...
   }

Then the 3336 and 4251 could just override the compatible string

   &pp0 {
       compatible = "marvell,prestera-98dx4251";
   };

Would that be clearer?
