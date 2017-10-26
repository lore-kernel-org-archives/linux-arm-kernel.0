From: siqilin@google.com (Siqi Lin)
Date: Thu, 26 Oct 2017 14:51:51 -0700
Subject: [PATCH] arm64: prevent regressions in compressed kernel image
 size when upgrading to binutils 2.27
In-Reply-To: <CAKwvOdmZgzBneocuhhLs5YRwZv3JUvnSJSPi5pFCZbrkdNzc5w@mail.gmail.com>
References: <20171026202907.91852-1-ndesaulniers@google.com>
 <CAKv+Gu80ub1PnibzBtjPSOusHD-6oj4A=7ZeuW5VTv3aDQrdnQ@mail.gmail.com>
 <CAKwvOd=4=GOPUSYUzwkXHV2xhTzUnEpbw4c_PmFiqZBjbV80jA@mail.gmail.com>
 <CAKwvOdnemSgO1Jp9B1ANhnNfu8f2xAh+wJiaLQVSAREdck3cCA@mail.gmail.com>
 <CAFrQcG_znedMpcvXQkcDZ96ti66y9H8AEfcqVjgnZMwW1ViRdg@mail.gmail.com>
 <CAKwvOdmZgzBneocuhhLs5YRwZv3JUvnSJSPi5pFCZbrkdNzc5w@mail.gmail.com>
Message-ID: <CAFrQcG_VRr40JG3GeS3nYqQW0kQpkiMk-tOLg8zR064cmEwTZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 26, 2017 at 2:23 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Oct 26, 2017 at 2:17 PM, Siqi Lin <siqilin@google.com> wrote:
> > I'm OK with sticking with the <2.27 binutils behavior. The gzip data is:
>
> That's what this patch does; goes back to the <2.27 behavior for 2.27+.
>
> > binutils 2.25:
> > Image 41467904
> > Image.gz 13395151
> > binutils 2.27:
> > Image 41467392
> > Image.gz 14114953
> >
> > gzipped kernel increased by 0.69 MiB.
>
> That's without this patch applied?  With it applied, what are the
> stats (for gzip)?
>

binutils 2.27 with this patch (with --no-apply-dynamic-relocs):
Image 41535488
Image.gz 13404067

binutils 2.27 without this patch (without --no-apply-dynamic-relocs):
Image 41535488
Image.gz 14125516

The 2.27 gzipped size with this patch is about the same as 2.25.

> > The one special case I see is !CONFIG_RELOCATABLE and compression is
> > used, where there's a tradeoff between compressed image size and the
> > benefit of dynamic relocs.
>
> if !CONFIG_RELOCATABLE, then this patch (well v2 which will use
> CONFIG_RELOCATABLE rather than CONFIG_RANDOMIZE_BASE) doesn't do
> anything.
