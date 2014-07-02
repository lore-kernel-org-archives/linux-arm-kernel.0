From: tinamdar@apm.com (Tanmay Inamdar)
Date: Wed, 2 Jul 2014 11:06:38 -0700
Subject: [PATCH v8 2/9] pci: Export find_pci_host_bridge() function.
In-Reply-To: <1404240214-9804-3-git-send-email-Liviu.Dudau@arm.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <1404240214-9804-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <CACoXjck+aU33=kSy=KCGABNXNR7tj2KndAiBqEDK7wQ_Qei80Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 1, 2014 at 11:43 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> This is a useful function and we should make it visible outside the
> generic PCI code. Export it as a GPL symbol.
>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Tested-by: Tanmay Inamdar <tinamdar@apm.com>
> ---
>  drivers/pci/host-bridge.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index 0e5f3c9..36c669e 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -16,12 +16,13 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
>         return bus;
>  }
>
> -static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
>  {
>         struct pci_bus *root_bus = find_pci_root_bus(bus);
>
>         return to_pci_host_bridge(root_bus->bridge);
>  }
> +EXPORT_SYMBOL_GPL(find_pci_host_bridge);

Is there any specific reason behind making this symbol GPL? I think
the other functions in this file are just EXPORT_SYMBOL. Ultimately
companies which have non gpl Linux modules (nvidia) will face issue
using this API.

The same applies to 'of_create_pci_host_bridge'.
>
>  void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>                                  void (*release_fn)(struct pci_host_bridge *),
> --
> 2.0.0
>
