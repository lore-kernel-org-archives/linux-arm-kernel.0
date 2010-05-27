From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 27 May 2010 14:37:03 +0400
Subject: [PATCH v2 7/8] net/fec: fix pm to survive to suspend/resume
In-Reply-To: <1274942000-3580-7-git-send-email-eric@eukrea.com>
References: <1274942000-3580-1-git-send-email-eric@eukrea.com>	<1274942000-3580-2-git-send-email-eric@eukrea.com>	<1274942000-3580-3-git-send-email-eric@eukrea.com>	<1274942000-3580-4-git-send-email-eric@eukrea.com>	<1274942000-3580-5-git-send-email-eric@eukrea.com>	<1274942000-3580-6-git-send-email-eric@eukrea.com>
	<1274942000-3580-7-git-send-email-eric@eukrea.com>
Message-ID: <4BFE4B4F.4090405@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Eric B?nard wrote:

> * with this patch, if the connection if active before suspend, it
> will be active after resume.
> * before this patch, it was necessary to close the interface and
> reopen it to recover the connection.

> Signed-off-by: Eric B?nard <eric@eukrea.com>

> diff --git a/drivers/net/fec.c b/drivers/net/fec.c
> index 9b4e8f7..654abaf 100644
> --- a/drivers/net/fec.c
> +++ b/drivers/net/fec.c
> @@ -1971,13 +1971,14 @@ static int
>  fec_suspend(struct platform_device *dev, pm_message_t state)
>  {
>  	struct net_device *ndev = platform_get_drvdata(dev);
> -	struct fec_enet_private *fep;
> +	struct fec_enet_private *fep = netdev_priv(ndev);

    Can netdev_priv() be called if 'ndev' is NULL (and can it be really 
NULL?)?

>  
>  	if (ndev) {
>  		fep = netdev_priv(ndev);

    Duplicated now.

WBR, Sergei
