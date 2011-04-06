From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Wed, 6 Apr 2011 13:41:01 +0200
Subject: [PATCH 5/5] driver core: let dev_set_drvdata return int instead
	of void as it can fail
In-Reply-To: <1302081865-2962-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110301153438.GB15633@suse.de>
	<1302081865-2962-5-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <BANLkTik29+u0A-uuQG3KtjQxNO_KpBMShg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/6 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> I wasn't sure what to return when dev_set_drvdata is called with
> dev=NULL. ?I choosed 0, but -EINVAL would be OK for me, too. What do you
> think?

This code was introduced by:

commit b4028437876866aba4747a655ede00f892089e14
Author: Greg Kroah-Hartman <gregkh@suse.de>
Date:   Mon May 11 14:16:57 2009 -0700

    Driver core: move dev_get/set_drvdata to drivers/base/dd.c

Before this patch, driver writers could assume that dev_set_drvdata()
never fails. And, dev==NULL would cause an imediate NULL dereference
(equivalent to BUG_ON(!dev), BTW). And, if dev_set_drvdata() fails
(silently as it is now) it's going to BUG later anyway.

I think it's best to revert that commit instead of fixing this up.

Best Regards,
Micha? Miros?aw
