From: hector@marcansoft.com (Hector Martin)
Date: Thu, 25 Feb 2010 10:51:56 +0100
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <alpine.LFD.2.00.1002242309030.1946@xanadu.home>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>	<20100224223418.GB25587@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>	<20100224234215.GA21985@n2100.arm.linux.org.uk>	<4B85BCE0.7000903@marcansoft.com>	<20100225000114.GB21985@n2100.arm.linux.org.uk>	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
Message-ID: <4B86483C.6000108@marcansoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> On Thu, 25 Feb 2010, Hector Martin wrote:
> 
>> Russell King - ARM Linux wrote:
>>> On Thu, Feb 25, 2010 at 12:57:20AM +0100, Hector Martin wrote:
>>>> Russell King - ARM Linux wrote:
>>>>> On Wed, Feb 24, 2010 at 06:34:49PM -0500, Nicolas Pitre wrote:
>>>>>> What about simply not compiling the decompressor with -fPIC when using 
>>>>>> ZBOOT_ROM=y?  That would certainly solve the problem with the only 
>>>>>> restriction that such kernel images won't be bootable from RAM which is 
>>>>>> probably an acceptable compromize.
>>>>> Unfortunately, that doesn't solve the stack-bashing with ZBOOT_ROM=n.
>>>> Yes it does, that's exactly what my first version of the patch did. Once
>>>> you get rid of the partial relocation used for ROM builds (with split
>>>> text/bss) you don't need -Dstatic=, and once you get rid of that you
>>>> solve the stack-bashing. The ROM build becomes a bog standard
>>>> non-relocatable ROM image (with the usual LMA/VMA linker script stuff to
>>>> copy initialized data to RAM), and the RAM build becomes a bog standard
>>>> relocatable image (a single contiguous blob including
>>>> text/rodata/data/bss) that doesn't suffer from any issues when you move
>>>> it around.
>>> Did you bother to read my previous reply explaining that this is not
>>> a hack for the toolchain?  It sounds to me like you didn't.
>> Long story short, -Dstatic= isn't accomplishing what you want, because
>> it's crude and doesn't handle all cases properly. If you want to keep
>> the current model, you have to be willing to manually watch changes to
>> the decompressor implementations so they do not violate your assumptions
>> (i.e. never use static inside functions and rely on it, at least),
>> because -Dstatic= will break valid C code. Under _all_ circumstances, no
>> matter what your other compiler flags are or how you link and load
>> stuff, -Dstatic= is guaranteed to break some valid C code, and that's
>> what's happening here.
> 
> Obviously.  But that's the core of the argument: we made sure that the 
> previous implementation didn't use any static within functions.  Why do 
> you need to do that?  This is usually a bad idea anyway as this makes 
> the function non reentrant.

Static inside functions doesn't imply being non-reentrant (any more than
using global variables does). In this case the data arrays are also
const so it doesn't matter. But even if they weren't it wouldn't imply
non-reentrancy. For example, you could have the function generate the
tables on the fly on the first call, and add a spinlock if you want it
to be reentrant (in fact, I'm pretty sure the tables could optionally be
generated on the fly in the original zlib version, though that part was
removed for the kernel).

> 
> Two possibilities that I can see:
> 
> Put this in a common header file for the decompressor code:
> 
> /* ARM wants to redefine this sometimes */
> #ifndef static_func
> #define static_func
> #endif
> 
> Then declare your functions with static_func, and ARM can use 
> -Dstatic_func.
> 
> Or, we give up the ability to load in RAM a ROMable zImage.

I can also fix the second version of the patch to get rid of the two
extra copies of the kernel.

-- 
Hector Martin (hector at marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
