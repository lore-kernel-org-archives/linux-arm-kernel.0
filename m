From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 2 Sep 2015 12:35:38 -0400
Subject: [PATCH] ARM: dts: keystone: use one to one address translations
 under netcp
In-Reply-To: <55E71AB3.7070406@oracle.com>
References: <1441139324-29296-1-git-send-email-w-kwok2@ti.com>
 <55E61658.9010207@oracle.com>
 <230CBA6E4B6B6B418E8730AC28E6FC7E04221776@DFLE11.ent.ti.com>
 <55E71AB3.7070406@oracle.com>
Message-ID: <55E7255A.8060402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh,

On 09/02/2015 11:50 AM, santosh shilimkar wrote:
> On 9/2/2015 8:31 AM, Kwok, WingMan wrote:
>>
>>
>>> -----Original Message-----
>>> From: santosh.shilimkar at oracle.com [mailto:santosh.shilimkar at oracle.com]
>>> Sent: Tuesday, September 01, 2015 5:19 PM
>>> To: Kwok, WingMan; robh+dt at kernel.org; pawel.moll at arm.com;
>>> mark.rutland at arm.com; ijc+devicetree at hellion.org.uk;
>>> galak at codeaurora.org;
>>> linux at arm.linux.org.uk; devicetree at vger.kernel.org; linux-arm-
>>> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
>>> ssantosh at kernel.org
>>> Cc: Karicheri, Muralidharan
>>> Subject: Re: [PATCH] ARM: dts: keystone: use one to one address
>>> translations
>>> under netcp
>>>
>>> On 9/1/15 1:28 PM, WingMan Kwok wrote:
>>>> Network subsystem NetCP in Keystone-2 devices includes some HW blocks
>>>> that are memory mapped to ranges outside that of the NetCP itself.
>>>> Thus address space of a child node of the NetCP node needs to be
>>>> mapped 1:1 onto the parent address space.  Hence empty ranges
>>>> should be used under the NetCP node.
>>>>
>>>> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
>>>> ---
>>>>    arch/arm/boot/dts/k2e-netcp.dtsi  |    8 +++-----
>>>>    arch/arm/boot/dts/k2hk-netcp.dtsi |   14 ++++++--------
>>>>    arch/arm/boot/dts/k2l-netcp.dtsi  |    8 +++-----
>>>>    3 files changed, 12 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/k2e-netcp.dtsi b/arch/arm/boot/dts/k2e-
>>> netcp.dtsi
>>>> index b13b3c9..e103ed9 100644
>>>> --- a/arch/arm/boot/dts/k2e-netcp.dtsi
>>>> +++ b/arch/arm/boot/dts/k2e-netcp.dtsi
>>>> @@ -111,9 +111,7 @@ netcp: netcp at 24000000 {
>>>>        compatible = "ti,netcp-1.0";
>>>>        #address-cells = <1>;
>>>>        #size-cells = <1>;
>>>> -
>>>> -    /* NetCP address range */
>>>> -    ranges = <0 0x24000000 0x1000000>;
>>>> +    ranges;
>>>>
>>> What blocks are we talking here. We need to increase the
>>> range if the current range isn't covering entire NETCP
>>> address space. Removing range isn't a solution.
>>>
>>
>> The Serdes.  It is a HW block inside the NetCP but its address
>> space starts from 0x0232a000.  We can change the base in the
>> ranges property to include the serdes.  But then offsets of
>> other HW blocks that are within the NetCP address range will be
>> relative to this new base and are not as documented in the HW
>> user guides.
>>
> I suspected the same. I know back then we started with SERDES code
> with NETCP but as you already know, its a separate block which
> is needed for NIC card to work. Its more of phy and hence its
> having different address space is not surprising.

Using Phy interface is not acceptable to the subsystem maintainer based 
on the communication I had on this. Also the Phy here is tighly coupled 
with the hardware block it is working with. So this model is not right 
for SerDes driver as it require additional enhancements as described 
below if needs to be used.

The serdes initialization procedure requires checking the status in the 
hardware block (PCIe, 1G or 10G) and then taking corrective action. This 
means a Phy driver would require mapping of related hw address space 
(PCIe, 1G and 10G) as well which is already mapped by the hardware 
driver(PCIe, 1G and 10G). One solution is to treat this as a libray 
function that can be called from the respective hardware device driver. 
  A device node of h/w device (PCIe or 1G) in such as looks like

pcie {

	serdes at someaddress {
		reg = <address of serdes>;
	}
}

hw driver will call ks2_serdes_init(node, hw_base_address) to initialize 
the serdes. Other APIs can be added to enable/disable lane or shutdown 
etc. The libary will be added to drivers/soc/ti/ and used by various 
device drivers to initialize and use the phy. As the serdes is slightly 
integrated with the hardware block, IMO, this is a better approach than 
using the phy model. The API definitions will be added to 
include/linux/soc/ti/ folder.

The SerDes will use the firmware interface to download and configure the 
hardware block to use with PCIe/1G/10G/SRIO. I queried the linux forum 
on this and the response was that firmware interface can be used for 
this. The patch will be using the firmware interface instead of 
embedding magic values in the serdes driver.

Murali

>
> IIRC, there was a plan to consolidate the serdes code together
> since the PCIE also needs it. Irrespective of that, I suggest
> you model the serdes address space in another node and fetch
> it from there if that works for you. Please also add DTS
> documentation if you are going ahead with that approach.
>

> Regards,
> Santosh
>
>
>
>
>


-- 
Murali Karicheri
Linux Kernel, Keystone
