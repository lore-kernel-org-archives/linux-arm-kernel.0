From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 24 Mar 2010 09:11:56 -0600
Subject: RFC: ARM Boot standard for passing device tree blob
Message-ID: <fa686aa41003240811l6f40c8cfs6fdad496facdc089@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Since work is being done to add ARM Flattened Device Tree support to
both Linux and FreeBSD, I think it would be worth while to agree on a
common boot interface for passing a device tree blob from firmware to
the kernel (or in the case of kexec, from the old to new kernels).
I've drafted up something quickly on fdt.secretlab.ca.  The page can
be found here:

http://fdt.secretlab.ca/Boot_Environment#ARM

Feel free to modify the draft on the wiki if you notice any missing
details.  I've also posted the current text below so it is easy to
review and comment on.

(btw, the wiki at fdt.secretlab.ca should be moving to devicetree.org
in the near future, but I'll keep the old domain name around.
devicetree.org will be used to document new device tree bindings in an
OS-agnostic location.)


== ARM ==
See Documentation/arm/Booting and arch/arm/include/asm/setup.h in the
Linux kernel source tree for background information.  Some of the
content of this section is extracted from those files.

'''Draft'''

===Required System State===
*Quiesce all DMA
*CPU register contents
**r0 = 0
**r1 = Linux machine number (as defined in the ARM Linux machine database) or 0
**r2 = physical address of tagged parameter list in system RAM
*IRQs disabled
*MMU off
*Instruction cache either on or off
*Data cache turned off

===Minimal state for Flattened Device Tree Boot===
For FDT booting, the tagged list only needs to contain a single device
tree tag, and the device tree blob could be appended to the end of the
tagged list so that everything resides in the same region of memory.
For example, a minimal tag list may look like this:

<pre>
u32 tag_list[] = {
        0x00000005, /* ATAG_CORE, 5 words */
        0x54410001,
        0x00000000,
        0x00000000,
        0x00000000,

        0x00000004, /* ATAG_DEVTREE, 4 words */
        0x5441000a,
        0xNNNNNNNN, /* Phys address of device tree blob; could simply
be &tag_list + sizeof(taglist)
        0xMMMMMMMM, /* size of device tree blob in bytes */

        0x00000000, /* ATAG_NONE, end of list */
        0x00000000,
};
</pre>

===Tagged List Format===
The ARM tagged list format was designed by Russell King to solve the
problem of passing configuration information from the boot loader to
the kernel.  The tagged list design predates the flattened device
tree.  It is trivial to implement, but is only suitable for passing
the most basic of information.  A large number of ARM boot loaders
already include tagged list support.  While it was originally designed
for ARM Linux, the tagged list design that is inherently Linux
specific.

The tagged list is adopted for FDT booting to maintain compatibility
with the large installed base if existing ARM Linux machines.  There
are two aspects where this is important.  1. Boot loaders modified to
also pass an FDT blob do not become incompatible with existing
operating system images, and 2. operating systems can add FDT blob
support without becoming unbootable on existing non-FDT compatible
boot loaders.

Operating systems are only required to parse the ATAG_DEVTREE tag for
FDT booting.  If an OS understands additional tags, then it is
permissible to use the data in the tags.  However, device tree data
always take precedence over data in the tagged list.  For example, the
presence of a memory node in the device tree overrides the ATAG_MEM
tag.

The tagged list is a series of parameter blocks in contiguous memory.
Each tag consists of a 32 bit size field, a 32 bit tag id, and an
optional block of variable length data.  The size field contains the
total length of the tag in 32 bit words.  The tag id is a predefined
value identifying the data contained by the tag.

The following tag ids are currently defined:
{|+ border="1"
! Name !! Tag ID !! Size !! Description and payload format
|-
| Tag Header || || || Header used by all tags.  The explicit size
field allows an operating system to skip over tags it does not
recognize.
 struct tag_header {
         u32 size; /* tag size in 32bit words */
         u32 tag;
 };
|-
| ATAG_CORE || 0x54410001 || 5 || First tag in tag list
 struct tag_core {
         u32 flags;
         u32 pagesize;
         u32 rootdev;
 };
|-
| ATAG_MEM || 0x54410002 || 4 || Physical memory region
 struct tag_mem32 {
         u32 size;
         u32 start;
 };
|-
| ATAG_VIDEOTEXT || 0x54410003 || 5 || VGA text display
|-
| ATAG_RAMDISK || 0x54410004 || 5 || Location and size of Linux ramdisk image
 struct tag_ramdisk {
         u32 flags;
         u32 size;
         u32 start;
 };
|-
| ATAG_INITRD || 0x54410005 || || Deprecated.  Do not use
|-
| ATAG_INITRD2 || 0x54420005 || 4 || Location and size of Linux initrd image
 struct tag_initrd {
         u32 start;
         u32 size;
 };
|-
| ATAG_SERIAL || 0x54410006 || 4 || 64 bit machine serial number
 struct tag_serialnr {
         u32 low;
         u32 high;
 };
|-
| ATAG_REVISION || 0x54410007 || 3 || 32 bit board revision number
 struct tag_revision {
         u32 rev;
 };
|-
| ATAG_VIDEOLFB || 0x54410008 || 9 ||
|-
| ATAG_CMDLINE || 0x54410009 || 2 || Boot parameter string
 struct {
         char cmdline[1];
 };
|-
| ATAG_FLATTREE || 0x5441000a || 4 || '''DRAFT, not yet approved.'''
Location and size of Flattened Device Tree Blob
 struct {
         u32 start;
         u32 size;
 };
|-
| ATAG_NONE || 0x00000000 || 0 || End of tag list
|}


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
