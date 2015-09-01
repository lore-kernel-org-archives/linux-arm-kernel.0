From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Sep 2015 15:17:46 +0100
Subject: arm64: how to check endianness of Image file?
In-Reply-To: <CAMAWPa8EW92OAAVn7FOkBzPbtsQLQDpU1F0TM3uuTFa9P6bYOA@mail.gmail.com>
References: <CAMAWPa8EW92OAAVn7FOkBzPbtsQLQDpU1F0TM3uuTFa9P6bYOA@mail.gmail.com>
Message-ID: <20150901141746.GA19729@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Fri, Aug 28, 2015 at 11:23:20PM +0100, Kevin Hilman wrote:
> Will, Catalin,
> 
> Any suggestions on a quick way to check if an arm64 kernel Image file
> is big-endian?
> 
> We're adding more boot support for arm64 defconfig +
> CONFIG_CPU_BIG_ENDIAN=y to kernelci.org, and are looking for a
> reliable way to check the endianness of the kernel Image file, we
> don't have the vmlinux around to check the ELF headers.
> 
> On arm32, the zImage has some magic fields set from
> arch/arm/boot/compressed/head.S, but arm64 doesn't have the
> equivalent.

We have an endianness flag in the arm64 Image header, added per your
request in v3.17 [1,2].

Per Documentation/arm64/booting.txt (trimmed for context):

----
The decompressed kernel image contains a 64-byte header as follows:

  u32 code0;			/* Executable code */
  u32 code1;			/* Executable code */
  u64 text_offset;		/* Image load offset, little endian */
  u64 image_size;		/* Effective Image size, little endian */
  u64 flags;			/* kernel flags, little endian */
  u64 res2	= 0;		/* reserved */
  u64 res3	= 0;		/* reserved */
  u64 res4	= 0;		/* reserved */
  u32 magic	= 0x644d5241;	/* Magic number, little endian, "ARM\x64" */
  u32 res5;      		/* reserved (used for PE COFF offset) */

- The flags field (introduced in v3.17) is a little-endian 64-bit field
  composed as follows:
  Bit 0: 	Kernel endianness.  1 if BE, 0 if LE.
  Bits 1-63:	Reserved.
----

Kernels prior to v3.17 (where image_size is zero) don't expose the
endianness explicitly, but you can figure it out by inspecting
text_offset if you need to work with kernels prior to v3.17. See the
notes in booting.txt for more details.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/264697.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266023.html
