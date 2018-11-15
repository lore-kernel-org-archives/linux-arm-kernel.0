From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Nov 2018 09:33:48 +0000
Subject: [PATCH v3 0/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
In-Reply-To: <20181115093034.GB23965@Red>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
 <20181024085700.GR30658@n2100.armlinux.org.uk>
 <20181115093034.GB23965@Red>
Message-ID: <20181115093348.GV30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 10:30:34AM +0100, LABBE Corentin wrote:
> On Wed, Oct 24, 2018 at 09:57:00AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Oct 24, 2018 at 07:35:46AM +0000, Corentin Labbe wrote:
> > > This patchset adds a new set of functions which are open-coded in lot of
> > > place.
> > > Basicly the pattern is always the same, "read, modify a bit, write"
> > > some driver and the powerpc arch already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)
> > 
> > The advantage of them being open-coded is that it's _obvious_ to the
> > reviewer that there is a read-modify-write going on which, in a multi-
> > threaded environment, may need some locking (so it should trigger a
> > review of the locking around that code.)
> > 
> > With it hidden inside a helper which has no locking itself, it becomes
> > much easier to pass over in review, which means that races are much
> > more likely to go unspotted - and that is bad news.
> > 
> 
> Hello
> 
> I understand your fear, but I think the benefit overhaul thoses.
> Furthermore, drivers which I have converted does not need such locking.
> 
> If you want I can rename the header to linux/setbits-non-atomic.h for making obvious the lack of locking.

It'd probably be better in the function name - it then doesn't get
"lost" that it's non-atomic when it's included via other headers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
