From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Feb 2012 12:20:22 +0000
Subject: [PATCH v2 6/6] mmc: omap_hsmmc: Don't expect MMC1 to always
 have vmmc supply
In-Reply-To: <CANfBPZ89Wdu2hWRU2XiPpWpU-BMbs3Z+yhNoR7hp4MH3vRYfbg@mail.gmail.com>
References: <1329818589-10062-1-git-send-email-rnayak@ti.com>
 <1329818589-10062-7-git-send-email-rnayak@ti.com>
 <CANfBPZ89Wdu2hWRU2XiPpWpU-BMbs3Z+yhNoR7hp4MH3vRYfbg@mail.gmail.com>
Message-ID: <20120221122022.GC22675@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 05:43:54PM +0530, S, Venkatraman wrote:
> On Tue, Feb 21, 2012 at 3:33 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> > @@ -324,8 +302,8 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host
> > *host)
> > ? ? ? ? ? ? ? ? ? ? ? ?mmc_slot(host).ocr_mask = ocr_value;
> > ? ? ? ? ? ? ? ?} else {
> > ? ? ? ? ? ? ? ? ? ? ? ?if (!(mmc_slot(host).ocr_mask & ocr_value)) {
> > - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? pr_err("MMC%d ocrmask %x is not
> > supported\n",
> > - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? host->id,
> > mmc_slot(host).ocr_mask);
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? pr_err("MMC ocrmask %x is not
> > supported\n",
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? mmc_slot(host).ocr_mask);

You're dropping the MMC number from these error messages.  It would be
much better to fix them instead.  Use dev_info(mmc_dev(host->mmc), "blah"
rather than pr_err().

Drivers should not be using pr_* unless they really do not have a struct
device.
