From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Aug 2012 13:23:02 +0800
Subject: [PATCH v2 2/4] PM / OPP: Initialize OPP table from device tree
In-Reply-To: <501F4B58.4020308@gmail.com>
References: <1344179121-17738-1-git-send-email-shawn.guo@linaro.org>
 <1344179121-17738-3-git-send-email-shawn.guo@linaro.org>
 <501F30F8.1040105@gmail.com>
 <20120806031916.GC22302@S2101-09.ap.freescale.net>
 <501F4B58.4020308@gmail.com>
Message-ID: <20120806052300.GD22302@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 05, 2012 at 11:43:04PM -0500, Rob Herring wrote:
> On 08/05/2012 10:19 PM, Shawn Guo wrote:
> > On Sun, Aug 05, 2012 at 09:50:32PM -0500, Rob Herring wrote:
> >> I think this whole function can be written more concisely. Just iterate
> >> over the property and avoid the intermediate array allocation.
> >>
> > I'm not sure about that, since directly iterating over the property
> > means we have to take care of all these sanity checks done in API
> > of_property_read_u32_array().
> > 
> 
> This won't work?:
> 
It should work.  But I rewrote the function like below after I find
the sanity check is simple enough to take care of it on our own.

The code does look more concise and still easy to read.

Regards,
Shawn

int of_init_opp_table(struct device *dev)
{
        const struct property *prop;
        const __be32 *val;
        int nr;

        prop = of_find_property(dev->of_node, "operating-points", NULL);
        if (!prop)
                return -ENODEV;
        if (!prop->value)
                return -ENODATA;

        /*
         * Each OPP is a set of tuples consisting of frequency and
         * voltage like <freq-kHz vol-uV>.
         */
        nr = prop->length / sizeof(u32);
        if (nr % 2) {
                dev_err(dev, "%s: Invalid OPP list\n", __func__);
                return -EINVAL;
        }

        val = prop->value;
        while (nr) {
                unsigned long freq = be32_to_cpup(val++) * 1000;
                unsigned long volt = be32_to_cpup(val++);

                if (opp_add(dev, freq, volt)) {
                        dev_warn(dev, "%s: Failed to add OPP %ld\n",
                                 __func__, freq);
                        continue;
                }
                nr -= 2;
        }

        return 0;
}
