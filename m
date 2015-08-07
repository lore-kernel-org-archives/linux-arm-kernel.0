From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Aug 2015 13:07:52 +0100
Subject: [PATCH v3 05/18] regulator: core: Reduce critical area in
 _regulator_get
In-Reply-To: <1438870315-18689-6-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-6-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150807120752.GQ20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 04:11:42PM +0200, Tomeu Vizoso wrote:

> This backtrace illustrates the situation described above:
> 
> (regulator_register) from [<c05efe64>]
> (devm_regulator_register+0x48/0x84)

Please don't paste entire backtraces into commit messages, they are
enormous and contain very little useful content - they just obscure
actual information in the commit message.  If you feel there's useful
information in there just include edited highlights with only that.

> +static int _regulator_enable(struct regulator *regulator, bool do_lock)
>  {
> -	int ret;
> +	struct regulator_dev *rdev = regulator->rdev;
> +	int ret = 0;
>  
> -	lockdep_assert_held_once(&rdev->mutex);
> +	if (regulator->always_on)
> +		return 0;
> +
> +	if (rdev->supply) {
> +		ret = regulator_enable(rdev->supply);
> +		if (ret != 0)
> +			return ret;
> +	}
> +
> +	if (do_lock)
> +		mutex_lock(&rdev->mutex);
> +	else
> +		lockdep_assert_held_once(&rdev->mutex);

Eew.  This do_lock stuff is *not* nice and going to be fragile.  I'm not
a fan, we need something better.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150807/91a3715c/attachment.sig>
