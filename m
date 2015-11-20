From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 15:04:11 +0100
Subject: [PATCH 09/11] clk: lpc32xx: add common clock framework driver
In-Reply-To: <1447981511-29653-10-git-send-email-vz@mleia.com>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
 <1447981511-29653-10-git-send-email-vz@mleia.com>
Message-ID: <3762298.NKYXldtldq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 November 2015 03:05:09 Vladimir Zapolskiy wrote:
> +
> +struct clk_proto_t {
> +       const char *name;
> +       const u8 parents[LPC32XX_CLK_PARENTS_MAX];
> +       u8 num_parents;
> +       unsigned long flags;
> +};
> +
> +#define CLK_PREFIX(LITERAL)            LPC32XX_CLK_ ## LITERAL
> +#define NUMARGS(...)   (sizeof((int[]){__VA_ARGS__})/sizeof(int))
> +
> +#define LPC32XX_CLK_DEFINE(_idx, _name, _flags, ...)           \
> +       [CLK_PREFIX(_idx)] = {                                  \
> +               .name = #_name,                                 \
> +               .flags = _flags,                                \
> +               .parents = { __VA_ARGS__ },                     \
> +               .num_parents = NUMARGS(__VA_ARGS__),            \
> +        }
> +

Try to not outsmart yourself with the macros. It's better to avoid
string concatenation so it's possible to grep for uses of some
constant.

I would probably not use a macro at all here and just open-code the
entire table. If you ensure that '0' is not a valid parent, then
you can leave out the .num_parents field and just look for the
zero-termination.

	Arnd
