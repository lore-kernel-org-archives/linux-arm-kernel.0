From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 28 May 2010 15:33:23 +0200
Subject: [PATCH 1/2] pxa/spitz: Correctly register WM8750
In-Reply-To: <1275014733-21588-1-git-send-email-marek.vasut@gmail.com>
References: <1275014733-21588-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100528133323.GA2323@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2010-05-28 04:45:32, Marek Vasut wrote:
> This patch registers the WM8750 codec on a proper place on the SPITZ machine
> after the WM8750 driver was converted to new API.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/spitz.c |    3 +++
>  sound/soc/pxa/spitz.c     |   36 ------------------------------------
>  2 files changed, 3 insertions(+), 36 deletions(-)

I got rejects on second file when trying to apply it on 2.6.34...?
									Pavel

> 
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index 4d2413e..c1048a3 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -818,6 +818,9 @@ static struct i2c_board_info akita_i2c_board_info[] = {
>  		.type		= "max7310",
>  		.addr		= 0x18,
>  		.platform_data	= &akita_ioexp,
> +	}, {
> +		.type		= "wm8750",
> +		.addr		= 0x1b,
>  	},
>  };
>  
> diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
> index 1941a35..d256f5f 100644
> --- a/sound/soc/pxa/spitz.c
> +++ b/sound/soc/pxa/spitz.c
> @@ -328,38 +328,6 @@ static struct snd_soc_device spitz_snd_devdata = {
>  	.codec_dev = &soc_codec_dev_wm8750,
>  };
>  
> -/*
> - * FIXME: This is a temporary bodge to avoid cross-tree merge issues.
> - * New drivers should register the wm8750 I2C device in the machine
> - * setup code (under arch/arm for ARM systems).
> - */
> -static int wm8750_i2c_register(void)
> -{
> -	struct i2c_board_info info;
> -	struct i2c_adapter *adapter;
> -	struct i2c_client *client;
> -
> -	memset(&info, 0, sizeof(struct i2c_board_info));
> -	info.addr = 0x1b;
> -	strlcpy(info.type, "wm8750", I2C_NAME_SIZE);
> -
> -	adapter = i2c_get_adapter(0);
> -	if (!adapter) {
> -		printk(KERN_ERR "can't get i2c adapter 0\n");
> -		return -ENODEV;
> -	}
> -
> -	client = i2c_new_device(adapter, &info);
> -	i2c_put_adapter(adapter);
> -	if (!client) {
> -		printk(KERN_ERR "can't add i2c device at 0x%x\n",
> -		(unsigned int)info.addr);
> -		return -ENODEV;
> -	}
> -
> -	return 0;
> -}
> -
>  static struct platform_device *spitz_snd_device;
>  
>  static int __init spitz_init(void)
> @@ -369,10 +337,6 @@ static int __init spitz_init(void)
>  	if (!(machine_is_spitz() || machine_is_borzoi() || machine_is_akita()))
>  		return -ENODEV;
>  
> -	ret = wm8750_i2c_setup();
> -	if (ret != 0)
> -		return ret;
> -
>  	spitz_snd_device = platform_device_alloc("soc-audio", -1);
>  	if (!spitz_snd_device)
>  		return -ENOMEM;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
