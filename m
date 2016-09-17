From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Sep 2016 10:17:54 +0100
Subject: [PATCH v3 1/3] tty: amba-pl011: define flag register bits for
 ZTE device
In-Reply-To: <20160917053753.GG7398@tiger>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
 <1467968441-4056-2-git-send-email-shawn.guo@linaro.org>
 <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
 <20160916163952.GH1041@n2100.armlinux.org.uk>
 <57DC27A9.3060307@codeaurora.org> <20160917053753.GG7398@tiger>
Message-ID: <20160917091753.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2016 at 01:37:53PM +0800, Shawn Guo wrote:
> I still think that's a bad idea.  ZTE is not the first one making such
> small customization on PL011, and likely won't be the last one.  We
> don't want to clone PL011 driver every time there is a such vendor
> hardware coming out, do we?  Having PL011 driver being able to handle
> different register layout is very helpful to handle such vendor
> variants, IMHO.

Well, it's turning out that handling ZTE in PL011 is turning into a
bad idea as well - we keep getting these breakages each time we try.

I think ZTE is sufficiently different from PL011 with the different
register layout _and_ the different bits, _and_ the pain that this
is causing, that it should have been a separate driver.

The only way I can think of dealing with the console issue is to
replicate the console code, once for the PL011 variant and then
again for the ZTE variant.  We can't _both_ give them the same names
_and_ register them together - we either have to give them different
names, which makes it confusing because one name won't match the
userspace name for the UART, or we need the driver to detect the
port type early.  That's made much more difficult because ZTE didn't
bother with the ID registers, unlike every other vendor.

Serial drivers are not that complex anymore, compared to how they
were back before serial_core happened, so having it as a separate
driver isn't that big a deal.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
