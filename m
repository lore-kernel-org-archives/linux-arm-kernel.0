From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 22 Apr 2016 18:25:43 +0100
Subject: [PATCH v2 6/6] efi/arm*: add support to dump the EFI page tables
In-Reply-To: <CAKv+Gu-abf2g5htQSHA=ETnSfzVExFLwsjs2Kbs8fn86MfFv3Q@mail.gmail.com>
References: <1461343688-8552-1-git-send-email-ard.biesheuvel@linaro.org>
 <1461343688-8552-7-git-send-email-ard.biesheuvel@linaro.org>
 <20160422170112.GS10606@leverpostej>
 <CAKv+Gu-abf2g5htQSHA=ETnSfzVExFLwsjs2Kbs8fn86MfFv3Q@mail.gmail.com>
Message-ID: <20160422172513.GV10606@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 07:20:38PM +0200, Ard Biesheuvel wrote:
> On 22 April 2016 at 19:01, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Apr 22, 2016 at 06:48:08PM +0200, Ard Biesheuvel wrote:

> >> +static struct ptdump_info efi_ptdump_info = {
> >> +     .mm             = &efi_mm,
> >> +     .markers        = efi_addr_markers,
> >> +     .base_addr      = 0,
> >> +     .max_addr       = SZ_1G,
> >> +};
> >
> > I see that max_addr isn't used for arm64, and for ARM it's only used in
> > one place. It doesn't seem great to have that on arm64 given it's
> > unused.
> >
> > Do we actually need max_addr? Is there any reason not to always dump
> > whole tables?
> >
> > I guess you're trying to avoid dumping the kernel VA range on 32-bit?
> 
> Indeed. On ARM, the efi_page_tables dumps its copy of
> kernel_page_tables. If that is OK (the information could potentially
> be useful, I suppose) we can drop the max

I'd argue it's always worth dumping the full tables (dropipng the max).

For instance, we could have some bug that leaves the kernel VA range in
the EFI tables inconsistent with what we expect/require, and having that
exposed would make that clear.

Regardless, arbitrarily limiting the VA range of the arm64 dump doesn't
seem great.

Thanks,
Mark.
