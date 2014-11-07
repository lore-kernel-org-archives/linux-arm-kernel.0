From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 7 Nov 2014 15:21:05 +0000
Subject: [PATCH v2 02/10] arm64/mm: add create_pgd_mapping() to create
 private page tables
In-Reply-To: <CAKv+Gu8SuNy8ufq2trZB=0jW6QRZde4QQS3M+jSDuWCTZ257vg@mail.gmail.com>
References: <1415283206-14713-1-git-send-email-ard.biesheuvel@linaro.org>
 <1415283206-14713-3-git-send-email-ard.biesheuvel@linaro.org>
 <20141107150830.GA10210@linaro.org>
 <CAKv+Gu8SuNy8ufq2trZB=0jW6QRZde4QQS3M+jSDuWCTZ257vg@mail.gmail.com>
Message-ID: <20141107152104.GA10892@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 04:12:34PM +0100, Ard Biesheuvel wrote:
> On 7 November 2014 16:08, Steve Capper <steve.capper@linaro.org> wrote:
> > On Thu, Nov 06, 2014 at 03:13:18PM +0100, Ard Biesheuvel wrote:

[...]

> >>  void __init create_id_mapping(phys_addr_t addr, phys_addr_t size, int map_io)
> >> @@ -285,7 +278,16 @@ void __init create_id_mapping(phys_addr_t addr, phys_addr_t size, int map_io)
> >>               return;
> >>       }
> >>       __create_mapping(&init_mm, &idmap_pg_dir[pgd_index(addr)],
> >> -                      addr, addr, size, map_io);
> >> +                      addr, addr, size,
> >> +                      map_io ? __pgprot(PROT_DEVICE_nGnRE)
> >> +                             : PAGE_KERNEL_EXEC);
> >> +}
> >
> > Could you please also change efi_setup_idmap (it's the only caller I
> > can see for create_id_mapping)?
> >
> > That way the prototype for create_id_mapping would look like:
> > void __init create_id_mapping(phys_addr_t addr, phys_addr_t size, pgprot_t prot)
> >
> 
> I didn't bother because a couple of patches later, this stuff is all
> ripped out anyway
> (7/10 arm64/efi: remove idmap manipulations from UEFI code), because
> there is no longer a need for UEFI to switch to the ID map.
> 
> Do you feel I should still change it here, and then remove it later?

Ahh, I looked at this patch in isolation.
Yeah, this looks fine to me as is then Ard.

Cheers,
-- 
Steve
