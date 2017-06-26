From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 26 Jun 2017 15:54:30 +0000
Subject: [PATCH] soc/qman: Sleep instead of stuck hacking jiffies.
In-Reply-To: <1498403622-2878-1-git-send-email-karim.eshapa@gmail.com>
References: <1498403622-2878-1-git-send-email-karim.eshapa@gmail.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD002B1A5@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Karim Eshapa
> Sent: 25 June 2017 16:14
> Use msleep() instead of stucking with
> long delay will be more efficient.
...
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -1084,11 +1084,7 @@ static int drain_mr_fqrni(struct qm_portal *p)
>  		 * entries well before the ring has been fully consumed, so
>  		 * we're being *really* paranoid here.
>  		 */
> -		u64 now, then = jiffies;
> -
> -		do {
> -			now = jiffies;
> -		} while ((then + 10000) > now);
> +		msleep(1);
...
How is that in any way equivalent?
If HZ is 1000 the old code loops for 10 seconds.
If HZ is 250 (common for some distros) it loops for 40 seconds.

Clearly both are horrid, but it isn't at all clear that a 1ms sleep
is performing the same job.

My guess is that this code is never called, and broken if actually called.

	David
