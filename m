From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 3 Dec 2009 13:06:27 +0000
Subject: [PATCH] mmc: move regulator handling to core
In-Reply-To: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
Message-ID: <20091203130627.GA31254@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2009 at 01:46:30PM +0100, Daniel Mack wrote:
> At the moment, regulator operations are done from individual mmc host
> drivers. This is a problem because the regulators are not claimed
> exclusively but the mmc core enables and disables them according to the

This is historical, they can all be converted to regulator_get_exclusive()
so the move to the core (while good) isn't required for this reason.

>  	case MMC_POWER_OFF:
> -		if(host->vcc &&
> -		   regulator_is_enabled(host->vcc))
> -			regulator_disable(host->vcc);
> +		if(mmc->vcc && mmc->vcc_enabled) {
> +			regulator_disable(mmc->vcc);
> +			mmc->vcc_enabled = 0;
> +		}

Can the MMC core actually tolerate the MMC power not getting killed when
expected?  My understanding from previous discussion was that it wasn't
able to do so.  If it is then conversion to using regulator_get_exclusive()
isn't desirable, of course.
