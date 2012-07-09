From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Jul 2012 15:50:55 +0000
Subject: [PATCH 07/15] ARM: dove: use fixed PCI i/o mapping
In-Reply-To: <1341600040-30993-8-git-send-email-robherring2@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
 <1341600040-30993-8-git-send-email-robherring2@gmail.com>
Message-ID: <201207091550.55912.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 July 2012, Rob Herring wrote:
> --- a/arch/arm/mach-dove/pcie.c
> +++ b/arch/arm/mach-dove/pcie.c
> @@ -60,13 +60,8 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
>                  "PCIe %d I/O", pp->index);
>         pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
>         pp->res[0].name = pp->io_space_name;
> -       if (pp->index == 0) {
> -               pp->res[0].start = DOVE_PCIE0_IO_PHYS_BASE;
> -               pp->res[0].end = pp->res[0].start + DOVE_PCIE0_IO_SIZE - 1;
> -       } else {
> -               pp->res[0].start = DOVE_PCIE1_IO_PHYS_BASE;
> -               pp->res[0].end = pp->res[0].start + DOVE_PCIE1_IO_SIZE - 1;
> -       }
> +       pp->res[0].start = nr * SZ_1M;
> +       pp->res[0].end = pp->res[0].start + SZ_64K - 1;
>         pp->res[0].flags = IORESOURCE_IO;
>         if (request_resource(&ioport_resource, &pp->res[0]))
>                 panic("Request PCIe IO resource failed\n");

Why use SZ_64K here when the mapping is actually 1M?

	Arnd
