From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 20 Feb 2015 09:22:26 +0100
Subject: [PATCH] ARM: OMAP2+: Return correct error values from device and
 hwmod
In-Reply-To: <1424389302-24380-1-git-send-email-pali.rohar@gmail.com>
References: <1424389302-24380-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <20150220082226.GB14057@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2015-02-20 00:41:41, Pali Roh?r wrote:
> Without this patch function pm_runtime_get_sync() returns 0 even when some
> omap subfunction fails. This patch properly propagate error codes from omap
> functions back to caller.
> 
> This patch fix problem, when loading omap-aes driver in qemu cause kernel oops.

"fixes"

> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -3350,16 +3350,17 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
>   */
>  int omap_hwmod_idle(struct omap_hwmod *oh)
>  {
> +	int r;
>  	unsigned long flags;
>  
>  	if (!oh)
>  		return -EINVAL;
>  
>  	spin_lock_irqsave(&oh->_lock, flags);
> -	_idle(oh);
> +	r = _idle(oh);
>  	spin_unlock_irqrestore(&oh->_lock, flags);
>  
> -	return 0;
> +	return r;
>  }

Normally, such variable is called ret or res...

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
