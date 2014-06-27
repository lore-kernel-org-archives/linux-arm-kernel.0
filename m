From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Jun 2014 11:07:48 +0200
Subject: [PATCH v4 06/13] ARM64 / ACPI: Introduce early_param for "acpi"
In-Reply-To: <1403840976-7456-7-git-send-email-hanjun.guo@linaro.org>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
 <1403840976-7456-7-git-send-email-hanjun.guo@linaro.org>
Message-ID: <23398804.v8nA0xfjOe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 June 2014 11:49:29 Hanjun Guo wrote:
> +
> +static int __init parse_acpi(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       /* "acpi=off" disables both ACPI table parsing and interpreter */
> +       if (strcmp(arg, "off") == 0) {
> +               disable_acpi();
> +       }
> +       /* acpi=strict disables out-of-spec workarounds */
> +       else if (strcmp(arg, "strict") == 0) {
> +               acpi_strict = 1;
> +       } else {
> +               /* Core will printk when we return error */
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +early_param("acpi", parse_acpi);

Can you explain in the changelog what happens for the acpi=off case? Does this
mean we fall back to using data from the dtb instead, or will it just not work?

If I understand correctly, this option makes sense on PC systems that will
still be able to boot using the legacy BIOS services and implicit assumptions
about the hardware, but that never works on arm64.

	Arnd
