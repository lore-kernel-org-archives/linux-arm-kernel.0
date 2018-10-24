From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Oct 2018 09:57:00 +0100
Subject: [PATCH v3 0/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
In-Reply-To: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
Message-ID: <20181024085700.GR30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 07:35:46AM +0000, Corentin Labbe wrote:
> This patchset adds a new set of functions which are open-coded in lot of
> place.
> Basicly the pattern is always the same, "read, modify a bit, write"
> some driver and the powerpc arch already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)

The advantage of them being open-coded is that it's _obvious_ to the
reviewer that there is a read-modify-write going on which, in a multi-
threaded environment, may need some locking (so it should trigger a
review of the locking around that code.)

With it hidden inside a helper which has no locking itself, it becomes
much easier to pass over in review, which means that races are much
more likely to go unspotted - and that is bad news.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
