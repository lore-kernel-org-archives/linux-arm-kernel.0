From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Nov 2014 15:32:57 +0000
Subject: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
In-Reply-To: <1416237550-31092-1-git-send-email-ulf.hansson@linaro.org>
References: <1416237550-31092-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20141117153257.GS4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 04:19:10PM +0100, Ulf Hansson wrote:
> The amba bus, amba drivers and a vast amount of platform drivers which
> enables runtime PM, don't invoke a pm_runtime_get_sync() while probing
> their devices.
> 
> Instead, once they have turned on their PM resourses during ->probe()
> and are ready to handle I/O, these invokes pm_runtime_set_active() to
> synchronize its state towards the runtime PM core.

The above is misleading for amba.  The code sequence is:

                pm_runtime_get_noresume(dev);
                pm_runtime_set_active(dev);
                pm_runtime_enable(dev);

                ret = pcdrv->probe(pcdev, id);

AMBA drivers should never call pm_runtime_set_active(), as the runtime PM
state has already been initialised by the bus code.  Platform drivers are
different; the platform code provides zero help for runtime PM.

The sequence used by AMBA bus code is the sequence which was used by PCI
(as per commit f3ec4f87d607) at the time the runtime PM support was
written for AMBA.  PCI assumes that unbound devices are already powered
up, and as far as I'm aware, that's also true of AMBA devices as well.
I have yet to have access to a platform where this isn't true, neither
has anyone reported that such a platform exists.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
