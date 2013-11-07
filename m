From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Thu, 07 Nov 2013 10:07:01 +0100
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <20131106200709.GB26881@obsidianresearch.com>
References: <527A1983.6020603@keymile.com>
 <20131106173649.GA25515@obsidianresearch.com> <527A9AB9.2050903@keymile.com>
 <20131106200709.GB26881@obsidianresearch.com>
Message-ID: <527B5835.3060906@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2013 09:07 PM, Jason Gunthorpe wrote:
> On Wed, Nov 06, 2013 at 08:38:33PM +0100, Gerlando Falauto wrote:
>
[...]
> Each translation represents something concrete:
>   0x8 -> 0x82000000 0x00000000 0x00000008
>      This is the BAR 0 decoder of the PCI device
>   0x82000000 0x00000000 0x00000008 -> 0x82000000 0x1 8
>      This is the PCI bridge's memory window decoder
>    0x82000000 0x1 8 -> MBUS_ID(0x04, 0xe8) 8
>      This is the MBUS window associated with the PEX
>   MBUS_ID(0x04, 0xe8) 8 -> 0xe0000008
>      This is the physical CPU BUS address associated with the MBUS
>      window

Uhm, OK, sounds good. Except you must know the whole mapping in advance. 
Fair enough.
Would that work without the whole mbus driver (I guess Ezequiel's)?
I'm dealing with 3.10.

Where does the 0x82000000 come from?
What about the 0x1 (second cell)?

>> Looks like it ends up at the beginning of the memory region for
>> PCIe, and that's no wonder since you only have a single device with
>> a single BAR... right?
>
> The mapping of the FPGA bus into a BAR is done by a single ranges:
>
>>>                                  fpga at 0 {
>>>                                          reg = <0x8 0 0  0 0>;
>>>                                          ranges = <0x00000000  0x82000000 0x00000000 0x00000000  0x8000000>;
>>>                                          gpio3: fpga_gpio at 8 {
>
> That ranges says 'put address 0 of the child bus at 0x82000000
> 0x00000000 0x00000000', which is the BAR 0 address, relative to the
> bridge's memory window.
>
>> So suppose you also had a bigger BAR1 which would then shift your
>> GPIO block at @0xe8000000.
>> Until we get that figured out, where would you hardcode such offset then?
>
> Since your BAR layout of your device is fixed you can adjust the
> single ranges:

By "single" you mean that it's just *one* range, right?

>
>    ranges = <0x00000000  0x82000000 0x00000000 0x08000000  0x8000000>;
>
> It is possible as well to do this in code in the FPGA driver.

Uhm... why? And how? You mean dynamically upgrading the ranges window?

>
>> How would you also deal with a second (let's say identical) device on BAR1?
>
>    ranges = <0x00000000  0x82000000 0x00000000 0x08000000  0x8000000  //  BAR 0
>              0x10000000  0x82000000 0x00000000 0x08000000  0x8000000> // BAR 1

Aren't in this case the two regions aliased? Shouldn't the fourth column 
on either row be 0x00000000? Like:

     ranges = <0x00000000  0x82000000 0x00000000 0x00000000  0x8000000 
//  BAR 0
               0x10000000  0x82000000 0x00000000 0x08000000  0x8000000> 
// BAR 1

> Use reg <0x10000abc xxx> to refer to the 2nd BAR. There are other ways
> to organize things.

Now I completely lost you. According to the above description (BTW, I 
like the double space to separate groups -- it makes this whole mess a 
little messy!) the child address should have a single cell.
Why use two then?

>> I guess I could live with hardcoded values in the DT, as long as
>> they're easy to spot and there's only one per BAR/device.
>> Then it's easy to do a comparison with whatever gets assigned during
>> probing.
>
> I'd see it as an interm step, pending on some kind of core support for
> this sort of stuff.

Right.

Sorry for being pedantic, but I'd really like to get this straight once 
and for all...

Thanks again,
Gerlando
