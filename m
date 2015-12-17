From: zwisler@gmail.com (Ross Zwisler)
Date: Thu, 17 Dec 2015 10:50:48 -0700
Subject: -next regression: "driver cohandle -EPROBE_DEFER from
 bus_type.match()"
In-Reply-To: <CAPcyv4hOJuT=i2A_0vDQHsL7MXNgVN_p17q3UW6EcTkxsCMmeg@mail.gmail.com>
References: <CAPcyv4hOJuT=i2A_0vDQHsL7MXNgVN_p17q3UW6EcTkxsCMmeg@mail.gmail.com>
Message-ID: <CAOxpaSW=t6WCLrZryBE4j91nnWdT9ckiV_L9ZRsxS8NuOgcVrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 8:51 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> The commit below causes the libnvdimm sub-system to stop loading.
> This is due to the fact that nvdimm_bus_match() returns the result of
> test_bit() which may be negative.  If there are any other bus match
> functions using test_bit they may be similarly impacted.
>
> Can we queue a fixup like the following to libnvdimm, and maybe
> others, ahead of this driver core change?
>
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 7e2c43f701bc..2b2181cdeb63 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -62,7 +62,7 @@ static int nvdimm_bus_match(struct device *dev,
> struct device_driver *drv)
> {
>        struct nd_device_driver *nd_drv = to_nd_device_driver(drv);
>
> -       return test_bit(to_nd_device_type(dev), &nd_drv->type);
> +       return !!test_bit(to_nd_device_type(dev), &nd_drv->type);

How is this call to test_bit() returning a negative value?  That can
only happen if the bit number we supply is 63, correct?  I only see
to_nd_device_type() returning 1-6 for the defines ND_DEVICE_DIMM thru
ND_DEVICE_NAMESPACE_BLK?
