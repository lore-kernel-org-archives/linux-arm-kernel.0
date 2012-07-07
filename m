From: wmb@firmworks.com (Mitch Bradley)
Date: Fri, 06 Jul 2012 15:59:42 -1000
Subject: Where to put a large bootloader-supplied device tree on ARM ?
In-Reply-To: <2966DB01BC317A4DA23684BA0F653415013701@xmb-aln-x08.cisco.com>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <201207051454.24475.arnd@arndb.de> <20120705161600.GA28860@lunn.ch>
 <201207062008.23952.arnd@arndb.de> <20120706210009.GC11470@lunn.ch>
 <4FF781D8.3040206@firmworks.com>
 <2966DB01BC317A4DA23684BA0F653415013701@xmb-aln-x08.cisco.com>
Message-ID: <4FF7980E.7050705@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/6/2012 3:23 PM, David VomLehn (dvomlehn) wrote:
> The kernel *must* go where it is linked, but the FDT contains only relative
> references and is thus free to go anywhere. The same is true of ramdisks, which
> are usually placed after the kernel.

Right, but the kernel image is compressed, so after decompression it 
expands into the area just after it.  Also, the .bss segment is in that 
vicinity.

There's some code in arch/arm/boot/compressed/head.S to relocate
device tree blobs, but it requires CONFIG_ARM_APPENDED_DTB which
is not recommended - arch/arm/Kconfig recommends using the
documented boot protocol istead .  Documentation/arm/Booting says
to put the dtb "in a region of memory where the kernel decompressor
will not overwrite it", further recommending the first 16KiB.

As noted, the first 16KiB loses if the dtb is too large.  And
"where the kernel decompressor will not overwrite it" says what
won't work, not what will.  It appears that the decompressor works
out its addresses dynamically, so there's no hard prescription even
for what to avoid.

For now, I'm putting the initrd at the end of memory and the dtb
below that.  That seems to work, but I'm unsure whether or not
I'm just "getting lucky".

Thanks,
Mitch


> How about doing the same with your FDT?
>
>> -----Original Message-----
>> From: devicetree-discuss [mailto:devicetree-discuss-
>> bounces+dvomlehn=cisco.com at lists.ozlabs.org] On Behalf Of Mitch Bradley
>> Sent: Friday, July 06, 2012 5:25 PM
>> To: linux-arm-kernel at lists.infradead.org; devicetree-
>> discuss at lists.ozlabs.org
>> Subject: Where to put a large bootloader-supplied device tree on ARM ?
>>
>> I'm passing a flatted device tree from OLPC's bootloader (which
>> is a full Open Firmware implementation) to the kernel.  If I
>> put the FDT at the "traditional" address 0x100, bad things
>> happen when the DT is larger than 16K.  The FDT extends past
>> the 0x4000 boundary and gets overwritten by the early page tables
>> which are written at that address.
>>
>> I have found various places in memory where I can place it
>> without it being overwritten, and things work, but that seems
>> dodgy and likely to break randomly.
>>
>> Has there been any discussion about where large-ish FDT images
>> should be located?
>>
>> _______________________________________________
>> devicetree-discuss mailing list
>> devicetree-discuss at lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
>
