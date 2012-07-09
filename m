From: robherring2@gmail.com (Rob Herring)
Date: Mon, 09 Jul 2012 13:42:06 -0500
Subject: [PATCH 00/15] PCI io.h cleanups
In-Reply-To: <201207091628.37975.arnd@arndb.de>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
 <201207091628.37975.arnd@arndb.de>
Message-ID: <4FFB25FE.8090806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2012 11:28 AM, Arnd Bergmann wrote:
> On Friday 06 July 2012, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> I've finally gotten back to this after several months. This is the 2nd
>> part of mach/io.h removals. This series removes io.h on platforms with
>> PCI by creating a fixed virtual I/O mapping and a common __io() macro.
>>
>> As several platforms have 2 1MB I/O windows, I've changed the fixed
>> mapping to 2MB (vs. 1MB in the prior posting) and allow platforms to
>> control the size. This also allows using a single 1MB section mapping
>> rather than 4KB pages.
> 
> Looks really good, feel free to add my Reviewed-by on patches 2-15, since
> I've done a line-by-line walkthrough and could not find anything besides the
> trivial comments I gave.

Thanks for the review. It's going to change a bit with using
ioremap_page_range. Hope to have new version out soon.

>> I've only tested versatilepb under qemu, so any testing is appreciated.
>> iop3xx and mv78xx0 have some risk of breaking as the PCI bus addresses
>> are moved to 0 from matching the cpu host bus addesss.
> 
> Did you try running any devices that actually use I/O space in qemu?
> I think there are plenty of devices that you could use for testing that.

I had with sym53c8xx, but it defaulted to memory accesses. Now that I
enable i/o access mode, it fails due to pcibios_min_io = 0x44000000.
With that removed it gets into the driver setup but then fails (with or
without my changes). Might be a qemu model issue. I'll try some other
devices.

Rob

> 
> 	Arnd
> 
