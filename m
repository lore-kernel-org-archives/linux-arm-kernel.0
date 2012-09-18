From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 18 Sep 2012 11:21:21 -0600
Subject: [PATCH 2/2] ARM: pci: Allow passing per-controller private data
In-Reply-To: <1347657078-32230-3-git-send-email-thierry.reding@avionic-design.de>
References: <1347657078-32230-1-git-send-email-thierry.reding@avionic-design.de>
 <1347657078-32230-3-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <CAErSpo754W2TKr46V5FKwX43eusoOVjxkAWJ=kkB0BvRt_bJBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 3:11 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> In order to allow drivers to specify private data for each controller,
> this commit adds a private_data field to the struct hw_pci. This field
> is an array of nr_controllers pointers that will be used to initialize
> the private_data field of the corresponding controller's pci_sys_data
> structure.

I guess you aren't changing the design here because struct hw_pci
already includes "nr_controllers," but having nr_controllers and a
private_data[] array sounds like something that might make it hard to
hot-add a host bridge after boot.

> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
>  arch/arm/include/asm/mach/pci.h | 1 +
>  arch/arm/kernel/bios32.c        | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 26c511f..736cb8d 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -21,6 +21,7 @@ struct hw_pci {
>  #endif
>         struct pci_ops  *ops;
>         int             nr_controllers;
> +       void            **private_data;
>         int             (*setup)(int nr, struct pci_sys_data *);
>         struct pci_bus *(*scan)(int nr, struct pci_sys_data *);
>         void            (*preinit)(void);
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 7288093..07a38d8 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -442,6 +442,9 @@ static void __devinit pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
>                 sys->map_irq = hw->map_irq;
>                 INIT_LIST_HEAD(&sys->resources);
>
> +               if (hw->private_data)
> +                       sys->private_data = hw->private_data[nr];
> +
>                 ret = hw->setup(nr, sys);
>
>                 if (ret > 0) {
> --
> 1.7.12
>
