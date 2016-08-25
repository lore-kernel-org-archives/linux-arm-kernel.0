From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Thu, 25 Aug 2016 15:55:30 +0100
Subject: [PATCH] efi: arm64: treat regions with WT/WC set but WB cleared
 as memory
In-Reply-To: <CAKv+Gu89ofCBv+_-vy979c67Bhrt7soFNyHEYwe4r3=x8_gwgg@mail.gmail.com>
References: <1472052256-26365-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160825115325.GG31760@bivouac.eciton.net>
 <CAKv+Gu89ofCBv+_-vy979c67Bhrt7soFNyHEYwe4r3=x8_gwgg@mail.gmail.com>
Message-ID: <20160825145530.GH31760@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 03:07:32PM +0100, Ard Biesheuvel wrote:
> >> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> >> index c49d50e68aee..678672d332f8 100644
> >> --- a/drivers/firmware/efi/arm-init.c
> >> +++ b/drivers/firmware/efi/arm-init.c
> >> @@ -28,7 +28,7 @@ u64 efi_system_table;
> >>
> >>  static int __init is_normal_ram(efi_memory_desc_t *md)
> >>  {
> >> -     if (md->attribute & EFI_MEMORY_WB)
> >> +     if (md->attribute & (EFI_MEMORY_WB|EFI_MEMORY_WT|EFI_MEMORY_WC))
> >
> > The code change makes a lot of sense, but this makes the call sites a
> > bit confusing. It would make sense to rename this function.
> >
> > Would supports_unaligned() be too silly? That's basically what the
> > above makes it mean.
> 
> How about is_memory() ?
> 
> And we could invert is_reserve_region, and call it is_usable_memory() ...

Yes, that sounds like a good improvement.

/
    Leif
