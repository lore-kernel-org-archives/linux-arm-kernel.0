From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 2 Sep 2015 13:58:06 -0400
Subject: [PATCH] ARM: dts: keystone: use one to one address translations
 under netcp
In-Reply-To: <55E730D4.6040102@oracle.com>
References: <1441139324-29296-1-git-send-email-w-kwok2@ti.com>
 <55E61658.9010207@oracle.com>
 <230CBA6E4B6B6B418E8730AC28E6FC7E04221776@DFLE11.ent.ti.com>
 <55E71AB3.7070406@oracle.com> <55E7255A.8060402@ti.com>
 <55E730D4.6040102@oracle.com>
Message-ID: <55E738AE.9000207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2015 01:24 PM, santosh shilimkar wrote:
> On 9/2/2015 9:35 AM, Murali Karicheri wrote:
>> Santosh,
>>

---Cut-------------------

>>> I suspected the same. I know back then we started with SERDES code
>>> with NETCP but as you already know, its a separate block which
>>> is needed for NIC card to work. Its more of phy and hence its
>>> having different address space is not surprising.
>>
>> Using Phy interface is not acceptable to the subsystem maintainer based
>> on the communication I had on this. Also the Phy here is tighly coupled
>> with the hardware block it is working with. So this model is not right
>> for SerDes driver as it require additional enhancements as described
>> below if needs to be used.
>>
> Thanks for update on that.
>
>> The serdes initialization procedure requires checking the status in the
>> hardware block (PCIe, 1G or 10G) and then taking corrective action. This
>> means a Phy driver would require mapping of related hw address space
>> (PCIe, 1G and 10G) as well which is already mapped by the hardware
>> driver(PCIe, 1G and 10G). One solution is to treat this as a libray
>> function that can be called from the respective hardware device driver.
>>   A device node of h/w device (PCIe or 1G) in such as looks like
>>
> Or SerDes driver can embed the status reg address space.
> This is read only access so should be fine.
>
>> pcie {
>>
>>      serdes at someaddress {
>>          reg = <address of serdes>;
>>      }
>> }
>>
>> hw driver will call ks2_serdes_init(node, hw_base_address) to initialize
>> the serdes. Other APIs can be added to enable/disable lane or shutdown
>> etc. The libary will be added to drivers/soc/ti/ and used by various
>> device drivers to initialize and use the phy. As the serdes is slightly
>> integrated with the hardware block, IMO, this is a better approach than
>> using the phy model. The API definitions will be added to
>> include/linux/soc/ti/ folder.
>>
> Serdes Driver with its status register address space might solve this
> sharing problem. Library might work but we should try to have driver
> considering there is a physical device. I don't have strong opinion
> on drivers vs library.
>

In addition to checking status in the SerDes, it needs to also check the 
status of the associated hardware block (PCIe, 1G, 10G etc). So this 
means, same needs to be mapped twice, first by the above hardware device 
drivers and then by the serdes driver which causes problem. My point is 
since they both are tightly coupled, a libary is a better option. That 
way the mapped address can be passed to the serdes API to perform the 
required task, instead of using Phy API which doesn't allow us to do the 
same. If SerDes h/w can be brought up independently, the Phy model fits 
well.

Murali
>
>> The SerDes will use the firmware interface to download and configure the
>> hardware block to use with PCIe/1G/10G/SRIO. I queried the linux forum
>> on this and the response was that firmware interface can be used for
>> this. The patch will be using the firmware interface instead of
>> embedding magic values in the serdes driver.
>>
> Firmware interface usage seems to be correct way.
> Thanks for giving the details. It helped me to get better picture.
>
> Regards,
> Santosh
>
> Regards,
> Santosh
>
>


-- 
Murali Karicheri
Linux Kernel, Keystone
