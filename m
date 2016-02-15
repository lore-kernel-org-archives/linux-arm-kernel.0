From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Feb 2016 17:52:50 +0000
Subject: [PATCH v5 RESEND 4/5] ARM: amba: Move reading of periphid to
 amba_match()
In-Reply-To: <1455101250-11327-5-git-send-email-m.szyprowski@samsung.com>
References: <1455101250-11327-1-git-send-email-m.szyprowski@samsung.com>
 <1455101250-11327-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20160215175250.GJ10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 11:47:29AM +0100, Marek Szyprowski wrote:
> From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> Reading the periphid when the Primecell device is registered means that
> the apb pclk must be available by then or the device won't be registered
> at all.
> 
> By reading the periphid in amba_match() we can return -EPROBE_DEFER if
> the apb pclk isn't there yet and the device will be retried later.

I've just realised, we can't do this.  We need to read the peripheral
ID at registration time, because that's published to userspace via
(a) a sysfs attribute, and (b) as part of the uevent, which will be
used by udev to locate the driver module.

So, this will have the side effect of breaking systems which have
AMBA primecell devices configured as modules.

Sorry, I can't apply this.  We can't regress existing platforms for
the sake of introducing new platforms to this code.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
