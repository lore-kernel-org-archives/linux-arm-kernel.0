From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 22 May 2012 11:35:02 +0800
Subject: [PATCH RFC v2 2/2] pinctrl: add pinctrl gpio binding support
In-Reply-To: <4FB6AB9A.4080006@wwwdotorg.org>
References: <1337346755-8761-1-git-send-email-b29396@freescale.com>
 <1337346755-8761-2-git-send-email-b29396@freescale.com>
 <4FB6AB9A.4080006@wwwdotorg.org>
Message-ID: <20120522033501.GB27055@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2012 at 04:05:46AM +0800, Stephen Warren wrote:
...
> > +			np_gpio = of_find_node_by_phandle(phandle);
> > +			if (!np_gpio) {
> > +				dev_err(pctldev->dev,
> > +					"failed to find gpio node(%s)\n",
> > +					np_gpio->name);
> 
> Perhaps devm_kfree(ranges) here so that if this is called multiple times
> due to deferred probe, the allocations from the failed attempts don't
> accumulate. Same for other error paths.
> 
I checked a bit more, it seems the resource will be removed first if there's
a deffer probe error.
static int really_probe(struct device *dev, struct device_driver *drv)
{
.....
probe_failed:
        devres_release_all(dev);
        driver_sysfs_remove(dev);
        dev->driver = NULL;

        if (ret == -EPROBE_DEFER) {
                /* Driver requested deferred probing */
                dev_info(dev, "Driver %s requests probe deferral\n", drv->name);
                driver_deferred_probe_add(dev);
		...
	}
So we may not need devm_kfree for the EPROBE_DEFER error here.
It looks to me reasonable that managed resource covers the defer probe
error.

Regards
Dong Aisheng
