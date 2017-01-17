From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 17 Jan 2017 15:37:10 -0800
Subject: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
In-Reply-To: <20170117222229.GA6534@bhelgaas-glaptop.roam.corp.google.com>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
 <20170117151444.GE22776@bhelgaas-glaptop.roam.corp.google.com>
 <20170117152548.GB27312@n2100.armlinux.org.uk>
 <20170117174649.GA11063@bhelgaas-glaptop.roam.corp.google.com>
 <20170117175115.GD27312@n2100.armlinux.org.uk>
 <20170117175728.GE27312@n2100.armlinux.org.uk>
 <20170117181458.GB11063@bhelgaas-glaptop.roam.corp.google.com>
 <20170117193414.GG27312@n2100.armlinux.org.uk>
 <20170117210258.GH27312@n2100.armlinux.org.uk>
 <20170117222229.GA6534@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <e0ccb7a0-9cc7-c595-7f06-e63c0927f36d@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 02:22 PM, Bjorn Helgaas wrote:
> [+cc David]
>
> On Tue, Jan 17, 2017 at 09:02:58PM +0000, Russell King - ARM Linux wrote:
>> On Tue, Jan 17, 2017 at 07:34:14PM +0000, Russell King - ARM Linux wrote:
>>> Uwe, can you try:
>>>
>>> setpci -s <whatever-the-id-of-the-root-is-it's-blanked-out-in-the-above> \
>>> 	0x50.w=0x60
>>>
>>> and see whether it remains alive (you can check by reading the root
>>> register 0x52.w - bit 12 should be set once bit 11 clears again.
>>
>> For reference, this I got wrong...
>>
>> 0xf1041a04 bit 0 indicates link status (0 = link up, 1 = link down).
>>
>>> If that's successful, maybe setting the common clock bit on the PCIe
>>> device is what's causing the problem, in which case:
>>>
>>> setpci -s 02:00.0 0x80.w=0x40
>>> setpci -s <whatever-the-id-of-the-root-is-it's-blanked-out-in-the-above> \
>>> 	0x50.w=0x60
>>
>> Having worked with Uwe over IRC, it seems that any request to retrain
>> causes the link to go down, either with or without the common clock bit
>> set:
>>
>> # setpci -s 2.0 0x50.w=0x60
>> # setpci -s 2.0 0x52.w
>> 0011
>> # memtool md 0xf1041a04+4
>> f1041a04: 00010201
>> ... reboot ...
>> # setpci -s 2.0 0x50.w=0x20
>> # memtool md 0xf1041a04+4
>> f1041a04: 00010201
>>
>> which doesn't point towards ASPM itself, but the problem is caused by
>> a side effect of ASPM's setup code which always triggers a retrain.
>>
>> Bit 5 in that register is documented (at least in the Armada 370 docs
>> and Armada XP docs I have) as:
>>
>> 5  RetrnLnk  RW    Retrain Link
>>              0x0   This bit forces the device to initiate link retraining.
>>                    Always returns 0 when read.
>>                    NOTE: If configured as an Endpoint, this field is
>>                    reserved and has no effect.
>>
>> Bjorn, are you aware of similar situations where a request for the PCIe
>> link to be retrained causes it to fail?


Link (re)training can fail for several reasons including, but not 
limited to:

- Poor signal propagation through the chips/packages/boards/connectors, 
also known as Signal Integrity (SI) problmes.

- Incorrect implementation, in hardware, of link training protocols at 
either end of the link

Usually, system and PCIe device vendors do a lot of testing and signal 
analysis across a variety of configurations with the end goal being that 
PCIe looks like a bullet-proof interconnect to the end consumer.

Unfortunatly, sometimes it doesn't work.  In these cases, the vendors of 
the devices on each end of the link tend to point fingers at the link 
partner for being detective in some way.

This patch:

>
> The only one that comes to mind is this patch from David (CC'd) that
> avoids ASPM-related retrains when we know the link doesn't support ASPM:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=e53f9a28bee3
>

Is an attempt to work around the problem from the system (host) end.  If 
the system vendor knows a priori that a defective PCIe device is present 
in the system, the PCIe root port can be configured to indicate no ASPM 
is supported, resulting (with the patch) in no link retraining being 
attempted.

To me it feels that we need a black list of devices that fail at a high 
rate in the link retraining, that when encountered would disable ASPM on 
the link where they reside.

Just my $0.02
David Daney


> Side note: it looks like we don't use the recommended retrain
> algorithm in the implementation note about avoiding race conditions in
> PCIe r3.0, sec 7.8.7.
>
