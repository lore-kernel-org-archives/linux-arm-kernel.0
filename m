From: joe@perches.com (Joe Perches)
Date: Fri, 11 Dec 2009 10:40:42 -0800
Subject: [PATCH] i2c-iop3xx.c: fix memory resource
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901FB1063@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901FB1063@mi8nycmail19.Mi8.com>
Message-ID: <1260556842.18299.34.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-12-11 at 13:32 -0500, H Hartley Sweeten wrote:
> The i2c-iop3xx driver requires a resource region of 0x18 bytes and
> currently uses the magic number IOP3XX_I2C_IO_SIZE (defined in
> i2c-iop3xx.h) to indicate this.  All of the users of this driver
> have a platform memory resource so use resource_size() instead of
> the magic number.  This requires fixing a couple of the memory
> resources since they were either off by 1 or just wrong.
[]
>  static struct resource iop13xx_i2c_0_resources[] = {
>  	[0] = {
>  		.start = IOP13XX_I2C0_PHYS,
> -		.end = IOP13XX_I2C0_PHYS + 0x18,
> +		.end = IOP13XX_I2C0_PHYS + 0x17,

etc.

> -#define	IOP3XX_I2C_IO_SIZE	0x18

Maybe it's clearer to keep the IO_SIZE define
and let the compiler do the adding.

.start = FOO;
.end = FOO + IOP3XX_I2C_IO_SIZE - 1;
