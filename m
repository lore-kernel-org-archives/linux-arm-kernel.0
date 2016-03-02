From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 2 Mar 2016 15:17:03 +0000
Subject: [PATCH v2 0/6] ARM64: meson: GXBaby (S905) and Vega S95 enablement
In-Reply-To: <56D6F958.2000109@suse.de>
References: <1456886101-22967-1-git-send-email-afaerber@suse.de>
 <20160302135216.GB11670@leverpostej> <56D6F958.2000109@suse.de>
Message-ID: <20160302151703.GD11670@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 03:31:52PM +0100, Andreas F?rber wrote:
> Am 02.03.2016 um 14:52 schrieb Mark Rutland:
> > On Wed, Mar 02, 2016 at 03:34:55AM +0100, Andreas F?rber wrote:
> >> Note: On the Vega S95 I need to change TEXT_OFFSET as follows,
> >> in order to avoid the vendor U-Boot overwriting itself (fwiu);
> >> for the Mini Mx that's reportedly not necessary.
> >>
> >> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> >> index 354d75402ace..b7cebdb8b1ce 100644
> >> --- a/arch/arm64/Makefile
> >> +++ b/arch/arm64/Makefile
> >> @@ -62,7 +62,7 @@ head-y                := arch/arm64/kernel/head.o
> >>  ifeq ($(CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET), y)
> >>  TEXT_OFFSET := $(shell awk 'BEGIN {srand(); printf "0x%03x000\n", int(512 * rand())}')
> >>  else
> >> -TEXT_OFFSET := 0x00080000
> >> +TEXT_OFFSET := 0x01080000
> >>  endif
> >>  
> >>  # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - 3)) - (1 << 61)
> > 
> > Absolute NAK to this. TEXT_OFFSET is not open for platform-specific
> > modification.
> 
> Please read again. There is nothing to NAK here, it's a workaround for
> testing my patches on my device! Even my own git queue has it clearly
> labeled as "HACK:".

Sure; I appreciate you need a workaround for the broken bootloader
currently on the device.

I'm simply heading off any attempts to upstream such changes.

> Nothing you say here indicates that this is breaking any particular
> kernel feature or damaging the device, so unless you propose a different
> way to solve the problem I see no way around it for now.

As far as I am aware, this should not result in damage to your device.

However, it runs directly counter to single-image, and other parts of
the kernel _may_ rely on the existing limits on TEXT_OFFSET. So it's not
suitable for upstream, and you _may_ encounter issues as a result.

> > Why can you not just load the Image 2MB higher regardless? Does the
> > U-Boot on this platform actually read TEXT_OFFSET and take it into
> > account?
> 
> Yes, U-Boot checks the ELF(?) header and tries to copy the image to the
> indicated offset if it isn't loaded there already. The vendor's kernel
> has the adjusted offset and works;

So the vendor deliberately changed the kernel Image in an unsupported
fashion, resulting in a divergent boot protocol.

This is incredibly unfortunate.

> if I use unmodified mainline kernels then I get weird exceptions from
> before entering the kernel, my assumption being that U-Boot code gets
> overwritten.
> 
> http://openlinux.amlogic.com:8000/download/ARM/u-boot/
> 
> This problem might go away if we had a proper upstream-based U-Boot; I'm
> not familiar enough with U-Boot to fix that myself and would hate to
> mess with U-Boot on eMMC, for lack of JTAG pins on this device.
 
> The Odroid-C2 (which I do not have access to yet) has instructions how
> to place U-Boot on an SD card, making it safer to experiment with.
> http://odroid.com/dokuwiki/doku.php?id=en:c2_partition_table

This is probably the right path to a solution.

> >> This in turn runs into an apparent regression introduced with the
> >> text offset randomization:
> >>
> >> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> >> index 6ebd204da16a..afdec27c8871 100644
> >> --- a/arch/arm64/kernel/head.S
> >> +++ b/arch/arm64/kernel/head.S
> >> @@ -48,7 +48,7 @@
> >>  #elif (PAGE_OFFSET & 0x1fffff) != 0
> >>  #error PAGE_OFFSET must be at least 2MB aligned
> >>  #elif TEXT_OFFSET > 0x1fffff
> >> -#error TEXT_OFFSET must be less than 2MB
> >> +//#error TEXT_OFFSET must be less than 2MB
> >>  #endif
> >>  
> >>  #define KERNEL_START   _text
> > 
> > This is not a regression. As above, TEXT_OFFSET is not supposed to be
> > modified in a platform-specific manner.
> 
> It is in fact an unexplained behavioral change in
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=da57a369d3bc5cd61db90f7e9555840381db9b09

Yes, strictly speaking it is a change.

No, it is not a regression, since TEXT_OFFSET was _never_ open to such
platform-specific modification.

Thanks,
Mark.
