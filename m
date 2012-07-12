From: robherring2@gmail.com (Rob Herring)
Date: Thu, 12 Jul 2012 15:34:17 -0500
Subject: Where to put a large bootloader-supplied device tree on ARM ?
In-Reply-To: <4FFE743B.6080504@firmworks.com>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <201207051454.24475.arnd@arndb.de> <20120705161600.GA28860@lunn.ch>
 <201207062008.23952.arnd@arndb.de> <20120706210009.GC11470@lunn.ch>
 <4FF781D8.3040206@firmworks.com>
 <2966DB01BC317A4DA23684BA0F653415013701@xmb-aln-x08.cisco.com>
 <4FF7980E.7050705@firmworks.com>
 <alpine.LFD.2.02.1207090015270.31100@xanadu.home>
 <4FFE743B.6080504@firmworks.com>
Message-ID: <4FFF34C9.8030000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding u-boot list]

On 07/12/2012 01:52 AM, Mitch Bradley wrote:
> On 7/8/2012 6:30 PM, Nicolas Pitre wrote:
>> On Fri, 6 Jul 2012, Mitch Bradley wrote:
>>
>>> On 7/6/2012 3:23 PM, David VomLehn (dvomlehn) wrote:
>>>> The kernel *must* go where it is linked, but the FDT contains only relative
>>>> references and is thus free to go anywhere. The same is true of ramdisks,
>>>> which
>>>> are usually placed after the kernel.
>>
>> The kernel must go where it is linked *only* if you are using the 
>> 'Image' output.  When using 'zImage' you can put the kernel anywhere in 
>> memory, or in the first 128MB of RAM if CONFIG_AUTO_ZRELADDR is used.
>>
>>> Right, but the kernel image is compressed, so after decompression it expands
>>> into the area just after it.  Also, the .bss segment is in that vicinity.
>>
>> To be exact, the compressed kernel moves itself out of the region where 
>> the decompressed kernel will end up before doing the decompression, but 
>> only if necessary.  So it is a good idea to load zImage away from the 
>> decompressed kernel area to avoid this extra move and save some fraction 
>> of a second on boot time.
>>
>>> There's some code in arch/arm/boot/compressed/head.S to relocate
>>> device tree blobs, but it requires CONFIG_ARM_APPENDED_DTB which
>>> is not recommended - arch/arm/Kconfig recommends using the
>>> documented boot protocol istead .
>>
>> This is in case a DTB is appended to zImage.  When the DTB is detected, 
>> the moving of zImage out of the decompressed area must take care of 
>> moving the DTB as well.
>>
>>> Documentation/arm/Booting says
>>> to put the dtb "in a region of memory where the kernel decompressor
>>> will not overwrite it", further recommending the first 16KiB.
>>>
>>> As noted, the first 16KiB loses if the dtb is too large.  And
>>> "where the kernel decompressor will not overwrite it" says what
>>> won't work, not what will.  It appears that the decompressor works
>>> out its addresses dynamically, so there's no hard prescription even
>>> for what to avoid.
>>
>> A good rule of thumb is to take the size of the decompressed kernel and 
>> multiply this by 3.  Rounding up is also fine.  So for example if your 
>> arch/arm/boot/Image is 5MB, then putting anciliary data such as a 
>> ramdisk or a large DTB from 16MB into RAM or above should be fine.
>>
>>> For now, I'm putting the initrd at the end of memory and the dtb
>>> below that.  That seems to work, but I'm unsure whether or not
>>> I'm just "getting lucky".
>>
>> That's also perfectly fine.
> 
> 
> Alas, that worked for machines with 512 MiB of main memory, but failed
> on 1 GiB machines.  My guess is that, when the initrd and dtb are near
> the top of a 1 GiB memory, the virtual address gets too near the top of
> the kernel's 1 GiB of virtual space (which starts at 0xc0000000),
> perhaps colliding with the VMALLOC space.
> 
> Putting them just below the 128 MiB boundary seems to work.

Interesting. I think this is also a problem on u-boot just waiting to
happen. u-boot locates itself at the end of RAM and likes to copy the
fdt and initrd to just below that. Any machine with 1G+ is going to hit
this. I avoided it because I limited u-boot to 512MB on highbank.

Rob

> 
>>
>>
>> Nicolas
>>
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
