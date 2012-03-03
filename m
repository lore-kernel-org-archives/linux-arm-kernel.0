From: mturquette@ti.com (Turquette, Mike)
Date: Sat, 3 Mar 2012 09:14:43 -0800
Subject: [PATCH v5 3/4] clk: introduce the common clock framework
In-Reply-To: <20120303133158.GA26882@pengutronix.de>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
 <1330763341-3437-4-git-send-email-mturquette@linaro.org>
 <20120303133158.GA26882@pengutronix.de>
Message-ID: <CAJOA=zNFNEHxBDhRDdvm7DYR83R0LJjsp_AT3BoG+nL+iN5_tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 3, 2012 at 5:31 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Sat, Mar 03, 2012 at 12:29:00AM -0800, Mike Turquette wrote:
>> The common clock framework defines a common struct clk useful across
>> most platforms as well as an implementation of the clk api that drivers
>> can use safely for managing clocks.
>>
>> The net result is consolidation of many different struct clk definitions
>> and platform-specific clock framework implementations.
>>
>> This patch introduces the common struct clk, struct clk_ops and an
>> implementation of the well-known clock api in include/clk/clk.h.
>> Platforms may define their own hardware-specific clock structure and
>> their own clock operation callbacks, so long as it wraps an instance of
>> struct clk_hw.
>>
>> See Documentation/clk.txt for more details.
>>
>> This patch is based on the work of Jeremy Kerr, which in turn was based
>> on the work of Ben Herrenschmidt.
>>
>> +
>> +/**
>> + * struct clk_hw - handle for traversing from a struct clk to its corresponding
>> + * hardware-specific structure. ?struct clk_hw should be declared within struct
>> + * clk_foo and then referenced by the struct clk instance that uses struct
>> + * clk_foo's clk_ops
>> + *
>> + * clk: pointer to the struct clk instance that points back to this struct
>> + * clk_hw instance
>> + */
>> +struct clk_hw {
>> + ? ? struct clk *clk;
>> +};
>
> The reason for doing this is that struct clk should be an opaque cookie
> for both drivers and implementers of clocks. I recently had the idea whether
> the roles of these two structs could be swapped. So instead of the above we
> could do:
>
> struct clk {
> ? ? ? ?struct clk_hw *hw;
> }

Firstly, struct clk is an opaque cookie for both drivers and
implementers of clocks with this patchset.

Secondly, struct clk does indeed have a pointer to struct clk_hw.
Refer to include/linux/clk-private.h in this patch.

The reference is cyclical.  A reference to struct clk can navigate to
struct clk_foo via container_of (usually something like "#define
to_clk_foo(_hw) container_of(_hw, struct clk_foo, hw)" where struct
clk's pointer to it's .hw member is passed into one of the struct
clk_ops callbacks.

Likewise if struct clk_foo needs the struct clk ptr for any reason
then it can get it from foo->hw->clk.

I believe this patch already does what you suggest, but I might be
missing your point.

>
> The effect would be the same, but this version would make the struct clk
> pointer known at compile time thus making it possible for static
> initializers to specify their parent clock.

This series achieves this goal also.  include/linux/clk-private.h
defines struct clk as well as macros for statically initializing the
basic clock types.  Pointers to the struct clk of a parent clock can
and are pre-populated in these macros, along with the mandatory array
of parent string names.  (note that parent pointer initialization is
optional and you can always pass in NULL into that specific field of
the macro)

>
> I just saw that clk_register now takes a parent name array, that may
> make this change unnecessary anyway.

clk_register exists for dynamic allocation and solves a different
problem from what you describe above.  For statically initialized
clocks the following is sufficient:

#include <linux/clk-private.h>

static char *abe_dpll_refclk_mux_ck_parent_names[] = {
        "sys_clkin_ck",
        "sys_32k_ck",
};

static struct clk *abe_dpll_refclk_mux_ck_parents[] = {
        &sys_clkin_ck,
        &sys_32k_ck,
};

DEFINE_CLK_MUX(abe_dpll_refclk_mux_ck,
        abe_dpll_refclk_mux_ck_parent_names,
        abe_dpll_refclk_mux_ck_parents,
        0x0,
        OMAP4430_CM_ABE_PLL_REF_CLKSEL,
        OMAP4430_CLKSEL_0_0_SHIFT,
        OMAP4430_CLKSEL_0_0_WIDTH,
        0x0,
        NULL);

__clk_init(NULL, &abe_dpll_refclk_mux_ck);

You might find it helpful to see how I've handled statically
initialized clocks for OMAP4.  These patches are a work in progress
but I'll send an RFC to the list very soon since others might find it
useful.  For now the above example can be seen in more detail at:
http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob;f=arch/arm/mach-omap2/clock44xx_data.c;h=7f833a7b2dca84a52c2bd1e7c8d9cfe560771258;hb=v3.3-rc5-clkv5-omap#l205

Let me know if I've missed your point somehow.

Thanks for the review,
Mike

>
> Sascha
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
