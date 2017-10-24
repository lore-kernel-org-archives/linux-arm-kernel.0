From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Oct 2017 10:54:44 +0100
Subject: [PATCH] ARM: Fix zImage file size not aligned with
 CONFIG_EFI_STUB enabled
In-Reply-To: <CAKv+Gu_XBDaOnOQSz12ZWnTaa1gjHO5zH0Gk3TpPo8+-F_wAxg@mail.gmail.com>
References: <20171023105046.GT20805@n2100.armlinux.org.uk>
 <20171023114549.GU20805@n2100.armlinux.org.uk>
 <CAKv+Gu_R+OfHMxcZEJML4Pm54DyOji6S42LihMgi6+vxi9LOAQ@mail.gmail.com>
 <20171024090953.GZ20805@n2100.armlinux.org.uk>
 <CAKv+Gu_t=7uZ91MbVUqNfTcxX+3HKPF1+ZjS2-2Mn-Wq6D9H6Q@mail.gmail.com>
 <20171024092229.GA20805@n2100.armlinux.org.uk>
 <CAKv+Gu-7r0ojZEOuvBFNRbxRfh8PwfLE_98XX4RQVAa1bNPOKA@mail.gmail.com>
 <CAKv+Gu9sxn-sRQxYuWY8EH7KTEDEkq7t=k-JveB81ft5-dCo1Q@mail.gmail.com>
 <20171024093814.GB20805@n2100.armlinux.org.uk>
 <CAKv+Gu_XBDaOnOQSz12ZWnTaa1gjHO5zH0Gk3TpPo8+-F_wAxg@mail.gmail.com>
Message-ID: <20171024095443.GC20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 10:44:00AM +0100, Ard Biesheuvel wrote:
> On 24 October 2017 at 10:38, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Do you have any preference - I'd prefer one that I can merge along with
> > these changes?  One way forward would be to temporarily add the /DISCARD/
> > for the ksym sections, which can then be removed once your sort() removal
> > gets added to the EFI trees.
> >
> 
> Well, I can respin that patch to only discard the ksymtab/kcrctab
> sections (and drop the alignment of piggydata), but I'd prefer to make
> it permanent if you don't mind. I still intend to remove the sort()
> call, given that ARM doesn't need it, but it seems more future proof
> to me to always discard those sections, and if we end up incorporating
> more core kernel code into the EFI stub, we won't need to revisit this
> (although I am not aware of any reasons why we would be doing that in
> the near future)

I don't think it's future-proof.  The decompressor is a particularly
special environment due to its runtime relocation support, where we
(eg) don't really support initialised pointers in the .data section.
Stuffing code from other parts of the kernel into the decompressor
isn't going to work reliably, and I'd much rather discourage the
practice.

Hence, there's really no reason to keep that discard, and I'd much
rather have the build fail if the sections re-appear as a pointer
towards something not being correct.

A solution to this would be to link the decompressor ELF with -r
and wrap that up in a mini-linker, but I suspect that will need
quite a re-write because of the self-relocation that the image
does if it detects overlap between itself and the destination for
the decompressed kernel image.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
