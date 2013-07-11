From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Thu, 11 Jul 2013 09:03:59 +0200
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <51DD9A8C.10608@keymile.com>
References: <51DD88A4.1030506@keymile.com> <20130710185706.72b124a4@skate>
 <51DD9A8C.10608@keymile.com>
Message-ID: <51DE58DF.5010304@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gerlando,

I just want to give further information about  the hardware and memory mapping
we have with these kirkwood variants in our system.

As I told you yesterday, I think it's very important to have a clear view of the
actual memory map when setting these ranges.

On 07/10/2013 07:31 PM, Falauto, Gerlando wrote:
> Hi Thomas,
> 
> first of all thanks for your quick feedback.
> 
> On 07/10/2013 06:57 PM, Thomas Petazzoni wrote:
>> Gerlando,
>>
>> On Wed, 10 Jul 2013 18:15:32 +0200, Gerlando Falauto wrote:
>>
>>> I am trying to use the pci-mvebu driver on one of our km_kirkwood
>>> boards. The board is based on Marvell's 98dx4122, which should
>>> essentially be 6281 compatible.
>>
>> Was this platform working with the old PCIe driver in mach-kirkwood/ ?
> 
> Yes, though we had to trick it a little bit to get both the internal 
> switch and this PCIe device working:
> 
> - this PCIe device requires to map 256M of memory as opposed to just 128

On the board you are currently using for your tests, it is the case (the whole
map is not used ... things are scattered over the 256 MB, with one 128MB BAR).
If you want to get rid of this problem, we have another board that does not
require these (256 MB .. and I have one of them on my desk that you can use for
your tests).

On the kirkwood variant we use, there is only _one_ real PCIe controller. In
order to map 256MB for the MEM space of this controller without having further
memory map conflicts, what was done was to not enable the CPU windows for the
usual 2nd PCIe controller and set a wider CPU window for the MEM space of the
only PCIe controller.

> - we need a virtual PCIe device to connect to the internal switch, which 
> must be mapped at 0xf4000000 (normally used for the NAND which must then 
> move to 0xff000000)
> 

I think you can forget this for the time being. This is called (also in
Marvell's doc) a virtual PCIe controller, but apart that it is then memory
mapped, this has nothing to do with PCIe (although I don't know what is done
internally in the SoC). It is a problem because the physical address chosen for
this CPU window conflicts with the one that is used for the NAND controller in
the current kirkwood Linux memory map. But this is another topic and it should
not play any role in this PCIe topic.

I hope this helps also the other better understand what's going on here.

Valentin
