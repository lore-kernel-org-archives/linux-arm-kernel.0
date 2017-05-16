From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 16 May 2017 22:14:40 +0200
Subject: [PATCH 2/2] PCI: Avoid bus reset for Cavium cn8xxx root ports.
In-Reply-To: <20170516001736.4001-3-david.daney@cavium.com>
References: <20170516001736.4001-1-david.daney@cavium.com>
 <20170516001736.4001-3-david.daney@cavium.com>
Message-ID: <235a9a51-df06-84af-4e5d-b6408ceb0b7d@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16/05/2017 02:17, David Daney wrote:
> Root ports of cn8xxx do not function after bus reset when used with
> some e1000e and LSI HBA devices.  Add a quirk to prevent bus reset on
> these root ports.
I understand the bus reset would work along with a variety of other
child devices. I guess there is no way to be more accurate and forbid
the bus reset only when incompatible child devices are found?
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/pci/quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 085fb78..02cd847 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3347,6 +3347,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
>  
> +/*
> + * Root port on some Cavium CN8xxx chips do not successfully complete
> + * a bus reset when used with certain types child devices.  Config
s/types /types of
Thanks

Eric
> + * space access to the child may quit responding.  Flag the root port
> + * as not supporting bus reset.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
> +
>  static void quirk_no_pm_reset(struct pci_dev *dev)
>  {
>  	/*
> 
