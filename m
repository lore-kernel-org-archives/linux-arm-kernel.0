From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 28 Apr 2014 18:19:32 +0200
Subject: [PATCH] QEMU: ARM: boot: Load kernel at an Image friendly address
In-Reply-To: <1395718484-20424-1-git-send-email-joelf@ti.com>
References: <1395718484-20424-1-git-send-email-joelf@ti.com>
Message-ID: <20140428161932.GG28564@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 10:34:44PM -0500, Joel Fernandes wrote:
> Loading kernel at offset 0x10000 works only for zImage, but not for Image,
> because the kernel expect the start of decompressed kernel (.head.text) to be
> at an address that's a distance that's 16MB aligned from  PAGE_OFFSET +
> TEXT_OFFSET (see vmlinux.lds.S). This check is enfornced in __fixup_pv_table in
> arch/arm/kernel/head.S TEXT_OFFSET is 0x00008000, so a 16MB alignment needs to
> have a "0x8000" in the lower 16 bits so that they cancel out. Currently the
> offset Qemu loads it at is 0x10000.
I'm not a native speaker, but I think the wording and logic is broken.
I think what you mean is:

	An uncompressed ARM kernel Image must be loaded to the
	(physical) address PHYS_OFFSET + TEXT_OFFSET. (If
	CONFIG_ARM_PATCH_PHYS_VIRT=y the condition is more lax, but we
	cannot assume this to be enabled.)

Speaking about PAGE_OFFSET doesn't make sense here, because that's a
virual address and the MMU is expected to be off (or loaded with a 1:1
mapping). Also note that not all machines use TEXT_OFFSET == 0x8000, see

	git grep textofs- arch/arm/Makefile

.

Additionally let me note, that for a zImage most addresses should work,
but there are more and less sensible ones. Both PHYS_OFFSET + 0x8000 and
PHYS_OFFSET + 0x10000 are in the latter group. That's because the
compressed image and the then uncompressed image overlap, so you loose
booting time by relocating one of them. Not sure if you care.

As you cannot determine the actual value of TEXT_OFFSET for a given
Image, I'd recommend to only support booting zImages and then place it
somewhere at the end of RAM.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
