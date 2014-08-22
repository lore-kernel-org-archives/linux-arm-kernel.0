From: Barry.Song@csr.com (Barry Song)
Date: Fri, 22 Aug 2014 06:55:36 +0000
Subject: [PATCH] mmc: core: sd: check card write-protect lock while
 resuming
In-Reply-To: <CAPDyKFpFLoREZ=rYp8bQvJ7Fczq=HyLL90jv7Hjzai9xTNBNYg@mail.gmail.com>
References: <1408356012-18867-1-git-send-email-Barry.Song@csr.com>
 <CAPDyKFpFLoREZ=rYp8bQvJ7Fczq=HyLL90jv7Hjzai9xTNBNYg@mail.gmail.com>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E9012C98252C@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson at linaro.org]
> Sent: Monday, August 18, 2014 7:58 PM
> To: Barry Song
> Cc: Chris Ball; linux-mmc; linux-arm-kernel at lists.infradead.org; DL-SHA-
> WorkGroupLinux; Minda Chen; Barry Song
> Subject: Re: [PATCH] mmc: core: sd: check card write-protect lock while
> resuming
> 
> On 18 August 2014 12:00, Barry Song <Barry.Song@csr.com> wrote:
> > From: Minda Chen <Minda.Chen@csr.com>
> >
> > After suspending, unplug the sdcard, and set sd WP lock, insert it
> > again, then resume the system. resume codes do not check the the
> > sdcard write-proctect lock. now check it.
> >
> > Signed-off-by: Minda Chen <Minda.Chen@csr.com>
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > ---
> >  drivers/mmc/core/sd.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> > 0c44510..890557a 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -910,6 +910,7 @@ static int mmc_sd_init_card(struct mmc_host
> *host, u32 ocr,
> >         int err;
> >         u32 cid[4];
> >         u32 rocr = 0;
> > +       bool oldro, ro;
> >
> >         BUG_ON(!host);
> >         WARN_ON(!host->claimed);
> > @@ -922,6 +923,12 @@ static int mmc_sd_init_card(struct mmc_host
> *host, u32 ocr,
> >                 if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
> >                         return -ENOENT;
> >
> > +               if (host->ops->get_ro) {
> > +                       ro = host->ops->get_ro(host) ? true : false;
> > +                       oldro = mmc_card_readonly(oldcard) ? true : false;
> > +                       if (oldro ^ ro)
> > +                               return -ENOENT;
> > +               }
> 
> Seems like this code belongs better in mmc_sd_setup_card(). Could you try
> moving it there.
[Barry Song] 
Well. How about:

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 0c44510..643bc82d8 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -815,6 +815,7 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	bool reinit)
 {
 	int err;
+	int oldro, ro = -1;
 
 	if (!reinit) {
 		/*
@@ -861,23 +862,28 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	/*
 	 * Check if read-only switch is active.
 	 */
-	if (!reinit) {
-		int ro = -1;
 
-		if (host->ops->get_ro) {
-			mmc_host_clk_hold(card->host);
-			ro = host->ops->get_ro(host);
-			mmc_host_clk_release(card->host);
-		}
+	if (host->ops->get_ro) {
+		mmc_host_clk_hold(card->host);
+		ro = host->ops->get_ro(host);
+		mmc_host_clk_release(card->host);
+	}
 
-		if (ro < 0) {
-			pr_warning("%s: host does not "
-				"support reading read-only "
-				"switch. assuming write-enable.\n",
-				mmc_hostname(host));
-		} else if (ro > 0) {
-			mmc_card_set_readonly(card);
-		}
+	if (ro < 0)
+		pr_warning("%s: host does not "
+			"support reading read-only "
+			"switch. assuming write-enable.\n",
+			mmc_hostname(host));
+
+	if (!reinit && (ro > 0))
+		mmc_card_set_readonly(card);
+	else if (reinit && (ro >= 0)) {
+		/* check if the write-protection lock is changed */
+		oldro = mmc_card_readonly(card) ? 1 : 0;
+		ro = (ro > 0) ? 1 : 0;
+
+		if (oldro ^ ro)
+			return -ENOENT;
 	}
 
 	return 0;
> 
> Kind regards
> Uffe
> 
> >                 card = oldcard;
> >         } else {
> >                 /*
-barry



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
