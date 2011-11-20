From: joe@perches.com (Joe Perches)
Date: Sun, 20 Nov 2011 12:47:48 -0800
Subject: [PATCH] ARM: sa1100: refactor sa1100 serial driver
In-Reply-To: <1321821127-32231-1-git-send-email-jochen@scram.de>
References: <1321821127-32231-1-git-send-email-jochen@scram.de>
Message-ID: <1321822068.17619.3.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-11-20 at 21:32 +0100, Jochen Friedrich wrote:
> - move pin initialization into board files
> - make use of resources in platform device
>   rather than hardcoding them in the driver
> - add DT support

trivia:

> diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
[]
> @@ -166,7 +166,7 @@ static struct platform_device sa11x0udc_device = {
>  static struct resource sa11x0uart1_resources[] = {
>  	[0] = {
>  		.start	= __PREG(Ser1UTCR0),
> -		.end	= __PREG(Ser1UTCR0) + 0xffff,
> +		.end	= __PREG(Ser1UTCR0) + 0x24,

#define for 0x24? or is it really 0x23?
(start + size - 1)

> @@ -178,15 +178,35 @@ static struct resource sa11x0uart1_resources[] = {
[]
> +static struct resource sa11x0uart2_resources[] = {
> +	[0] = {
> +		.start	= __PREG(Ser2UTCR0),
> +		.end	= __PREG(Ser2UTCR0) + 0x24,

here too

> +static struct platform_device sa11x0uart2_device = {
> +	.name		= "sa11x0-uart",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(sa11x0uart2_resources),
> +	.resource	= sa11x0uart2_resources,
> +};
> +
>  static struct resource sa11x0uart3_resources[] = {
>  	[0] = {
>  		.start	= __PREG(Ser3UTCR0),
> -		.end	= __PREG(Ser3UTCR0) + 0xffff,
> +		.end	= __PREG(Ser3UTCR0) + 0x24,

etc
