From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Feb 2012 08:45:39 +0000
Subject: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4F2918F6.9040100@ti.com>
References: <4F22DEF2.5000807@ti.com>
 <20120128180602.GC2501@ponder.secretlab.ca>
 <20120131230928.GA8394@n2100.arm.linux.org.uk> <4F2918F6.9040100@ti.com>
Message-ID: <20120202084539.GC1275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 11:50:30AM +0100, Cousson, Benoit wrote:
> Hi Russell,
>
> On 2/1/2012 12:09 AM, Russell King - ARM Linux wrote:
>> On Sat, Jan 28, 2012 at 11:06:02AM -0700, Grant Likely wrote:
>>> This makes the assumption that dma specifiers will only ever be 1
>>> cell.  I think to be generally useful, the full dma specifier needs to
>>> be either handed to the dma controller to get a cookie or passed back
>>> to the caller in its entirety.
>>
>> More to the point, who says that the DMA specifier is even an integer?
>> When people are using DMA engines, it (probably) isn't an integer at
>> all.  Several platforms I know of use strings for this.
>>
>> Some platforms can even select between two or more DMA engines for
>> handling the same peripheral - I believe Samsung do this depending
>> on their individual workloads.
>>
>> However, the opaque DMA engine API for requesting a channel doesn't
>> lend itself well to DT, as the match data and match function are
>> entirely left to the individual DMA engine driver and/or platform
>> itself.
>>
>> As far as creating another linear number space for DMA stuff, I'd
>> really suggest against that - you're going to need some additional
>> code in place to manage that numberspace.  If you at least use a two-
>> paid cookie, eg 'dma controller phandle + request signal' then that
>> makes all the stuff we're starting to see with the IRQ subsystem,
>> IRQ domains etc become completely unnecessary.
>>
>> I guess what I'm saying is ignore the flat number space, and go
>> straight to some kind of 'dma domains' solution from the start.
>
> Fully agree, and this is exactly the idea of this DMA binding: First  
> argument is always a DMA controller phandle and then you can add 0, 1 or  
> more cells to define extra specifiers dependent of the DMA controller  
> driver expectation. The one cell Grant was referring was just the extra  
> specifier that is needed for a simple DMA engine like the SDMA we have  
> inside OMAP. But the whole idea is to have a flexible enough mechanism  
> to allow any kind of specifier.
>
> No more global linear number space like for IRQ!

How does this work when you're stuffing a number into a struct resource
as a plain DMA number?  That looks very much like a linear number space,
as you don't have a way to associate that number with anything else.
