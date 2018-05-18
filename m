From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 19 May 2018 00:50:08 +0300
Subject: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
In-Reply-To: <20180517154701.GA20281@e107155-lin>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
 <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
 <a64ed431-0f60-2711-4138-eeefc7ba2d8b@arm.com>
 <20180517154701.GA20281@e107155-lin>
Message-ID: <CAHp75VfEYcPdECmDDOd8CLBBXGpcwSUGQRr0x8VTb1-7j51_0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 6:47 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> Is below patch does what you were looking for ?

Somewhat.
See below for some minors.

> of_property_read_u64 searches for a property in a device node and read
> a 64-bit value from it. Instead of using of_get_property to get the
> property and then read 64-bit value using of_read_number, we can make
> use of of_property_read_u64.

Suggested-by?

> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>


> -       cache_size = of_get_property(np, propname, NULL);
> -       if (cache_size)
> -               this_leaf->size = of_read_number(cache_size, 1);
> +       if (!of_property_read_u64(np, propname, &cache_size))
> +               this_leaf->size = cache_size;

I suppose it's something like this

ret = of_property_...(..., &this_leaf->VAR);
if (ret)
 warning / set default / etc

>                 propname = cache_type_info[ct_idx].line_size_props[i];
> -               line_size = of_get_property(np, propname, NULL);
> -               if (line_size)
> +               line_size = of_property_read_u64(np, propname, &line_size);
> +               if (line_size) {

ret = ...
if (ret) {

> +                       this_leaf->coherency_line_size = line_size;
>                         break;
> +               }

> +       if (!of_property_read_u64(np, propname, &nr_sets))
> +               this_leaf->number_of_sets = nr_sets;

As in first case.

-- 
With Best Regards,
Andy Shevchenko
