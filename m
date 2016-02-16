From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Feb 2016 16:31:43 +0000
Subject: [PATCH v5 RESEND 4/5] ARM: amba: Move reading of periphid to
 amba_match()
In-Reply-To: <20160215175250.GJ10826@n2100.arm.linux.org.uk>
References: <1455101250-11327-1-git-send-email-m.szyprowski@samsung.com>
 <1455101250-11327-5-git-send-email-m.szyprowski@samsung.com>
 <20160215175250.GJ10826@n2100.arm.linux.org.uk>
Message-ID: <20160216163143.GD19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 05:52:50PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 10, 2016 at 11:47:29AM +0100, Marek Szyprowski wrote:
> > From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > 
> > Reading the periphid when the Primecell device is registered means that
> > the apb pclk must be available by then or the device won't be registered
> > at all.
> > 
> > By reading the periphid in amba_match() we can return -EPROBE_DEFER if
> > the apb pclk isn't there yet and the device will be retried later.
> 
> I've just realised, we can't do this.  We need to read the peripheral
> ID at registration time, because that's published to userspace via
> (a) a sysfs attribute, and (b) as part of the uevent, which will be
> used by udev to locate the driver module.
> 
> So, this will have the side effect of breaking systems which have
> AMBA primecell devices configured as modules.
> 
> Sorry, I can't apply this.  We can't regress existing platforms for
> the sake of introducing new platforms to this code.

I just re-applied the patch set to the amba branch, and then dropped
the last two patches because of this issue.  Please ignore the "applied"
notification for the last two patches from the patch system.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
