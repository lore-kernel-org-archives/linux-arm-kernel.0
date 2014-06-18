From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 18 Jun 2014 15:20:09 +0530
Subject: [PATCH 1/4] phy: miphy365x: Add Device Tree bindings for the
 MiPHY365x
In-Reply-To: <20140617112353.GB4139@lee--X1>
References: <1400766819-22286-1-git-send-email-lee.jones@linaro.org>
 <1400766819-22286-2-git-send-email-lee.jones@linaro.org>
 <5396E561.4020805@ti.com> <20140617112353.GB4139@lee--X1>
Message-ID: <53A160D1.8000908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 17 June 2014 04:53 PM, Lee Jones wrote:
>>> The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
>>> devices. It has 2 ports which it can use for either; both SATA, both
>>> PCIe or one of each in any configuration.
>>
>> I've asked others who wrote multi-phy PHY providers to model each individual
>> PHY as sub-node of the PHY provider. So It's only fair I ask you the same to
>> do. So in this case the dt node should look something like:
>>
>> 	miphy365x_phy: miphy365x at fe382000 {
>> 		compatible = "st,miphy365x-phy";
>> 		#phy-cells = <2>;
>> 		st,syscfg = <&syscfg_rear>;
>> 		channel at 0 {
>> 			reg =	<0xfe382000 0x100>, <0xfe394000 0x100>;
>> 			reg-names = "sata", "pcie";
>> 		}
>>
>> 		channel at 1{
>> 			reg =	<0xfe38a000 0x100>, <0xfe804000 0x100>;
>> 			reg-names = "sata", "pcie";
>> 		}
>>
>> 	};
> 
> I'm interested to know why you've taken this approach, as it makes the
> code much more complex.  The DT framework goes to the trouble of

It looks to be much closer representation of the hardware in dt. It also
enables to have more control of each individual PHYs. For example, we can have
something like status="disabled" for channels which is disabled.

> converting all addresses to to resources so drivers can easily pull
> them out using platform_get_resource() and friends.  Pushing the reg

right. Can't we use of_address_to_resource here?
> properties down into a child node means that we have to now iterate
> over the sub-nodes and pull them out manually.  This will lead to a

You anyway iterate while creating PHYs based on some constant. Now you have to
iterate over the sub-nodes.
> pretty messy implementation IMHO.


> 
> Can you point me in the direction of previous implementations where you
> have stipulated the same set of constraints please?

ah.. there isn't any. The author of the other multi-phy driver [1] also feels
this will just add to the complexity of the driver.

Maybe we should ask the opinion of others?

[1] -> http://www.spinics.net/lists/linux-sh/msg32087.html
> 
