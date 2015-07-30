From: robherring2@gmail.com (Rob Herring)
Date: Thu, 30 Jul 2015 11:45:53 -0500
Subject: [PATCH v3 1/2] PCI: generic: remove dependency on hw_pci
In-Reply-To: <1438183681-30519-1-git-send-email-jchandra@broadcom.com>
References: <1438183681-30519-1-git-send-email-jchandra@broadcom.com>
Message-ID: <CAL_JsqJBnr2zGZwOjiSmnRCR+Gq1D6avoOBKehhtpC7NeDeqhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 10:28 AM, Jayachandran C <jchandra@broadcom.com> wrote:
> The current code in pci-host-generic.c uses pci_common_init_dev()
> from ARM platform to do some of the PCI initializations, and this
> prevents it from being used in ARM64.
>
> The initialization done by pci_common_init_dev() that is needed
> by pci-host-generic.c is really limited, and can be done easily
> in the same file without using hw_pci API. The ARM platform
> requires a pci_sys_data as sysdata for the PCI bus, this can be
> handled by setting up gen_pci to have a pci_sys_data variable as
> the first element.
>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
> Here's v3 of the patchset.
>
> v2-v3
>  - rebase to 4.2-rc
>  - fix PCI_PROBE_ONLY check before calling pcie configure
>  - added a comment above sysdata
>  - updated the commit message
>
> v1->v2
>  - Address comments from Arnd Bergmann and Lorenzo Pieralisi
>     - move contents of gen_pci_init to gen_pci_probe
>     - assign resources only when !probe_only
>  - tested on ARM32 with qemu option -M virt
>
> Notes:
>  - passing a zeroed out pci_sys_data for ARM looks ok, but I haven't
>    tested it on ARM.

It is tested on other drivers.

>  - tested it on ARM64 fast model
>  - Any information on how this can be tested on arm is welcome.
>  - There is only one ifdef, and that can be removed when arm64 gets
>    a sysdata, or when arm loses its sysdata.
>

[...]

> @@ -258,7 +251,31 @@ static int gen_pci_probe(struct platform_device *pdev)
>                 return err;
>         }
>
> -       pci_common_init_dev(dev, &hw);
> +       /* do not reassign resource if probe only */
> +       if (!pci_has_flag(PCI_PROBE_ONLY))
> +               pci_add_flags(PCI_REASSIGN_ALL_RSRC);
> +
> +       bus = pci_scan_root_bus(dev, 0, &gen_pci_ops, pci, &pci->resources);
> +       if (!bus) {
> +               dev_err(dev, "Scanning rootbus failed");
> +               return -ENODEV;
> +       }
> +
> +       pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +
> +       if (!pci_has_flag(PCI_PROBE_ONLY)) {
> +               pci_bus_size_bridges(bus);
> +               pci_bus_assign_resources(bus);
> +       }
> +       pci_bus_add_devices(bus);
> +
> +       /* Configure PCI Express settings */
> +       if (!pci_has_flag(PCI_PROBE_ONLY)) {
> +               struct pci_bus *child;
> +
> +               list_for_each_entry(child, &bus->children, node)
> +                       pcie_bus_configure_settings(child);
> +       }

Can't we come up with a common function for all this hunk? Every host
doesn't nearly the same thing and I'd guess the differences are
omissions rather than necessary differences.

Rob
