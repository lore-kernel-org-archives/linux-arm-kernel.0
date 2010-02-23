From: b.hutchman@gmail.com (Brian Hutchinson)
Date: Mon, 22 Feb 2010 19:40:08 -0500
Subject: Separate/external initramfs, ATAG's, kernel panics ... Oh My!
In-Reply-To: <3d1967ab1002221639q93029bmf4bade3e732f66af@mail.gmail.com>
References: <3d1967ab1002221407r1e10dff2l395b3d365ffe3a29@mail.gmail.com>
	<20100222221918.GA7772@n2100.arm.linux.org.uk>
	<3d1967ab1002221639q93029bmf4bade3e732f66af@mail.gmail.com>
Message-ID: <3d1967ab1002221640i3d18e23dv184eb7a73f9ddb4a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What do you mean "it couldn't recognize my ATAG_MEM definitions" ?

Sorry, I was trying to provide enough info but not be too long. ?I'll
shed more light ...
OK don't laugh, but my u-boot code didn't appear setup right because
when I uncommented the #define CONFIG_SETUP_MEMORY_TAGS I started to
get unrecognized lines in the kernel (see below) so I tried to jam
something to see if it made a difference so here is the
setup_memory_tags I tried:

#ifdef CONFIG_SETUP_MEMORY_TAGS
static void setup_memory_tags (bd_t *bd)
{
// ? ? ?int i;

// ? ? ?for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
// ? ? ? ? ? ? ?params->hdr.tag = ATAG_MEM;
// ? ? ? ? ? ? ?params->hdr.size = tag_size (tag_mem32);
//
// ? ? ? ? ? ? ?params->u.mem.start = bd->bi_dram[i].start;
// ? ? ? ? ? ? ?params->u.mem.size = bd->bi_dram[i].size;
//
// ? ? ? ? ? ? ?params = tag_next (params);
// ? ? ?}
? ? ? ? ? ? ? ?// bth
? ? ? ? ? ? ? ?params->hdr.tag = ATAG_MEM;
? ? ? ? ? ? ? ?params->hdr.size = tag_size (tag_mem32);
? ? ? ? ? ? ? ?params->u.mem.start = PHYS_SDRAM_1;
? ? ? ? ? ? ? ?params->u.mem.size = PHYS_SDRAM_1_SIZE;
? ? ? ? ? ? ? ?params = tag_next (params);

? ? ? ? ? ? ? ?params->hdr.tag = ATAG_MEM;
? ? ? ? ? ? ? ?params->hdr.size = tag_size (tag_mem32);
? ? ? ? ? ? ? ?params->u.mem.start = PHYS_SDRAM_2;
? ? ? ? ? ? ? ?params->u.mem.size = PHYS_SDRAM_2_SIZE;
? ? ? ? ? ? ? ?params = tag_next (params);

? ? ? ? ? ? ? ?params->hdr.tag = ATAG_MEM;
? ? ? ? ? ? ? ?params->hdr.size = tag_size (tag_mem32);
? ? ? ? ? ? ? ?params->u.mem.start = PHYS_SDRAM_3;
? ? ? ? ? ? ? ?params->u.mem.size = PHYS_SDRAM_3_SIZE;
? ? ? ? ? ? ? ?params = tag_next (params);

? ? ? ? ? ? ? ?params->hdr.tag = ATAG_MEM;
? ? ? ? ? ? ? ?params->hdr.size = tag_size (tag_mem32);
? ? ? ? ? ? ? ?params->u.mem.start = PHYS_SDRAM_4;
? ? ? ? ? ? ? ?params->u.mem.size = PHYS_SDRAM_4_SIZE;
? ? ? ? ? ? ? ?params = tag_next (params);


}

I did this hack because my u-boot board_config.h file looks like:

/*-----------------------------------------------------------------------------
?* DDR2 RAM Memory Map
?*/
#ifndef CONFIG_PC20X_2_DDR_RAM_BANKS
/* We want a 4 DDR Bank setup then */

#define CONFIG_NR_DRAM_BANKS ? ?4 ? ? ? ? ? ? ? ? ? /* We have 4 RAM
banks... */
#define PHYS_SDRAM_1 ? ? ? ? ? ?0x00000000
#define PHYS_SDRAM_1_SIZE ? ? ? (32*1024*1024) ? ? ?/* 32 Mbytes */
#define PHYS_SDRAM_2 ? ? ? ? ? ?0x04000000
#define PHYS_SDRAM_2_SIZE ? ? ? (32*1024*1024) ? ? ?/* 32 Mbytes */
#define PHYS_SDRAM_3 ? ? ? ? ? ?0x08000000
#define PHYS_SDRAM_3_SIZE ? ? ? (32*1024*1024) ? ? ?/* 32 Mbytes */
#define PHYS_SDRAM_4 ? ? ? ? ? ?0x0C000000
#define PHYS_SDRAM_4_SIZE ? ? ? (32*1024*1024) ? ? ?/* 32 Mbytes */

... Which didn't appear to help. ?No matter what I did the kernel
would display these messages:

Ignoring unrecognised tag 0x00000000
Ignoring unrecognised tag 0x00000000
Ignoring unrecognised tag 0x00000000
Ignoring unrecognised tag 0x00000000

So something isn't quite right with the ATAG_MEM tags ... that is when
I commented out the ATAG's again and tried to just use the initrd=
bootarg.

>
> The "INITRD: was outside physical memory" seems entirely reasonable
> given what you're saying below:
>

snip

>
> Okay - you say the kernel is at 0x20080000, but this can't be, because
> it needs to have a 32K offset - I assume you mean it's at 0x20008000.
> So this presumably means that physical memory starts at 0x20000000.

Sorry, I should of just posted the u-boot display ... a picture is
worth a 1000 words:

## Booting image at 20080000 ...
? Image Name: ? Linux-2.6.28-picochip-3.1.0
? Created: ? ? ?2010-02-19 ?21:37:59 UTC
? Image Type: ? ARM Linux Kernel Image (uncompressed)
? Data Size: ? ?1608236 Bytes = ?1.5 MB
? Load Address: 00008000
? Entry Point: ?00008000
? Verifying Checksum ... OK
OK
## Loading Ramdisk Image at 20280000 ...
? Image Name: ? uInitramfs_busybox
? Created: ? ? ?2010-02-22 ?19:03:56 UTC
? Image Type: ? ARM Linux RAMDisk Image (gzip compressed)
? Data Size: ? ?13221592 Bytes = 12.6 MB
? Load Address: 00200000
? Entry Point: ?00200000
? Verifying Checksum ... OK

Starting kernel ...

0x20080000 & 0x20280000 are the NOR flash locations of a uImage and
cpio.gz respectively.
Kernel entry is 0x8000 and to be honest ... I'm not 100% up on how the
ARM kernel starts (haven't been working with this target long) so I
was guessing at where the cpio.gz image should be located. ?At first
when I did mkimage on the cpio image, ?I used -a 0 and -e 0 which is
what I read in some documentation (I assume this would work if my
ATAGs were not hosed up) and then I tried other options like tftp'ing
the cpio.gz itself and other combinations and that is how I arrived at
the example I gave. ?I've been trying all kinds of stuff trying to get
this to work and understand what is going on.

The board has 128M of RAM. ?It looks to me like u-boot recognizes this
correctly but since ATAG_MEM's are commented out ... I'm not quite
sure how Linux figures out the memory since these lines look suspect
as the kernel is coming up:

Memory: 16MB 16MB 16MB 16MB = 64MB total
Memory: 61584KB available (2800K code, 336K data, 116K init)

Regards,

Brian
