From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 14:05:06 +0000
Subject: [PATCH] arm: ecard: Fix compilation warning.
In-Reply-To: <1291644243-23540-1-git-send-email-marek.belisko@open-nandra.com>
References: <1291644243-23540-1-git-send-email-marek.belisko@open-nandra.com>
Message-ID: <20101206140506.GE31777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 03:04:03PM +0100, Marek Belisko wrote:
> Fix following compilation warning:
> arch/arm/kernel/ecard.c:1066: warning: ignoring return value of
> 'device_register', declared with attribute warn_unused_result
> 
> Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
> ---
>  arch/arm/kernel/ecard.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/ecard.c b/arch/arm/kernel/ecard.c
> index eed2f79..da882b1 100644
> --- a/arch/arm/kernel/ecard.c
> +++ b/arch/arm/kernel/ecard.c
> @@ -1063,8 +1063,10 @@ ecard_probe(int slot, card_type_t type)
>  	*ecp = ec;
>  	slot_to_expcard[slot] = ec;
>  
> -	device_register(&ec->dev);
> -
> +	rc = device_register(&ec->dev);
> +	if (rc)
> +		goto nodev;
> +
>  	return 0;

No.  It is important that cards which are actually there remain present
even if device_register fails.  In other words, we _really_ don't care
what device_register() returns.
