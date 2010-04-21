From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 21 Apr 2010 11:28:26 +0300
Subject: [PATCH resend] PL061 GPIO: Setting gpio val after changing
	direction to OUT.
In-Reply-To: <1271838297-20528-2-git-send-email-viresh.kumar@st.com>
References: <1271838297-20528-1-git-send-email-viresh.kumar@st.com>
	<1271838297-20528-2-git-send-email-viresh.kumar@st.com>
Message-ID: <20100421082824.GD6345@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Wed, Apr 21, 2010 at 01:54:57PM +0530, Viresh KUMAR wrote:
> pl061_direction_output doesn't set value of gpio to value passed to it.
> This patch sets value of GPIO pin to requested value after changing direction
> to OUT.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

baruch

> ---
>  drivers/gpio/pl061.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
> index 4b6c22d..4f172ab 100644
> --- a/drivers/gpio/pl061.c
> +++ b/drivers/gpio/pl061.c
> @@ -90,6 +90,12 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
>  	gpiodir = readb(chip->base + GPIODIR);
>  	gpiodir |= 1 << offset;
>  	writeb(gpiodir, chip->base + GPIODIR);
> +
> +	/*
> +	 * gpio value is set again, because pl061 doesn't allow to set value of
> +	 * a gpio pin before configuring it in OUT mode.
> +	 */
> +	writeb(!!value << offset, chip->base + (1 << (offset + 2)));
>  	spin_unlock_irqrestore(&chip->lock, flags);
>  
>  	return 0;

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
