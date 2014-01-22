From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Jan 2014 09:26:50 +0100
Subject: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
In-Reply-To: <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
Message-ID: <CACRpkdYKwaH5DX27irzmcTDAMhQMUhuzz6N7mjKWv9tZchv0Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 1:25 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:

> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>
> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
> name from the ACPI timer table is matched with all the registered
> timer controllers and matching initialisation routine is invoked.
>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Actually I have a fat patch renaming CLOCKSOURCE_OF_DECLARE()
to TIMER_OF_DECLARE() and I think this macro, if needed, should
be named TIMER_ACPI_DECLARE().

The reason is that "clocksource" is a Linux-internal name and this
macro pertains to the hardware name in respective system
description type.

> +#ifdef CONFIG_ACPI
> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)                     \
> +       static const struct acpi_device_id __clksrc_acpi_table_##name   \
> +               __used __section(__clksrc_acpi_table)                   \
> +                = { .id = compat,                              \
> +                    .driver_data = (kernel_ulong_t)fn }
> +#else
> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)
> +#endif

This hammers down the world to compile one binary for ACPI
and one binary for device tree. Maybe that's fine, I don't know.

Yours,
Linus Walleij
