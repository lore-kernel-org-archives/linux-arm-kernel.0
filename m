From: robherring2@gmail.com (Rob Herring)
Date: Mon, 17 Mar 2014 11:05:38 -0500
Subject: [PATCH v7 3/3] arm64: Add architecture support for PCI
In-Reply-To: <1394811258-1500-4-git-send-email-Liviu.Dudau@arm.com>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com>
 <1394811258-1500-4-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <CAL_Jsq+9X-9VahsP79mtHN0RC64vRA_2R3ucjX0LefO6q2YN3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 10:34 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> Use the generic host bridge functions to provide support for
> PCI Express on arm64. There is no support for ISA memory.
>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Tested-by: Tanmay Inamdar <tinamdar@apm.com>
> ---
>  arch/arm64/Kconfig            |  19 +++-
>  arch/arm64/include/asm/Kbuild |   1 +
>  arch/arm64/include/asm/io.h   |   3 +-
>  arch/arm64/include/asm/pci.h  |  51 ++++++++++
>  arch/arm64/kernel/Makefile    |   1 +
>  arch/arm64/kernel/pci.c       | 173 ++++++++++++++++++++++++++++++++
>  6 files changed, 246 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/pci.h
>  create mode 100644 arch/arm64/kernel/pci.c

[snip]

> +#endif
> +
> +extern unsigned long pci_ioremap_io(const struct resource *res, phys_addr_t phys_addr);

Can we at least align the function definition across architectures if
not the implementation.


> +int pci_register_io_range(phys_addr_t address, resource_size_t size)
> +{
> +       struct ioresource *res;
> +       resource_size_t allocated_size = 0;
> +
> +       /* find if the range has not been already allocated */
> +       list_for_each_entry(res, &io_list, list) {
> +               if (address >= res->start &&
> +                       address + size <= res->start + size)
> +                       return 0;
> +               allocated_size += res->size;
> +       }
> +
> +       /* range not already registered, check for space */
> +       if (allocated_size + size > IO_SPACE_LIMIT)

I believe this needs to be "allocated_size + size - 1".

> +               return -E2BIG;
> +
