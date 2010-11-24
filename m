From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 24 Nov 2010 14:18:57 +0100
Subject: [PATCH 1/9] spi/pxa2xx: don't use subys initcall for driver init
In-Reply-To: <1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
Message-ID: <20101124141857.694e52ef.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Nov 2010 12:13:19 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> It is a simple driver and there is no need to call its init function
> at the level of a subsystem.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---

Please take a look at commit 5b61a749e8fd0a45a5e37c267d20a43ef0590d68
there are some situations where the spi driver needs to be loaded before
the others, IIRC the change in the commit above was needed for the EZX
phones, where the PMIC is on the spi bus and cpufreq operates on some
regulator controlled by the PMIC; added Daniel Ribeiro on CC who maybe
can give more details.

Regards,
   Antonio

>  drivers/spi/pxa2xx_spi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index e76b1af..6f2f061 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -1731,7 +1731,7 @@ static int __init pxa2xx_spi_init(void)
>  {
>  	return platform_driver_probe(&driver, pxa2xx_spi_probe);
>  }
> -subsys_initcall(pxa2xx_spi_init);
> +module_init(pxa2xx_spi_init);
>  
>  static void __exit pxa2xx_spi_exit(void)
>  {
> -- 
> 1.7.3.2
> 
> 

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101124/bdfe31b4/attachment.sig>
