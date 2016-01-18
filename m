From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Jan 2016 10:32:17 +0000
Subject: [PATCH v2 01/16] Xen: ACPI: Hide UART used by Xen
In-Reply-To: <1452840929-19612-2-git-send-email-zhaoshenglong@huawei.com>
References: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
 <1452840929-19612-2-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160118103216.GB21067@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 02:55:14PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> ACPI 6.0 introduces a new table STAO to list the devices which are used
> by Xen and can't be used by Dom0. On Xen virtual platforms, the physical
> UART is used by Xen. So here it hides UART from Dom0.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net> (supporter:ACPI)
> CC: Len Brown <lenb@kernel.org> (supporter:ACPI)
> CC: linux-acpi at vger.kernel.org (open list:ACPI)
> ---
>  drivers/acpi/bus.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index a212cef..d7a559f 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -46,6 +46,7 @@ ACPI_MODULE_NAME("bus");
>  struct acpi_device *acpi_root;
>  struct proc_dir_entry *acpi_root_dir;
>  EXPORT_SYMBOL(acpi_root_dir);
> +static u64 spcr_uart_addr;
>  
>  #ifdef CONFIG_X86
>  #ifdef CONFIG_ACPI_CUSTOM_DSDT
> @@ -93,6 +94,17 @@ acpi_status acpi_bus_get_status_handle(acpi_handle handle,
>  {
>  	acpi_status status;
>  
> +	if (spcr_uart_addr != 0xffffffffffffffff) {

The SPCR spec says that the Base Address fields being zero means that
console redirection is disabled (though I'm not clear on whether or not
that requires the whole acpi_generic_address to be zero).

Can we not use that here?

Mark.

> +		u64 addr;
> +
> +		status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL,
> +					       &addr);
> +		if (ACPI_SUCCESS(status) && (addr == spcr_uart_addr)) {
> +			*sta = 0;
> +			return AE_OK;
> +		}
> +	}
> +
>  	status = acpi_evaluate_integer(handle, "_STA", NULL, sta);
>  	if (ACPI_SUCCESS(status))
>  		return AE_OK;
> @@ -1069,6 +1081,8 @@ EXPORT_SYMBOL_GPL(acpi_kobj);
>  static int __init acpi_init(void)
>  {
>  	int result;
> +	acpi_status status;
> +	struct acpi_table_stao *stao_ptr;
>  
>  	if (acpi_disabled) {
>  		printk(KERN_INFO PREFIX "Interpreter disabled.\n");
> @@ -1081,6 +1095,22 @@ static int __init acpi_init(void)
>  		acpi_kobj = NULL;
>  	}
>  
> +	/* If there is STAO table, check whether it needs to ignore the UART
> +	 * device in SPCR table.
> +	 */
> +	spcr_uart_addr = 0xffffffffffffffff;
> +	status = acpi_get_table(ACPI_SIG_STAO, 0,
> +				(struct acpi_table_header **)&stao_ptr);
> +	if (ACPI_SUCCESS(status)) {
> +		if (stao_ptr->ignore_uart) {
> +			struct acpi_table_spcr *spcr_ptr;
> +
> +			acpi_get_table(ACPI_SIG_SPCR, 0,
> +				       (struct acpi_table_header **)&spcr_ptr);
> +			spcr_uart_addr = spcr_ptr->serial_port.address;
> +		}
> +	}
> +
>  	init_acpi_device_notify();
>  	result = acpi_bus_init();
>  	if (result) {
> -- 
> 2.0.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
