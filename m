From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 29 Apr 2014 10:51:03 +0100
Subject: [PATCH v3 part1 05/11] ARM64 / ACPI: Introduce early_param for
 "acpi"
In-Reply-To: <1398432017-8506-6-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-6-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140429095103.28ED7C4095B@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Apr 2014 21:20:11 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> Introduce two early parameters for "acpi", one is the parameter
> to disable ACPI on ARM64 and another one is acpi=strict to disable
> out-of-spec workarounds.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/plat/arm-core.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
> index 47b5d9b..e4846fd 100644
> --- a/drivers/acpi/plat/arm-core.c
> +++ b/drivers/acpi/plat/arm-core.c
> @@ -111,3 +111,21 @@ void __init acpi_boot_table_init(void)
>  		return;
>  	}
>  }
> +
> +static int __init parse_acpi(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	/* "acpi=off" disables both ACPI table parsing and interpreter */
> +	if (strcmp(arg, "off") == 0) {
> +		disable_acpi();
> +	}
> +	/* acpi=strict disables out-of-spec workarounds */
> +	else if (strcmp(arg, "strict") == 0) {
> +		acpi_strict = 1;
> +	}
> +
> +	return 0;
> +}
> +early_param("acpi", parse_acpi);

This is a cut down version of arch/x86/kernel/acpi/boot.c. Both the
'off' and 'strict' options appear useful regardless of platform. I would
consider refactoring this to have a common parse_acpi() and a call out
to another function for arch specific bits.

Otherwise:

Reviewed-by: Grant Likely <grant.likely@linaro.org>


> -- 
> 1.7.9.5
> 
