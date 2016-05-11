From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Wed, 11 May 2016 13:29:48 +0100
Subject: [PATCH] Xen: EFI: Parse DT parameters for Xen specific UEFI
In-Reply-To: <CANLsYkxUyiUfdjm39SvhKSvmddPLFP3JFAeHpYuxgPyZfexw6w@mail.gmail.com>
References: <1462523526-3172-1-git-send-email-zhaoshenglong@huawei.com>
 <CANLsYkxUyiUfdjm39SvhKSvmddPLFP3JFAeHpYuxgPyZfexw6w@mail.gmail.com>
Message-ID: <20160511122948.GV2839@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 06 May, at 09:52:42AM, Mathieu Poirier wrote:
> > +static int __init efi_remap_init(void)
> > +{
> > +       u64 mapsize;
> > +
> > +       pr_info("Remapping and enabling EFI services.\n");
> > +
> > +       mapsize = memmap.map_end - memmap.map;
> > +       memmap.map = (__force void *)ioremap_cache(memmap.phys_map,
> > +                                                  mapsize);
> > +       if (!memmap.map) {
> > +               pr_err("Failed to remap EFI memory map\n");
> > +               return -ENOMEM;
> > +       }
> > +       memmap.map_end = memmap.map + mapsize;
> > +       efi.memmap = &memmap;
> > +
> > +       efi.systab = (__force void *)ioremap_cache(efi_system_table,
> > +                                                  sizeof(efi_system_table_t));
> > +       if (!efi.systab) {
> 
> Is there a reason why memmap.map isn't iounmap() in the error path?
> The original code didn't have it either, hence the question.

I suspect that is a bug.

In reality, if you can't access the EFI System Table because you fail
to map it I would guess you are going to crash very, very quickly
anyhow.
