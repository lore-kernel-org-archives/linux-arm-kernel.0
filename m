From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Mon, 12 Sep 2016 10:40:54 +0800
Subject: [RFD] hix5hd2 datasheet?
In-Reply-To: <37ac958a-2196-349d-6af9-995067f1bdb8@gmail.com>
References: <dae6535c-13f2-7d79-d938-30b1a6fb4afc@gmail.com>
 <57D2740C.10000@hisilicon.com>
 <37ac958a-2196-349d-6af9-995067f1bdb8@gmail.com>
Message-ID: <57D615B6.9060700@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2016/9/11 8:47, Marty Plummer wrote:
> On 09/09/2016 03:34 AM, Wei Xu wrote:
>> Hi Marty,
>>
>> On 08/09/2016 23:58, Marty Plummer wrote:
>>> Hello,
>>>
>>> 	I'm currently working to get the ethernet interface for the
>>> hi3520 SoC to work, and I think (emphasis on think) the hix5hd2-gmac
>>> driver is compatible, or nearly so, as checking the sdk source code
>>> for the interface has a fairly large amount of similar code (well, as
>>> similar as 2.6.24 vs 4.8-rc4 code can be) and identical register
>>> definitions to the very bit, so I was hoping to compare the datasheets
>>> and see how far the commonality goes. Plus, having the datasheets
>>> readily available will be of assistance to anyone else looking to
>>> contribute.
>>
>> +Jiancheng into this mail group.
>> Maybe you could get the hix5hd2 datasheets from him.
>> Thanks!
>>
Currently, the complete datasheet can only be released to customers and
partners who have signed NDA with hisilicon. We have no public version
to supply in this case. I'll point out this issue internally. I hope we can
get the solution.

>> Best Regards,
>> Wei
>>
>>>
>>> Thanks,
>>> 	Marty
>>>
>>>
>>
> In additon, I'm wondering how the second reg property for the
> hix5hd2-gmac devicetree is determined (in fact, that is my main concern),
> as I'm pretty sure it will work with the gmac on hi3520, but I can't
> find a register in the hi3520 datasheet that I could 100% say is the
> right one, and adding the driver to the initrd causes a kernel panic
> (I'm assuming this is because of wrong reg values unless otherwise
> proven) on an otherwise mostly working kernel.
> 

As being described in the ./Documentation/devicetree/bindings/net/hisilicon-hix5hd2-gmac.txt,
the second reg property means MAC_IF control register. The bits layout in this register of
hix5hd2 is like this:
  Bits       	Access     	Name			Description
[31:20]      	RO         	reserved		reserved
[19]		RO		phy_link_status		0:Link Down 1:Link Up
[18:17]		RO		phy_link_speed		00:2.5MHz 01:25MHz 10:125MHz 11:reserved
[16]		RO		phy_link_mode		0:full duplex 1:half duplex
[15:9]		RO		reserved		reserved
[8]		RW		loopback_mode		0:disable 1:enable
[7:5]		RW		phy_select		000:GMII/MII Mode 001:RGMII mode 002:RMII mode
[4]		RW		duplex_mode		0:full 1:half
[3]		RW		tx_config		0:disable 1:enable
[2]		RW		link_status		0:Link Down 1:Link Up
[1]		RW		mac_speed		0:10Mbps 1:100Mbps
[0]		RW		port_select		0:1000Mbps 1:10/1000Mbps

I have no hi3520 datasheet,either.I'm not sure about that they use the same gmac IP block.
I hope this information can help you.

Regards,
Jiancheng
