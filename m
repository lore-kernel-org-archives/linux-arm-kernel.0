From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Nov 2017 16:29:42 +0000
Subject: [PATCH 01/10 v4] Input: ep93xx_keypad: Fix platform_get_irq's
 error checking
In-Reply-To: <987ac156e9590cbe2f667f9782b56515d7a991a4.1511194239.git.arvind.yadav.cs@gmail.com>
References: <987ac156e9590cbe2f667f9782b56515d7a991a4.1511194239.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171120162941.GD31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 09:56:21PM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2 :
>               Return keypad->irq insted of -ENXIO.
> changes in v3 :
>               Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
> changes ib v4 :
>               Return -ENXIO insted of keypad->irq. Which was not correct in v3.
> 
>  drivers/input/keyboard/ep93xx_keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
> index f77b295..c6eb31a 100644
> --- a/drivers/input/keyboard/ep93xx_keypad.c
> +++ b/drivers/input/keyboard/ep93xx_keypad.c
> @@ -257,7 +257,7 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
>  	}
>  
>  	keypad->irq = platform_get_irq(pdev, 0);
> -	if (!keypad->irq) {
> +	if (keypad->irq <= 0) {
>  		err = -ENXIO;

Still not right.

		err = keypad->irq < 0 ? keypad->irq : -ENXIO;

would have the right effect.

However, I disagree with the idea of making platform_get_irq() return
an error if there is a zero irq specified as suggested in a previous
review - zero means "not present" and that is not necessarily an error -
it's up to the driver to decide whether it can proceed without an
interrupt, or whether it should error out on the probe function.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
