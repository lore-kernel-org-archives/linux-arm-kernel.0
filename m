From: cjb@laptop.org (Chris Ball)
Date: Wed, 19 Sep 2012 06:47:02 -0400
Subject: [PATCH v2 1/5] mmc: host: sdhci-s3c: Add broken-voltage DT
 property for broken voltage quirk
In-Reply-To: <1907099.4JSZthrgh2@amdc1227> (Tomasz Figa's message of "Wed, 19
 Sep 2012 12:34:31 +0200")
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
 <1587150.uFGRdL0s8e@amdc1227> <m3a9wmgvip.fsf@pullcord.laptop.org>
 <1907099.4JSZthrgh2@amdc1227>
Message-ID: <m3627aguhl.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 19 2012, Tomasz Figa wrote:
> We could just check if the regulator provides the capability to change the 
> voltage.
>
> I don't see any direct way of querying the regulator for provided 
> capabilities (correct me if I'm just blind), but calling 
> regulator_count_voltages() on the regulator and checking if the returned 
> value is 1 should be enough to assume that the regulator is fixed.

Sounds good, I agree.  Are you able to test that the obvious patch below
works on your fixed-regulator board?

Jaehoon and Adrian, can you think of any reason why we shouldn't replace
MMC_CAP2_BROKEN_VOLTAGE with the regulator_count_voltages() call below?
Thanks.


diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 044cd01..a3cc740 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1132,7 +1132,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 		 */
 		voltage = regulator_get_voltage(supply);
 
-		if (mmc->caps2 & MMC_CAP2_BROKEN_VOLTAGE)
+		if (regulator_count_voltages(supply) == 1)
 			min_uV = max_uV = voltage;
 
 		if (voltage < 0)

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
