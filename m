From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Oct 2017 10:38:15 +0100
Subject: [PATCH] ARM: Fix zImage file size not aligned with
 CONFIG_EFI_STUB enabled
In-Reply-To: <CAKv+Gu9sxn-sRQxYuWY8EH7KTEDEkq7t=k-JveB81ft5-dCo1Q@mail.gmail.com>
References: <20171023085006.GM20805@n2100.armlinux.org.uk>
 <59EDC34C.40109@rock-chips.com>
 <20171023105046.GT20805@n2100.armlinux.org.uk>
 <20171023114549.GU20805@n2100.armlinux.org.uk>
 <CAKv+Gu_R+OfHMxcZEJML4Pm54DyOji6S42LihMgi6+vxi9LOAQ@mail.gmail.com>
 <20171024090953.GZ20805@n2100.armlinux.org.uk>
 <CAKv+Gu_t=7uZ91MbVUqNfTcxX+3HKPF1+ZjS2-2Mn-Wq6D9H6Q@mail.gmail.com>
 <20171024092229.GA20805@n2100.armlinux.org.uk>
 <CAKv+Gu-7r0ojZEOuvBFNRbxRfh8PwfLE_98XX4RQVAa1bNPOKA@mail.gmail.com>
 <CAKv+Gu9sxn-sRQxYuWY8EH7KTEDEkq7t=k-JveB81ft5-dCo1Q@mail.gmail.com>
Message-ID: <20171024093814.GB20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 10:30:41AM +0100, Ard Biesheuvel wrote:
> On 24 October 2017 at 10:26, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 24 October 2017 at 10:22, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> >> On Tue, Oct 24, 2017 at 10:13:09AM +0100, Ard Biesheuvel wrote:
> >>> On 24 October 2017 at 10:09, Russell King - ARM Linux
> >>> <linux@armlinux.org.uk> wrote:
> >>> > The question is: do we want to know when additional sections get
> >>> > emitted into the binary?
> >>>
> >>> Well, we need to know whether the size of zImage is a multiple of 512
> >>> bytes. We could check that separately by adding the following as well
> >>>
> >>> #ifdef CONFIG_EFI_STUB
> >>> ASSERT((_edata % 512 == 0), "zImage file size is not a multiple of 512 bytes")
> >>
> >> ASSERT((_edata - _text) % 512 == 0, "EFI zImage file size is not a multiple of 512 bytes")
> >>
> >> This would only catch them when EFI is enabled, which doesn't give very
> >> good build coverage.  I still prefer my solution over adding the assert
> >> and a section for _edata - my solution catches it with EFI disabled as
> >> well.
> >>
> >> A variant on that would be this, which should catch additional sections
> >> for EFI and non-EFI:
> >>
> >> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
> >> index b38dcef90756..9d0c5d80979a 100644
> >> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> >> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> >> @@ -95,6 +95,10 @@ SECTIONS
> >>
> >>    _edata = .;
> >>
> >> +  .image_end (NOLOAD) : {
> >> +    _image_end = .;
> >> +  }
> >> +
> >>    _magic_sig = ZIMAGE_MAGIC(0x016f2818);
> >>    _magic_start = ZIMAGE_MAGIC(_start);
> >>    _magic_end = ZIMAGE_MAGIC(_edata);
> >> @@ -119,3 +123,5 @@ SECTIONS
> >>    .stab.indexstr 0     : { *(.stab.indexstr) }
> >>    .comment 0           : { *(.comment) }
> >>  }
> >> +
> >> +ASSERT(image_end == end, "zImage file size is incorrect")
> >>
> >
> > I take it you mean
> >
> > _image_end == _edata
> >
> > here? That works for me:
> >
> > Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > (with CONFIG_EFI enabled)
> 
> 
> BTW you could simplify that to
> 
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S
> b/arch/arm/boot/compressed/vmlinux.lds.S
> index 7a4c59154361..204d4580a04f 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> @@ -85,6 +85,10 @@ SECTIONS
> 
>    _edata = .;
> 
> +  .image_end (NOLOAD) : {
> +    ASSERT(. == _edata, "zImage file size is incorrect");
> +  }

Yep.  Okay, so now we have a patch from Arnd to fix the alignment problem
(so don't need alignment of the piggydata), and we have a patch to catch
the additional sections.  That leaves a patch to sort out the additional
sections.

Do you have any preference - I'd prefer one that I can merge along with
these changes?  One way forward would be to temporarily add the /DISCARD/
for the ksym sections, which can then be removed once your sort() removal
gets added to the EFI trees.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
