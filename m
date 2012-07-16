From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jul 2012 09:03:15 -0500
Subject: [PATCH v2 00/15] PCI io.h clean-up
In-Reply-To: <20120716075214.GA2489@lunn.ch>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <20120716075214.GA2489@lunn.ch>
Message-ID: <50041F23.2010908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2012 02:52 AM, Andrew Lunn wrote:
> On Fri, Jul 13, 2012 at 09:03:56PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This is the 2nd part of mach/io.h removals. This series removes io.h on
>> platforms with PCI by creating a fixed virtual I/O mapping and a common
>> __io() macro.
> 
> Hi Rob
> 
> Time to show my ignorance of PCI again.
> 
> root at orion5x:~# cat /proc/ioports 
> 00001000-0000ffff : PCI0 I/O
> 00010000-0001ffff : PCI1 I/O
> 
> The changes you made for Orion decreased the window to 64K. However, i
> see here that PCI0 only gets 60K, where as PCI1 gets the full 64K.
> 
> Is this asymmetry correct?

First, thanks for testing.

PC's only have 64K, so that should be enough for any platform. 0-0x1000
is reserved for legacy ISA range. Even if we set the start to 0,
pcibios_min_io would still limit it to above 0x1000.

Also, based on the address translation masking on these platforms, I
believe it should be okay to start the PCI bus address on a 64K boundary.

Rob

> 
> I see this for both orion5x and kirkwood.
> 
>    Thanks
> 	Andrew
> 
