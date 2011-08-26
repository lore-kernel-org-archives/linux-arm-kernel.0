From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 26 Aug 2011 08:59:44 -0700
Subject: [PATCH v3 11/13] of: add property iteration helpers
In-Reply-To: <20110826092632.GB3926@pulham.picochip.com>
References: <1314315824-9687-1-git-send-email-swarren@nvidia.com>
	<1314315824-9687-12-git-send-email-swarren@nvidia.com>
	<20110826092632.GB3926@pulham.picochip.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B24A40C8@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Iles wrote at Friday, August 26, 2011 3:27 AM:
> On Thu, Aug 25, 2011 at 05:43:42PM -0600, Stephen Warren wrote:
> > This patch adds macros for_each_u32_property_value and
> > for_each_string_property_value, which iterate over an array of values
> > within a device-tree property. Usage is for example:
> >
> > struct of_iter_string_prop iter;
> > for_each_string_property_value(iter, np, "pins")
> >         printk("Got value %s\n", iter.value);
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> Nicely implemented!

Thanks!

> For the !CONFIG_OF case, I *think* that
> of_iter_u32_prop and of_iter_string_prop can be empty struct's, but I
> wouldn't want to bet money on that!

Empty structs themselves certainly did compile OK, but the code that
uses these macros references iter.value directly, and isn't under #ifdef
CONFIG_OF, so that field has to exist.

I suppose an alternative would be to add an accessor function:

struct of_iter_string_prop iter;
for_each_string_property_value(iter, np, "pins")
        printk("Got value %s\n", of_iter_string_value(iter));

which would return NULL/"" when !CONFIG_OF, and hence allow iter.value
to be removed too. Do you think that's a good approach? It'd be easy to
implement.

-- 
nvpublic
