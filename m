From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 16:07:26 +0000
Subject: [PATCH 01/13] Xen : Hide UART used by Xen
In-Reply-To: <1447754231-7772-2-git-send-email-shannon.zhao@linaro.org>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
 <1447754231-7772-2-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511201541040.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC'ing ACPI maintainers.

Please use ./scripts/get_maintainer.pl to retrieve a list of maintainers
to CC for each patch.


On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> According to the STAO table, hide UART used by Xen from Dom0.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  drivers/acpi/bus.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index a212cef..e93806b 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -46,6 +46,7 @@ ACPI_MODULE_NAME("bus");
>  struct acpi_device *acpi_root;
>  struct proc_dir_entry *acpi_root_dir;
>  EXPORT_SYMBOL(acpi_root_dir);
> +static u64 uart_addr;

I would call this spcr_addr or spcr_uart_addr because there are many
uarts on the system but only one spcr. It might make sense to initialize
this to 0xffffffffffffffff rather than 0, which could actually be a
correct uart address.


>  #ifdef CONFIG_X86
>  #ifdef CONFIG_ACPI_CUSTOM_DSDT
> @@ -93,6 +94,16 @@ acpi_status acpi_bus_get_status_handle(acpi_handle handle,
>  {
>  	acpi_status status;
>
> +	if (uart_addr) {
> +		u64 addr;
> +		status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL,
> +					       &addr);
> +		if (ACPI_SUCCESS(status) && (addr == uart_addr)) {
> +			*sta = 0;
> +			return AE_OK;
> +		}
> +	}
> +
>  	status = acpi_evaluate_integer(handle, "_STA", NULL, sta);
>  	if (ACPI_SUCCESS(status))
>  		return AE_OK;
> @@ -1069,6 +1080,7 @@ EXPORT_SYMBOL_GPL(acpi_kobj);
>  static int __init acpi_init(void)
>  {
>  	int result;
> +	struct acpi_table_stao *stao_ptr;
>  
>  	if (acpi_disabled) {
>  		printk(KERN_INFO PREFIX "Interpreter disabled.\n");
> @@ -1081,6 +1093,16 @@ static int __init acpi_init(void)
>  		acpi_kobj = NULL;
>  	}
>  
> +	acpi_get_table(ACPI_SIG_STAO, 1,
> +		       (struct acpi_table_header **)&stao_ptr);
> +	if(stao_ptr->ignore_uart)
> +	{

Please follow the linux coding style. You can use
./scripts/checkpatch.pl to check for coding style errors.


> +		struct acpi_table_spcr *spcr_ptr;
> +		acpi_get_table(ACPI_SIG_SPCR, 1,
> +			       (struct acpi_table_header **)&spcr_ptr);
> +		uart_addr = spcr_ptr->serial_port.address;
> +	}
> +
>  	init_acpi_device_notify();
>  	result = acpi_bus_init();
>  	if (result) {
> -- 
> 2.1.0
> 
