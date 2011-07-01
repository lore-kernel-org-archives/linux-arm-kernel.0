From: hans-christian.egtvedt@atmel.com (Hans-Christian Egtvedt)
Date: Fri, 01 Jul 2011 16:32:34 +0200
Subject: [PATCH V2] MMC: PM: add suspend/resume in atmel-mci
In-Reply-To: <4E0DD816.7070104@atmel.com>
References: <201106292339.12402.rjw@sisk.pl>
	<1309441781-11012-1-git-send-email-nicolas.ferre@atmel.com>
	<20110630131342.GK11559@pengutronix.de>  <4E0DD816.7070104@atmel.com>
Message-ID: <1309530754.4373.3.camel@hcegtvedt.norway.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-07-01 at 16:22 +0200, Nicolas Ferre wrote:
> Le 30/06/2011 15:13, Uwe Kleine-K?nig :

<snipp>

> Well, actually for the current implementation the only return code is... 0.
> And here I try to have a king of best effort approach ;-)
> 
> >> +			}
> >> +			return ret;
> >> +		}
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int atmci_resume(struct device *dev)
> >> +{
> >> +	struct atmel_mci *host = dev_get_drvdata(dev);
> >> +	struct atmel_mci_slot *slot;
> >> +	int i, ret;
> >> +
> >> +	for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
> >> +		slot = host->slot[i];
> >> +		if (!slot)
> >> +			continue;
> >> +		ret = mmc_resume_host(slot->mmc);
> >> +		if (ret < 0)
> >> +			return ret;
> > Maybe you should try to resume host 5 even if resuming host 4 failed?
> 
> In fact all other drivers that are dealing with multiple slots are doing
> the same... So I have difficulties to know the truth.
> The question is: is it better to return an error to the "resume"
> function so that we are called later again or do we have to do our best
> to thaw everything out?

Detect failures and return the error value, but also try to resume the
other slots.

You must however then keep track of which are restored for later calls
to resume AFAICT.

<snipp>

-- 
Hans-Christian Egtvedt
