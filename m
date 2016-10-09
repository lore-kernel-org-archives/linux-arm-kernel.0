From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 10 Oct 2016 00:10:17 +0100
Subject: [PATCH v3] arm64: mm: move zero page from .bss to right before
 swapper_pg_dir
In-Reply-To: <CAKv+Gu-V+OKoeNFqvHvQOOFYi4VLm5mLKrmf9Z5oZY4KQkirsQ@mail.gmail.com>
References: <1473696925-26156-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu-V+OKoeNFqvHvQOOFYi4VLm5mLKrmf9Z5oZY4KQkirsQ@mail.gmail.com>
Message-ID: <20161009231017.GA11582@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2016 at 10:31:14AM +0100, Ard Biesheuvel wrote:
> On 12 September 2016 at 17:15, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > Move the statically allocated zero page from the .bss section to right
> > before swapper_pg_dir. This allows us to refer to its physical address
> > by simply reading TTBR1_EL1 (which always points to swapper_pg_dir and
> > always has its ASID field cleared), and subtracting PAGE_SIZE.
> >
> > To protect the zero page from inadvertent modification, carve out a
> > segment that covers it as well as idmap_pg_dir[], and mark it read-only
> > in both the primary and the linear mappings of the kernel.

[...]

> > -       map_kernel_segment(pgd, _data, _end, PAGE_KERNEL, &vmlinux_data);
> > +       map_kernel_segment(pgd, _data, __robss_start, PAGE_KERNEL,
> > +                          &vmlinux_data);
> > +       map_kernel_segment(pgd, __robss_start, __robss_end, PAGE_KERNEL_RO,
> > +                          &vmlinux_robss);
> 
> I realised it is actually unnecessary to map the idmap and the zero
> page into the kernel mapping, so we could drop this line.

Given that drivers use the zero page, I wouldn't be entirely surprised to see
phys_to_virt(virt_to_phys(zero_page)) happen indirectly, and the end result
read. Are we sure that doesn't happen anywhere?

For the idmap, I think we might walk that were we to take a fault (though
perhaps we don't). Otherwise, unless we add a sysfs walker for it I guess we
don't strictly need it in the linear map.

Thanks,
Mark.
