From: b.hutchman@gmail.com (Brian Hutchinson)
Date: Fri, 26 Feb 2010 16:41:35 -0500
Subject: External initramfs again ... keep getting "overlaps in-use memory
	region" - [SOLVED!]
Message-ID: <3d1967ab1002261341v642a83d8m1fed3a3fdaa28066@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 7:17 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Feb 25, 2010 at 07:11:54PM -0500, Brian Hutchinson wrote:
>> Do I have to re-arrange that 16M hole I mentioned and make it the
>> first 16M and the rest all contig in the fixup?
>
> What I described was not quite right - was 4 bits out.
>
> For this layout:
>
> ?0x00000000 - DDR Bank 0
> ?0x04000000 - DDR Bank 1
> ?0x08000000 - DDR Bank 2
> ?0x0c000000 - DDR Bank 3
>
> MAX_PHYSMEM_BITS would be 28 and SECTION_SIZE_BITS 26.
>
> But if you actually have this:
>
> ?The way the code is called it looks like it sets up 16M region
> ?(0x0-0x01ffffff), then skips 16M (0x02000000-0x07ffffff) (I don't know
> ?why ... yet) then the last three 32M regions are contiguous (see
> ?kernel messages below).
>
> You could set SECTION_SIZE_BITS to 27 since your memory appears to be
> grouped in two sections - 0x0 - 0x01ffffff, and then 0x08000000 -
> 0x0dffffff.

Russell is the man!  I thank the Lord for Russell!

Error in my earlier post ... the 16M hole I described as
(0x02000000-0x07ffffff) was a typo, it should have been
(0x02000000-0x03ffffff) ... thought I should point that out to avoid
confusion.

Summary of solution Russell schooled me on for others to enjoy ....

I had no idea that the memory model was my problem ... especially
because my initramfs cpio (12M+ gzipped, around 34M uncompressed)
image worked when linked with the kernel but would give me the
problems described earlier in this thread when I tried to load the
cpio external using the initrd= method.

I modified my Kconfig to allow the sparsemem model to be selected ...
for my arch in Kconfig I had to add:
select ARCH_SPARSEMEM_ENABLE

With this change the sparsemem selection showed up in make menuconfig.

In my memory.h file I placed these two lines which are the magic to
getting sparsemem to work:

#define MAX_PHYSMEM_BITS 28
#define SECTION_SIZE_BITS 26

Didn't have to make any other changes!  Pretty painless!  Rebuilt the
kernel after making the above changes.

Tested by tftp'ing my initramfs cpio.gz image to 0x4000000.  Took note
of the bytes transferred so I would know the size to use with the
initrd command.

Modified my initrd line to be initrd=0x4000000,<size of bytes
transferred in tftp mentioned above>
Did a bootm (u-boot) of the kernel and ..... success!

This is also the solution to the other thread I started:
http://lists.arm.linux.org.uk/lurker/message/20100222.220721.f03c1e3a.en.html

See some of these sources for info in the sparsemem memory model:
http://lkml.indiana.edu/hypermail/linux/kernel/0505.0/0771.html
http://kerneltrap.org/node/14009


Regards,

Brian
