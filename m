From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 11:44:51 +0100
Subject: [RFC PATCH 4/4] mfd: syscon: add ACPI support
In-Reply-To: <1449047368-5768-5-git-send-email-wangkefeng.wang@huawei.com>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
 <1449047368-5768-5-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <2299982.06P4iKpkWk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 17:09:28 Kefeng Wang wrote:
> This enables syscon with ACPI support.
> syscon_regmap_lookup_by_dev_property() function was added. With helper
> device_get_reference_node() and acpi_dev_find_plat_dev(), it can be used
> in both DT and ACPI.
> 
> The device driver can obtain syscon using _DSD method in DSDT, an example
> is shown below.
> 
>     Device(CTL0) {
>           Name(_HID, "HISI0061")
>           Name(_CRS, ResourceTemplate() {
>                   Memory32Fixed(ReadWrite, 0x80000000, 0x10000)
>           })
>     }
> 
>     Device(DEV0) {
>           Name(_HID, "HISI00B1")
>           Name(_CRS, ResourceTemplate() {
>                   Memory32Fixed(ReadWrite, 0x8c030000, 0x10000)
>                   Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive){ 192 }
>           })
> 
>           Name (_DSD, Package () {
>               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>               Package () {
>                   Package () {"syscon",Package() {\_SB.CTL0} }
>               }
>           })
>     }
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

This sounds like a bad idea:

syscon is basically a hack to let us access register that the SoC designer
couldn't fit in anywhere sane. We need something like this with devicetree
because we decided not to have any interpreted bytecode to do this behind
our back.

With ACPI, the same thing is done with AML, which is actually nicer than
syscon (once you have to deal with all the problems introduced by AML).

Use that instead.

> +               pdev = acpi_dev_find_plat_dev(adev);
> +               if (!pdev)
> +                       return ERR_PTR(-ENODEV);
> +               syscon = platform_get_drvdata(pdev);

This still requires the syscon device to be probed first, which is
something we shouldn't really need any more.

A lot of syscon users depend on the regmap to be available before
device drivers are loaded, so we have changed the code to just look up
the device_node that is already present and ignore the device.

Once clps711x has been converted to DT, I think we can rip out the
syscon_regmap_lookup_by_pdevname() interface and separate the syscon
regmap handling from the device handling that we only really need
for debugfs.

> @@ -216,9 +259,16 @@ static const struct platform_device_id syscon_ids[] = {
>  	{ }
>  };
>  
> +static const struct acpi_device_id syscon_acpi_match[] = {
> +	{ "HISI0061", 0 }, /* better to use generic ACPI ID */
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, syscon_acpi_match);
> +
>  static struct platform_driver syscon_driver = {
>  	.driver = {
>  		.name = "syscon",
> +		.acpi_match_table = ACPI_PTR(syscon_acpi_match),
>  	},
>  	.probe		= syscon_probe,
>  	.id_table	= syscon_ids,

We certainly don't want to list specific devices, so the other problem
aside, we wouldn't merge it until there is an official ACPI way to
specify "random crap register areas" that does not depend on a vendor
specific ID.

	Arnd
