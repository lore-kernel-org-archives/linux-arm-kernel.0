From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 8 Jan 2016 11:43:25 +0000
Subject: [PATCH v2 11/13] arm64: allow kernel Image to be loaded anywhere
 in physical memory
In-Reply-To: <CAKv+Gu8uGyoxvR0zYyrXiGTg5F4kO9p3Jbr-EZAozHYQS68T8w@mail.gmail.com>
References: <1451489172-17420-1-git-send-email-ard.biesheuvel@linaro.org>
 <1451489172-17420-12-git-send-email-ard.biesheuvel@linaro.org>
 <20160108112622.GA3097@leverpostej>
 <CAKv+Gu8uGyoxvR0zYyrXiGTg5F4kO9p3Jbr-EZAozHYQS68T8w@mail.gmail.com>
Message-ID: <20160108114324.GB3097@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 12:34:18PM +0100, Ard Biesheuvel wrote:
> On 8 January 2016 at 12:26, Mark Rutland <mark.rutland@arm.com> wrote:
> > We might also want to consider if we need to determine whether or not
> > the bootloader actually provided entropy, (and if we need a more general
> > handshake between the bootlaoder and kernel to determine that kind of
> > thing).
> 
> Yes, that is interesting. We should also think about how to handle
> 'nokaslr' if it appears on the command line, since in the !EFI case,
> we will be way too late to parse this, and a capable kernel will
> already be running from a randomized offset. That means it is the
> bootloader's responsibility to ensure that the presence of 'nokaslr'
> and the entropy in x1 are consistent with each other.

Argh, I hadn't considered that. :(

In the absence of a pre-kernel environment, the best thing we can do is
probably to print a giant warning if 'nokaslr' is present but there was
entropy (where that's determined based on some handshake/magic/flag).

> >>  Any memory described to the kernel (even that below the start of the
> >>  image) which is not marked as reserved from the kernel (e.g., with a
> >> diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
> >> index 81151b67b26b..984cb0fa61ce 100644
> >> --- a/arch/arm64/include/asm/boot.h
> >> +++ b/arch/arm64/include/asm/boot.h
> >> @@ -11,4 +11,9 @@
> >>  #define MIN_FDT_ALIGN                8
> >>  #define MAX_FDT_SIZE         SZ_2M
> >>
> >> +/*
> >> + * arm64 requires the kernel image to be 2 MB aligned
> >
> > Nit: The image is TEXT_OFFSET from that 2M-aligned base.
> > s/image/mapping/?
> >
> > [...]
> >
> 
> Yep. I hate TEXT_OFFSET, did I mention that?

I would also love to remove it, but I believe it's simply too late. :(

Thanks,
Mark.
