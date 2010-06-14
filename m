From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 14 Jun 2010 10:43:51 +0200
Subject: [PATCH] mxc_nand: fix PM
In-Reply-To: <1274982919-13251-1-git-send-email-eric@eukrea.com>
References: <1274942000-3580-2-git-send-email-eric@eukrea.com>
	<1274982919-13251-1-git-send-email-eric@eukrea.com>
Message-ID: <20100614084351.GC12159@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

On Thu, May 27, 2010 at 07:55:19PM +0200, Eric B?nard wrote:
> * when resuming, we get the following log :
> nand_resume called for a chip which is not in suspended state
> * this happens because mtd->suspend and mtd->resume are already
> called from the mtd layer, thus they were called a second time
> in mxc_nand so mtd complains when trying to resume for the
> second time
> * the fix is to remove these call and thus remove the supend and
> resume functions of mxc_nand
the commit log looks IMHO ugly.  Better make it (including Subject):

mtd/mxc_nand: don't call mtd->{suspend,resume} explicitly

The mtd layer is responsible to call mtd->{suspend,resume}.  Doing it
again in the driver is wrong and results in a warning:

	nand_resume called for a chip which is not in suspended state

at resume time.  Removing the calls from the resume and suspend
functions makes them empty allowing them to be deleted completely.

Signed-off-by: Eric B?nard <eric@eukrea.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mtd at lists.infradead.org

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
