From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Mon, 19 Feb 2018 18:22:29 +0000
Subject: [PATCH 1/8] clk: Add clk_bulk_alloc functions
In-Reply-To: <1519055046-2399-2-git-send-email-m.purski@samsung.com>
References: <CGME20180219154456eucas1p15f4073beaf61312238f142f217a8bb3c@eucas1p1.samsung.com>
 <1519055046-2399-1-git-send-email-m.purski@samsung.com>
 <1519055046-2399-2-git-send-email-m.purski@samsung.com>
Message-ID: <CACvgo50-Cx_=yvbLD-osxHXnrdENHpwFBkrXT_jV4R9vJniTjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Maciej,

Just sharing a couple of fly-by ideas - please don't read too much into them.

On 19 February 2018 at 15:43, Maciej Purski <m.purski@samsung.com> wrote:
> When a driver is going to use clk_bulk_get() function, it has to
> initialize an array of clk_bulk_data, by filling its id fields.
>
> Add a new function to the core, which dynamically allocates
> clk_bulk_data array and fills its id fields. Add clk_bulk_free()
> function, which frees the array allocated by clk_bulk_alloc() function.
> Add a managed version of clk_bulk_alloc().
>
Most places use a small fixed number of struct clk pointers.
Using devres + kalloc to allocate 1-4 pointers feels a bit strange.

Quick grep shows over 150 instances that could be updated to use the new API.
Adding a cocci script to simplify the transition would be a good idea.

> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -15,6 +15,7 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/notifier.h>
> +#include <linux/slab.h>
>
The extra header declaration should not be needed. One should be able
to forward declare any undefined structs.

HTH
Emil
