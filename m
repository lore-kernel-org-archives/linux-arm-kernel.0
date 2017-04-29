From: oss@buserror.net (Scott Wood)
Date: Sat, 29 Apr 2017 18:32:55 -0500
Subject: [PATCH] drivers:soc:fsl:qbman:qman.c: unsigned long jiffies value.
In-Reply-To: <1493498620-9975-1-git-send-email-karim.eshapa@gmail.com>
References: <1493495164-8658-1-git-send-email-karim.eshapa@gmail.com>
 <1493498620-9975-1-git-send-email-karim.eshapa@gmail.com>
Message-ID: <1493508775.25397.26.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-04-29 at 22:43 +0200, Karim Eshapa wrote:
> unsigned long jiffies value sorry for that.

You mean unsigned long msecs?

> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
> ---
> ?drivers/soc/fsl/qbman/qman.c | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index e0df4d1..6e1a44a 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -1084,7 +1084,7 @@ static int drain_mr_fqrni(struct qm_portal *p)
> ?		?* entries well before the ring has been fully consumed, so
> ?		?* we're being *really* paranoid here.
> ?		?*/
> -		unsigned int udel_time = jiffies_to_usecs(10000);
> +		unsigned long udel_time = jiffies_to_usecs(10000);
> ?
> ?		usleep_range(udel_time/2, udel_time);
> ?		msg = qm_mr_current(p);

If unsigned int isn't big enough, then unsigned long won't be either on 32-
bit.  With such a long delay why not use msleep()?

As for the previous patch[1], you're halving the minimum timeout which may not
be correct.

For the NXP people: Is there *really* no better way to handle this than
waiting for so long?  Nothing that can be checked to exit the loop early (at
least, you could exit early if there is more work to do so only the final
iteration takes the full timeout)?  And why is the desired timeout specified
in jiffies, the duration of which can change based on kernel config and
doesn't reflect anything about the hardware?

-Scott

[1] When fixing a patch you've already posted that hasn't yet been applied,
send a replacement (v2) patch rather than a separate fix.
