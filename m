From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 19 Nov 2012 12:34:28 +0200
Subject: [RFC] fbdev: arm has __raw I/O accessors, use them in fb.h
In-Reply-To: <20121119094606.GF3290@n2100.arm.linux.org.uk>
References: <1353057364-21214-1-git-send-email-archit@ti.com>
 <ADE657CA350FB648AAC2C43247A983F00206B2644F3F@AUSP01VMBX24.collaborationhost.net>
 <50A9C1C4.5070907@ti.com> <20121119091504.GB3290@n2100.arm.linux.org.uk>
 <50A9FD98.1060105@ti.com> <20121119094606.GF3290@n2100.arm.linux.org.uk>
Message-ID: <50AA0B34.2000009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-19 11:46, Russell King - ARM Linux wrote:
> On Mon, Nov 19, 2012 at 11:36:24AM +0200, Tomi Valkeinen wrote:
>> Probably not. I can't say anything to that matter, but I wonder if this
>> patch is just going around the problem that we get sparse warnings when
>> falling into the else ifdef block in fb.h.
>>
>> The macros in the else block are defined as:
>>
>> #define fb_readb(addr) (*(volatile u8 *) (addr))                                 
>>
>> And fb code passes a pointer to __iomem. So shouldn't the cast be to
>> (volatile u8 __iomem *)?
> 
> No, because sparse won't let you directly dereference an __iomem pointer.
> 
> Directly dereferencing an __iomem pointer is wrong, always has been.  It's
> marked with __iomem _because_ it's a separate cookied address space from
> the virtual address space.
> 
> This is one of the situations which has been left because the warning is
> correct - and this is one of those situations where silencing them via
> casts et.al. is the wrong thing to do.  The right thing to do is to leave
> the warning in place.
> 
> This is one of the hardest things that I seem to get people to understand:
> if the code is wrong then we _should_ get a warning for it and we should
> definitely not paper over the warning.

Yes, you're right. Well, I'm not very experienced with handling
different endiannesses, but my analysis:

fb.h uses either __raw_read/write functions or (*(volatile u32 *)
(addr)) and (*(volatile u32 *) (addr) = (b)) for read/write.

__raw_read/write are defined in arch/arm/include/asm/io.h and are the
same for BE and LE. I made a test c-file with two functions, one using
raw_read style assembly, other using pointer dereference. I compiled it
with -mlittle-endian and -mbig-endian, and the resulting assembly was
identical for both, and the assembly for both functions were the same.

So if I didn't make any mistakes above, using __raw_read/write instead
of the direct pointer dereference results in identical operation for
both big and little endian arms. So if big-endian fb reads/writes is
correct now, it should be correct with raw_read/write also.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121119/61f514a9/attachment.sig>
