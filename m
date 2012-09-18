From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 18 Sep 2012 11:13:23 -0600
Subject: [PATCH 1/2] ARM: pci: Keep pci_common_init() around after init
In-Reply-To: <1347657078-32230-2-git-send-email-thierry.reding@avionic-design.de>
References: <1347657078-32230-1-git-send-email-thierry.reding@avionic-design.de>
 <1347657078-32230-2-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <CAErSpo7bix_4bayh2ha_yogwNiLACU7Bymd_H5ur1wxF-tmTNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 3:11 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> When using deferred driver probing, PCI host controller drivers may
> actually require this function after the init stage.
>
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
>  arch/arm/kernel/bios32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 2b2f25e..7288093 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -423,7 +423,7 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>         return irq;
>  }
>
> -static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
> +static void __devinit pcibios_init_hw(struct hw_pci *hw, struct list_head *head)

Shouldn't we just remove __init completely, since Greg KH is in the
process of removing __devinit?

>  {
>         struct pci_sys_data *sys = NULL;
>         int ret;
> @@ -472,7 +472,7 @@ static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
>         }
>  }
>
> -void __init pci_common_init(struct hw_pci *hw)
> +void __devinit pci_common_init(struct hw_pci *hw)
>  {
>         struct pci_sys_data *sys;
>         LIST_HEAD(head);
> --
> 1.7.12
>
