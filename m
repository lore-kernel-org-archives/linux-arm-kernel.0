From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 8 Jun 2017 12:44:36 -0700
Subject: [PATCH 3/3] efi/libstub: arm64: set -fpie when building the EFI
 stub
In-Reply-To: <CAKv+Gu--WbvmS3EMPSD8sx6yVqgHQJO1r70+SYBRo_WZjUxioQ@mail.gmail.com>
References: <20170518090953.32628-1-ard.biesheuvel@linaro.org>
 <20170518090953.32628-4-ard.biesheuvel@linaro.org>
 <20170608190804.GG141096@google.com>
 <CAKv+Gu--WbvmS3EMPSD8sx6yVqgHQJO1r70+SYBRo_WZjUxioQ@mail.gmail.com>
Message-ID: <20170608194436.GH141096@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Thu, Jun 08, 2017 at 07:18:36PM +0000 Ard Biesheuvel ha dit:

> On 8 June 2017 at 19:08, Matthias Kaehlcke <mka@chromium.org> wrote:
> > El Thu, May 18, 2017 at 10:09:53AM +0100 Ard Biesheuvel ha dit:
> >
> >> Clang may emit absolute symbol references when building in non-PIC mode,
> >> even when using the default 'small' code model, which is already mostly
> >> position independent to begin with, due to its use of adrp/add pairs
> >> that have a relative range of +/- 4 GB. The remedy is to pass the -fpie
> >> flag, which can be done safely now that the code has been updated to avoid
> >> GOT indirections (which may be emitted due to the compiler assuming that
> >> the PIC/PIE code may end up in a shared library that is subject to ELF
> >> symbol preemption)
> >>
> >> Passing -fpie when building code that needs to execute at an a priori
> >> unknown offset is arguably an improvement in any case, and given that
> >> the recent visibility changes allow the PIC build to pass with GCC as
> >> well, let's add -fpie for all arm64 builds rather than only for Clang.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Thanks Matthias.
> 
> For the record, did you test only with Clang?

With both gcc and clang. Booting has only been tested with an older
kernel (v3.18), I suppose it shouldn't make a difference.
