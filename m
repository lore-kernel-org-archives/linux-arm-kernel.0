From: konrad@darnok.org (Konrad Rzeszutek Wilk)
Date: Fri, 24 Nov 2017 08:29:48 -0500
Subject: [PATCH V2 07/29] ibft: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511390964-9979-8-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
 <1511390964-9979-8-git-send-email-okaya@codeaurora.org>
Message-ID: <20171124132946.GA16160@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 05:49:02PM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().

Aha!
> 
> We don't search for the device in other domains than zero. This is because
> on x86 platforms the BIOS executes only devices which are in domain 0.
> Furthermore, the iBFT spec doesn't have a domain id field.

Acked-by: Konrad Rzeszutek Wilk <konrad@kernel.org>
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/firmware/iscsi_ibft.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
> index 14042a6..6bc8e66 100644
> --- a/drivers/firmware/iscsi_ibft.c
> +++ b/drivers/firmware/iscsi_ibft.c
> @@ -719,8 +719,9 @@ static int __init ibft_create_kobject(struct acpi_table_ibft *header,
>  		* executes only devices which are in domain 0. Furthermore, the
>  		* iBFT spec doesn't have a domain id field :-(
>  		*/
> -		pci_dev = pci_get_bus_and_slot((nic->pci_bdf & 0xff00) >> 8,
> -					       (nic->pci_bdf & 0xff));
> +		pci_dev = pci_get_domain_bus_and_slot(0,
> +						(nic->pci_bdf & 0xff00) >> 8,
> +						(nic->pci_bdf & 0xff));
>  		if (pci_dev) {
>  			rc = sysfs_create_link(&boot_kobj->kobj,
>  					       &pci_dev->dev.kobj, "device");
> -- 
> 1.9.1
> 
