From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 26 Oct 2017 14:23:39 -0700
Subject: [PATCH] arm64: prevent regressions in compressed kernel image
 size when upgrading to binutils 2.27
In-Reply-To: <CAFrQcG_znedMpcvXQkcDZ96ti66y9H8AEfcqVjgnZMwW1ViRdg@mail.gmail.com>
References: <20171026202907.91852-1-ndesaulniers@google.com>
 <CAKv+Gu80ub1PnibzBtjPSOusHD-6oj4A=7ZeuW5VTv3aDQrdnQ@mail.gmail.com>
 <CAKwvOd=4=GOPUSYUzwkXHV2xhTzUnEpbw4c_PmFiqZBjbV80jA@mail.gmail.com>
 <CAKwvOdnemSgO1Jp9B1ANhnNfu8f2xAh+wJiaLQVSAREdck3cCA@mail.gmail.com>
 <CAFrQcG_znedMpcvXQkcDZ96ti66y9H8AEfcqVjgnZMwW1ViRdg@mail.gmail.com>
Message-ID: <CAKwvOdmZgzBneocuhhLs5YRwZv3JUvnSJSPi5pFCZbrkdNzc5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 26, 2017 at 2:17 PM, Siqi Lin <siqilin@google.com> wrote:
> I'm OK with sticking with the <2.27 binutils behavior. The gzip data is:

That's what this patch does; goes back to the <2.27 behavior for 2.27+.

> binutils 2.25:
> Image 41467904
> Image.gz 13395151
> binutils 2.27:
> Image 41467392
> Image.gz 14114953
>
> gzipped kernel increased by 0.69 MiB.

That's without this patch applied?  With it applied, what are the
stats (for gzip)?

> The one special case I see is !CONFIG_RELOCATABLE and compression is
> used, where there's a tradeoff between compressed image size and the
> benefit of dynamic relocs.

if !CONFIG_RELOCATABLE, then this patch (well v2 which will use
CONFIG_RELOCATABLE rather than CONFIG_RANDOMIZE_BASE) doesn't do
anything.
