From: joe@perches.com (Joe Perches)
Date: Tue, 31 May 2016 10:58:57 -0700
Subject: [PATCH 4/5] coresight: Add better messages for coresight_timeout
In-Reply-To: <1464695858-29284-5-git-send-email-suzuki.poulose@arm.com>
References: <1464695858-29284-1-git-send-email-suzuki.poulose@arm.com>
 <1464695858-29284-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1464717537.14627.39.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-05-31 at 12:57 +0100, Suzuki K Poulose wrote:
> When we encounter a timeout waiting for a status change via
> coresight_timeout, the caller always print the offset which
> was tried. This is pretty much useless as it doesn't specify
> the bit position we wait for. Also, one needs to lookup the
> TRM to figure out, what was wrong. This patch changes all
> such error messages to print something more meaningful.

trivia:

Perhaps consistently using
	dev_err(dev, "timeout while waiting for %s\n", "<foo>");
could make the object code a bit smaller.

> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
[]
> @@ -184,8 +184,7 @@ static void etb_disable_hw(struct etb_drvdata *drvdata)
> ?
> ?	if (coresight_timeout(drvdata->base, ETB_FFCR, ETB_FFCR_BIT, 0)) {
> ?		dev_err(drvdata->dev,
> -			"timeout observed when probing at offset %#x\n",
> -			ETB_FFCR);
> +			"timeout while waiting for completion of Manual Flush\n");

ie:
		dev_err(drvdata->dev,
			"timeout while waiting for %s\n",
			"completion of Manual Flush");

but that depends on how many of these coresight
files are compiled and linked.

There is a while/when usage difference in some of
the output messages.
