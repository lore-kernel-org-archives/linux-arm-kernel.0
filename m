From: broonie@kernel.org (Mark Brown)
Date: Mon, 25 May 2015 18:45:28 +0100
Subject: [PATCH 01/21] regulator: core: Reduce critical area in
 _regulator_get
In-Reply-To: <1432565608-26036-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-2-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150525174528.GG21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 04:53:05PM +0200, Tomeu Vizoso wrote:

> ...by moving the locking to regulator_dev_lookup.

This breaks the locking.

> +	mutex_lock(&regulator_list_mutex);
>  	list_for_each_entry(r, &regulator_list, list)
> -		if (strcmp(rdev_get_name(r), supply) == 0)
> +		if (strcmp(rdev_get_name(r), supply) == 0) {
> +			mutex_unlock(&regulator_list_mutex);
>  			return r;
> +		}
> +	mutex_unlock(&regulator_list_mutex);

This means that we hold the lock while we walk the list but then return
a pointer to a regulator device that we don't have a reference to.  This
then means that something else can unregister the regulator we're
holding a pointer to which means that it is unsafe to use that pointer.
We need to ensure that any objects we look up via the list remain valid
while we're working with them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150525/0781f5e8/attachment.sig>
