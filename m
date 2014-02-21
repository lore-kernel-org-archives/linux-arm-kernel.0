From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Fri, 21 Feb 2014 19:29:20 +0100
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <2321496.TUNdngb8sx@wuerfel>
References: <20140221003227.GF19893@obsidianresearch.com>
 <20140221180508.7ed6cfaf@skate> <20140221173105.GA17611@obsidianresearch.com>
 <2321496.TUNdngb8sx@wuerfel>
Message-ID: <53079B00.2050604@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2014 07:05 PM, Arnd Bergmann wrote:
> On Friday 21 February 2014 10:31:05 Jason Gunthorpe wrote:
>> On Fri, Feb 21, 2014 at 06:05:08PM +0100, Thomas Petazzoni wrote:
>>
>>> Now I have another question: our mvebu_pcie_align_resource() function
>>> makes sure that the base address of the BAR is aligned on its size,
>>> because it is a requirement of MBus windows. However, if you later
>>> split the BAR into multiple windows, will this continue to work out?
>>
>> No, you must align to (1 << log2_round_down(size)) - that will always
>> be the largest mbus window created and thus the highest starting
>> alignment requirement.
>
> Unless you allow reordering the two windows. If you want a 96MB
> window, you only need 32MB alignment because you can either put
> the actual 64MB window first if you have 64MB alignment, or you
> put the 32MB window first if you don't and then the following
> 64MB will be aligned.
>
> It gets more complicated if you want to allow a 72MB window
> (16MB+64MB), as that could either be 64MB aligned or start 16MB
> before the next multiple of 64MB.
>
> I don't think there is any reason why code anywhere should align
> the window to a multiple of the size though if the size is not
> power-of-two, such as aligning to multiples of 96MB. That wouldn't
> help anyone.

I also don't see why in the world there would be a requirement of having 
a given "oddly-sized" range (e.g. 96MB) aligned to a multiple of its 
size. In the end, AFAIK aligment requirements' only purpose is to make 
hardware simpler. Cant'see how aligning to an "odd" number would help 
achieving this purpose. But that's just me, of course.

Thanks guys!
Gerlando
