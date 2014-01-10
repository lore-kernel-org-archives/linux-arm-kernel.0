From: klightspeed@killerwolves.net (Ben Peddell)
Date: Fri, 10 Jan 2014 11:01:06 +1000
Subject: [PATCH RFC RFT 0/2] ARM: Kirkwood: Synology DT files
In-Reply-To: <20140109165557.GB9681@lunn.ch>
References: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
 <52CE312B.3060108@killerwolves.net> <20140109165557.GB9681@lunn.ch>
Message-ID: <52CF4652.3030207@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 05:55:57PM +0100, Andrew Lunn wrote:
> On Thu, Jan 09, 2014 at 03:18:35PM +1000, Ben Peddell wrote:
>> On 07/01/14 09:47, Andrew Lunn wrote:
>>> Request for Testing:
>>>
>>> This patch adds support for around 30 different boards. Most .dts
>>> files support a couple of different models. I don't have any of this
>>> hardware. None of this is tested.
>>
>> Tested by Ben Peddell <klightspeed@killerwolves.net> (specifically kirkwood-ds210.dts on DS211j)
> 
> Hi Ben
> 
> Thanks for testing. I will fix the gpo and send a v2 sometime. I
> should also check if there are any more gpo's i have as gpio's.

There are only a few pins that are GPOs - from 
marvell,kirkwood-pinctrl.txt, they are 
1, 2, 3, 5, 7, 10, 18, 19 and 33.

>  
>> To get running on the stock bootloader, I needed to extend the 
>> initramfs to fill the entire rd.gz flash partition, configure the 
>> kernel to use the dtb appended to it, configure it to ignore the 
>> information passed to it by the bootloader, and add the following 
>> nodes to the dts:
>>
>> /chosen {
>> 	linux,initrd-start = <0x800040>;
>> 	linux,initrd-end   = <0x940000>;
>> };
> 
> Do you know why these initrd properties are needed?  There is only one
> other board in mainline that requires this. I also wonder what
> implications this has. u-boot has the capability of reading the initrd
> from disc to RAM and passing its location to the kernel. By hard
> coding these values, are we blocking that?

The stock Marvell bootloader is a little broken as it passes the kernel
the _source_ address of the initrd rather than the _load_ address.
Thus the bootloader passes the address 0xf8280040 rather than the address
0x00800040.

It appears the initrd address in the devicetree structure (which is 
filled in from what is passed by the bootloader when 
CONFIG_ARM_ATAG_DTB_COMPAT is set) is processed _after_ the address in 
the initrd= kernel parameter is processed.

Rather than putting the initrd address into the DTS, it would probably be
better to have the person compiling the kernel configure it with e.g.:

CONFIG_CMDLINE="initrd=0x00800040,0x0013FFC0 earlyprintk panic=5"
CONFIG_CMDLINE_EXTEND=y
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=n
