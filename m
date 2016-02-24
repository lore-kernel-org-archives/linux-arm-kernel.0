From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Wed, 24 Feb 2016 16:05:52 +0000
Subject: [PATCH] arm*: efi: drop permanent mapping of the UEFI System table
In-Reply-To: <CAKv+Gu_pnjL557dE1xez_y2tESOjZj9_2XEbNtm_b4yAA-WdYg@mail.gmail.com>
References: <1456153179-27214-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160222154314.GJ3435@leverpostej>
 <CAKv+Gu_pnjL557dE1xez_y2tESOjZj9_2XEbNtm_b4yAA-WdYg@mail.gmail.com>
Message-ID: <20160224160552.GB2603@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Feb, at 04:56:57PM, Ard Biesheuvel wrote:
> On 22 February 2016 at 16:43, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Feb 22, 2016 at 03:59:39PM +0100, Ard Biesheuvel wrote:
> >> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> >> index 848ede1587dc..6ce13d6b7122 100644
> >> --- a/drivers/firmware/efi/arm-runtime.c
> >> +++ b/drivers/firmware/efi/arm-runtime.c
> >> @@ -64,6 +64,16 @@ static bool __init efi_virtmap_init(void)
> >>                               &phys, ret);
> >>                       return false;
> >>               }
> >> +             /*
> >> +              * If this entry covers the address of the UEFI system table,
> >> +              * calculate and record its virtual address.
> >> +              */
> >> +             if (efi_system_table >= phys &&
> >> +                 efi_system_table < phys + (md->num_pages * EFI_PAGE_SIZE)) {
> >> +                     efi.systab = (void *)(efi_system_table - phys +
> >> +                                           md->virt_addr);
> >> +                     set_bit(EFI_SYSTEM_TABLES, &efi.flags);
> >> +             }
> >
> > It seems very odd to me to set this given it's currently unused, and we
> > don't have permanent access to the table. That sounds like we're just
> > setting ourselves up for future fragility as users appear.
> >
> 
> I wondered about the purpose as well. It is only ever set, and never
> tested (until this patch)
> 
> @Matt: any thoughts?

Good question. EFI_SYSTEM_TABLES was introduced over 4 years ago, but
it looks like it has never had any users. I don't remember why I added
it, probably just be to be "complete" since we had bits for all the
other tables.

If somebody wants to rip it out, I wouldn't object.

To be fair, we don't have permanent access to any of the tables - you
always have to switch to the dedicated EFI page tables before
accessing regions.
