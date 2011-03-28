From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 Mar 2011 19:11:51 +0100
Subject: [PATCH 1/2] regulator: Remove possible deadlock from
	regulator_enable
In-Reply-To: <1301326482-6547-2-git-send-email-collinsd@codeaurora.org>
References: <1301326482-6547-1-git-send-email-collinsd@codeaurora.org>
	<1301326482-6547-2-git-send-email-collinsd@codeaurora.org>
Message-ID: <20110328181151.GB28494@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2011 at 08:34:41AM -0700, David Collins wrote:

Review curtailed by me having to dash off but one comment...

> -/* locks held by regulator_enable() */
> +/* Locks are *not* held by regulator_enable(). */
>  static int _regulator_enable(struct regulator_dev *rdev)
>  {
> -	int ret, delay;
> +	struct regulator_dev *supply_rdev = NULL;
> +	int ret = 0, delay;
>  
> +	mutex_lock(&rdev->mutex);

This is going to be terribly confusing - the _ versions of the functions
all by convention rely on their callers taking the mutex, allowing them
to be safely used from internal APIs.  
