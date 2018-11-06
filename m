From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Nov 2018 14:21:26 +0000
Subject: [PATCH 1/4] EFI stub: remove -fdata-sections
In-Reply-To: <CAKv+Gu_-Vqa=TXDzmzorjcPVnxqO3BHvvDyJKViHFLCsnhfeEw@mail.gmail.com>
References: <20181106133935.GB30658@n2100.armlinux.org.uk>
 <E1gK1aT-0000oL-Nn@rmk-PC.armlinux.org.uk>
 <CAKv+Gu_-Vqa=TXDzmzorjcPVnxqO3BHvvDyJKViHFLCsnhfeEw@mail.gmail.com>
Message-ID: <20181106142126.GD30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 03:11:18PM +0100, Ard Biesheuvel wrote:
> On 6 November 2018 at 14:40, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > Remove -fdata-sections from the EFI stub build as this causes problems
> > for the ARM decompressor code.
> >
> Just out of curiosity: what kind of problems?

I'm afraid I don't remember - these patches are March 2018.  I suspect
it was a result of a randconfig build failing to link, as I don't have
any 32-bit ARM configs that have the EFI stub enabled.

In any case, this will break:

#
# ARM discards the .data section because it disallows r/w data in the
# decompressor. So move our .data to .data.efistub, which is preserved
# explicitly by the decompressor linker script.
#
STUBCOPY_FLAGS-$(CONFIG_ARM)    += --rename-section .data=.data.efistub

because with -fdata-sections enabled, there is no longer a single .data
section, but multiple .data.* sections.  Hence, the rename no longer
works, and all the EFI stub data ends up being discarded by the
decompressor link stage.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
