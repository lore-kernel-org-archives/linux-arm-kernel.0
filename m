From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Nov 2016 22:22:56 +0100
Subject: [PATCH] mv88e6xxx: Fix mv88e6xxx_g1_irq_free() interrupt count
In-Reply-To: <1480279424-7830-1-git-send-email-afaerber@suse.de>
References: <1480279424-7830-1-git-send-email-afaerber@suse.de>
Message-ID: <20161127212256.GC13318@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2016 at 09:43:44PM +0100, Andreas F?rber wrote:
> mv88e6xxx_g1_irq_setup() sets up chip->g1_irq.nirqs interrupt mappings,
> so free the same amount. This will be 8 or 9 in practice, less than 16.

Hi Andreas

The patch is correct, but please read
Documentation/networking/netdev-FAQ.txt
and then resubmit the patch.

    Andrew

> 
> Fixes: dc30c35be720 ("net: dsa: mv88e6xxx: Implement interrupt support.")
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 98302358ceb9..95b9efb33ec7 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -421,7 +421,7 @@ static void mv88e6xxx_g1_irq_free(struct mv88e6xxx_chip *chip)
>  
>  	free_irq(chip->irq, chip);
>  
> -	for (irq = 0; irq < 16; irq++) {
> +	for (irq = 0; irq < chip->g1_irq.nirqs; irq++) {
>  		virq = irq_find_mapping(chip->g1_irq.domain, irq);
>  		irq_dispose_mapping(virq);
>  	}
> -- 
> 2.6.6
> 
