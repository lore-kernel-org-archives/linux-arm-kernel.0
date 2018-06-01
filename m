From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 1 Jun 2018 18:02:31 +0300
Subject: [PATCH] PCI: move early dump functionality from x86 arch into the
 common code
In-Reply-To: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
References: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
Message-ID: <CAHp75Vc3YKAR1P_F0fwD+ueGub4gVUjP0=wv4Egf_fTSVkSUjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 7:34 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Move early dump functionality into common code so that it is available for
> all archtiectures. No need to carry arch specific reads around as the read
> hooks are already initialized by the time pci_setup_device() is getting
> called during scan.

>  /* If set, the PCIe ATS capability will not be used. */
>  static bool pcie_ats_disabled;
>
> +bool pci_early_dump;
> +

I didn't check above these, but maybe a good idea to add one line
comment what is this about?


>  extern const unsigned char pcie_link_speed[];
> -
> +extern bool pci_early_dump;
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>

Hmm... I would rather not attach this line to some function declarations.

> +static void early_dump_pci_device(struct pci_dev *pdev)
> +{
> +       u32 value[256 / 4];
> +       int i;
> +
> +       dev_info(&pdev->dev, "pci 0000:%02x:%02x.%d config space:\n",
> +                pdev->bus->number, PCI_SLOT(pdev->devfn),
> +                PCI_FUNC(pdev->devfn));

Shouldn't be this changed to pci_info() ?

> +
> +       for (i = 0; i < 256; i += 4)
> +               pci_read_config_dword(pdev, i, &value[i / 4]);
> +
> +       print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value,
> +                      256, false);
> +}

-- 
With Best Regards,
Andy Shevchenko
