From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Nov 2015 13:56:51 +0100
Subject: Grafting old platform drivers onto a new DT kernel
In-Reply-To: <5641E6C0.8090507@free.fr>
References: <563B3749.50701@free.fr> <yw1xh9kv5c60.fsf@unicorn.mansr.com>
 <5641E6C0.8090507@free.fr>
Message-ID: <5369244.M0xZ8N1mEo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 November 2015 13:44:48 Mason wrote:
> On 09/11/2015 18:13, M?ns Rullg?rd wrote:
> 
> > Add something like this:
> > 
> > static const struct of_device_id tangox_sdio_dt_ids[] = {
> >       { .compatible = "sigma,tangox-sdio" },
> >       { }
> > };
> > 
> > static struct platform_driver tangox_platform_sdio0 = {
> >       .probe          = sdhci_tangox_probe,
> 
> It looks like one side effect of this transformation is that
> the probe function cannot be __init anymore? Is that correct?
> 
> For this one particular driver, it weighs 944 bytes. (I guess
> a few kilobytes wasted is no big deal...)

Strictly speaking, it was already broken before. You can
detach and reattach a device from a driver through sysfs,
and that will call the probe function again, so it cannot
be marked as __init.

	Arnd
