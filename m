From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 28 Mar 2017 13:53:24 +0100
Subject: [Update][PATCH v9.1 15/15] irqchip: mbigen: Add ACPI support
In-Reply-To: <1490703665-4932-1-git-send-email-hanjun.guo@linaro.org>
References: <1490703665-4932-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <58DA5CC4.1060901@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On 2017/3/28 13:21, Hanjun Guo wrote:
> With the preparation of platform msi support and interrupt producer
> in commit d44fa3d46079 ("ACPI: Add support for ResourceSource/IRQ
> domain mapping"), we can add mbigen ACPI support now.
> 
> Now that the major framework changes are ready, we just need to add
> the ACPI probe code which creates the irqdomain for devices connecting
> to it.
> 
> In order to create the irqdomain, we need to know the number of hw
> irqs as input which is provided by mbigen. In DT case, we are using
> "num-pins" property to describe it, and we will take advantage of
> that too using _DSD in ACPI as there is no standard way of describe
> it in ACPI way, also according to the _DSD rule described in
> Documentation/acpi/DSD-properties-rules.txt, it doesn't break
> the rules.
> 
> The DSDT is represented as below:
> 
> For mbigen,
>   Device(MBI0) {
>           Name(_HID, "HISI0152")
>           Name(_UID, Zero)
>           Name(_CRS, ResourceTemplate() {
>                   Memory32Fixed(ReadWrite, 0xa0080000, 0x10000)
>           })
> 
>          Name(_DSD, Package () {
>                  ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                  Package () {
>                          Package () {"num-pins", 378}
>                  }
>         })
>  }
> 
> For devices,
>  Device(SAS0) {
>          Name(_HID, "HISIxxxx")
>          Name(_UID, Zero)
>          Name(_CRS, ResourceTemplate() {
>                  Memory32Fixed(ReadWrite, 0xb0030000, 0x10000)
> 		 Interrupt(ResourceConsumer,..., "\_SB.MBI0") {12, ...}
>          })
>  }
> 
> So for the devices connected to the mbigen, as we clearly say that
> it refers to a specific interrupt controller (mbigen), we can get
> the virq from mbigen's irqdomain once it's created successfully.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: MaJun <majun258@huawei.com>
> Cc: Al Stone <ahs3@redhat.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Thanks!
Tested on D05 board, the SAS disks and XGE port are working fine.
The log is as below:

	estuary:/$ dmesg
	[ 0.000000] Booting Linux on physical CPU 0x10000
	[ 0.000000] Linux version 4.11.0-rc1-00015-g80bbc749bffb (joyx at htsatcamb-server) (gcc version 5.1.1 20150608 (Linaro GCC 5.1-2015.08) ) #36 SMP PREEMPT Mon Mar 27 15:08:08 BST 2017
	[ 0.000000] Boot CPU: AArch64 Processor [410fd082]
	[ 0.000000] efi: Getting EFI parameters from FDT:
	[ 0.000000] efi: EFI v2.60 by EDK II
	[ 0.000000] efi: SMBIOS=0x3f040000 SMBIOS 3.0=0x39af0000 ACPI=0x39bc0000 ACPI 2.0=0x39bc0014 MEMATTR=0x3cc86018
	[ 0.000000] cma: Reserved 16 MiB at 0x000000003e000000

	estuary:/$ cat /dev/sd
	sda sdb sdb1 sdb2 sdc sdd sde sdf

	estuary:/$ ping -I eth1 172.18.45.23
	PING 172.18.45.23 (172.18.45.23): 56 data bytes
	64 bytes from 172.18.45.23: seq=0 ttl=64 time=0.216 ms
	64 bytes from 172.18.45.23: seq=1 ttl=64 time=0.082 ms
	64 bytes from 172.18.45.23: seq=2 ttl=64 time=0.077 ms

	estuary:/$ lspci -mk
	30:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
	91:00.0 "Class 0300" "19e5" "1711" "0000" "0000"
	90:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
	20:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
	10:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"

So:
Tested-by: Wei Xu <xuwei5@hisilicon.com>

Best Regards,
Wei

> ---
>  drivers/irqchip/irq-mbigen.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 3756408..061cdb8 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -16,6 +16,7 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqchip.h>
>  #include <linux/module.h>
> @@ -180,7 +181,7 @@ static int mbigen_domain_translate(struct irq_domain *d,
>  				    unsigned long *hwirq,
>  				    unsigned int *type)
>  {
> -	if (is_of_node(fwspec->fwnode)) {
> +	if (is_of_node(fwspec->fwnode) || is_acpi_device_node(fwspec->fwnode)) {
>  		if (fwspec->param_count != 2)
>  			return -EINVAL;
>  
> @@ -271,6 +272,58 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ACPI
> +static int mbigen_acpi_create_domain(struct platform_device *pdev,
> +				     struct mbigen_device *mgn_chip)
> +{
> +	struct irq_domain *domain;
> +	u32 num_pins = 0;
> +	int ret;
> +
> +	/*
> +	 * "num-pins" is the total number of interrupt pins implemented in
> +	 * this mbigen instance, and mbigen is an interrupt controller
> +	 * connected to ITS  converting wired interrupts into MSI, so we
> +	 * use "num-pins" to alloc MSI vectors which are needed by client
> +	 * devices connected to it.
> +	 *
> +	 * Here is the DSDT device node used for mbigen in firmware:
> +	 *	Device(MBI0) {
> +	 *		Name(_HID, "HISI0152")
> +	 *		Name(_UID, Zero)
> +	 *		Name(_CRS, ResourceTemplate() {
> +	 *			Memory32Fixed(ReadWrite, 0xa0080000, 0x10000)
> +	 *		})
> +	 *
> +	 *		Name(_DSD, Package () {
> +	 *			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +	 *			Package () {
> +	 *				Package () {"num-pins", 378}
> +	 *			}
> +	 *		})
> +	 *	}
> +	 */
> +	ret = device_property_read_u32(&pdev->dev, "num-pins", &num_pins);
> +	if (ret || num_pins == 0)
> +		return -EINVAL;
> +
> +	domain = platform_msi_create_device_domain(&pdev->dev, num_pins,
> +						   mbigen_write_msg,
> +						   &mbigen_domain_ops,
> +						   mgn_chip);
> +	if (!domain)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +#else
> +static inline int mbigen_acpi_create_domain(struct platform_device *pdev,
> +					    struct mbigen_device *mgn_chip)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  static int mbigen_device_probe(struct platform_device *pdev)
>  {
>  	struct mbigen_device *mgn_chip;
> @@ -289,9 +342,18 @@ static int mbigen_device_probe(struct platform_device *pdev)
>  	if (IS_ERR(mgn_chip->base))
>  		return PTR_ERR(mgn_chip->base);
>  
> -	err = mbigen_of_create_domain(pdev, mgn_chip);
> -	if (err)
> +	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
> +		err = mbigen_of_create_domain(pdev, mgn_chip);
> +	else if (ACPI_COMPANION(&pdev->dev))
> +		err = mbigen_acpi_create_domain(pdev, mgn_chip);
> +	else
> +		err = -EINVAL;
> +
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to create mbi-gen@%p irqdomain",
> +			mgn_chip->base);
>  		return err;
> +	}
>  
>  	platform_set_drvdata(pdev, mgn_chip);
>  	return 0;
> @@ -303,10 +365,17 @@ static int mbigen_device_probe(struct platform_device *pdev)
>  };
>  MODULE_DEVICE_TABLE(of, mbigen_of_match);
>  
> +static const struct acpi_device_id mbigen_acpi_match[] = {
> +	{ "HISI0152", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
> +
>  static struct platform_driver mbigen_platform_driver = {
>  	.driver = {
>  		.name		= "Hisilicon MBIGEN-V2",
>  		.of_match_table	= mbigen_of_match,
> +		.acpi_match_table = ACPI_PTR(mbigen_acpi_match),
>  	},
>  	.probe			= mbigen_device_probe,
>  };
> 
