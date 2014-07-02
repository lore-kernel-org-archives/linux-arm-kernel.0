From: msalter@redhat.com (Mark Salter)
Date: Wed, 02 Jul 2014 10:29:45 -0400
Subject: [PATCH 1/2] efi/arm64: fix potential NULL dereference of
 efi.systab
In-Reply-To: <CAKv+Gu-SLQC82q7Rj5ZusbFxwysy7KpRhZ=vw1ipXu9kvq46aQ@mail.gmail.com>
References: <1404295802-28030-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu-SLQC82q7Rj5ZusbFxwysy7KpRhZ=vw1ipXu9kvq46aQ@mail.gmail.com>
Message-ID: <1404311385.19665.15.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-02 at 12:13 +0200, Ard Biesheuvel wrote:
> > On 2 July 2014 12:10, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > We assign efi.systab using efi_lookup_mapped_addr(), and test for !NULL, but
> > then go on an dereference it anyway.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/kernel/efi.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > index 56c3327bbf79..e785f93f17cb 100644
> > --- a/arch/arm64/kernel/efi.c
> > +++ b/arch/arm64/kernel/efi.c
> > @@ -419,8 +419,11 @@ static int __init arm64_enter_virtual_mode(void)
> >         }
> >
> >         efi.systab = (__force void *)efi_lookup_mapped_addr(efi_system_table);
> > -       if (efi.systab)
> > -               set_bit(EFI_SYSTEM_TABLES, &efi.flags);
> > +       if (!efi.systab) {
> > +               pr_err("Failed to remap EFI System Table!\n");
> 
> ... this needs a kfree(virtmap) as well.
> 

And probably should unmap all the remapped regions in virtmap first.
Presumably the systab will be in a runtime memory region which gets
virtual mapping from remap_region(). If that succeeds, then the
efi_lookup_mapped_addr should always succeed. But to be careful,
we should probably bail out earlier if remap_region() ever returns
zero. If all remaps work and efi_lookup_mapped_addr() fails, then
we should try ioremap_cache() directly. Or do what x86 does and make
a local copy of the table earlier when we early_memremap() it in
uefi_init().
