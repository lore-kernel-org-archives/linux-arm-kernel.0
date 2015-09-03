From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 3 Sep 2015 16:20:25 +0200
Subject: [PATCH] ARM: disable GCC SRA optimization
In-Reply-To: <1441211290-11449-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1441211290-11449-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu9zVCnnKOv=vROT3TBJkwJo4BW8UD-fhg_+Bfp7GyXCZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 September 2015 at 18:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> While working on the 32-bit ARM port of UEFI, I noticed a strange
> corruption in the kernel log. The following snprintf() statement
> (in drivers/firmware/efi/efi.c:efi_md_typeattr_format())
>
>         snprintf(pos, size, "|%3s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
>
> was producing the following output in the log:
>
>         |    |   |   |   |    |WB|WT|WC|UC]
>         |    |   |   |   |    |WB|WT|WC|UC]
>         |    |   |   |   |    |WB|WT|WC|UC]
>         |RUN|   |   |   |    |WB|WT|WC|UC]*
>         |RUN|   |   |   |    |WB|WT|WC|UC]*
>         |    |   |   |   |    |WB|WT|WC|UC]
>         |RUN|   |   |   |    |WB|WT|WC|UC]*
>         |    |   |   |   |    |WB|WT|WC|UC]
>         |RUN|   |   |   |    |   |   |   |UC]
>         |RUN|   |   |   |    |   |   |   |UC]
>
> As it turns out, this is caused by incorrect code being emitted for
> the string() function in lib/vsprintf.c. The following code
>
>         if (!(spec.flags & LEFT)) {
>                 while (len < spec.field_width--) {
>                         if (buf < end)
>                                 *buf = ' ';
>                         ++buf;
>                 }
>         }
>         for (i = 0; i < len; ++i) {
>                 if (buf < end)
>                         *buf = *s;
>                 ++buf; ++s;
>         }
>         while (len < spec.field_width--) {
>                 if (buf < end)
>                         *buf = ' ';
>                 ++buf;
>         }
>
> when called with len == 0, triggers an issue in the GCC SRA optimization
> pass (Scalar Replacement of Aggregates), which handles promotion of signed
> struct members incorrectly. This is a known but as yet unresolved issue.
> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65932). In this particular
> case, it is causing the second while loop to be executed erroneously a
> single time, causing the additional space characters to be printed.
>
> So disable the optimization by passing -fno-ipa-sra.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>
> Needs to go to stable perhaps?
> The emitted asm is at the end of this patch.
>

Submitted to the patch tracker as 8429/1 (with cc: stable)

-- 
Ard.
