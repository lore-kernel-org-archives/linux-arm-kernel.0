From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Jun 2013 11:47:10 +0200
Subject: On mini2440 IO mappings.
In-Reply-To: <CAM2a4uw_mq=NZHrg32KRf7js8+3iC59SB1NPdP8EwCov7z0DnQ@mail.gmail.com>
References: <CAM2a4uxNKhD_+zr7mZOV0eR7u_VTCSZyEcsj_uNA5MuuKPFbDQ@mail.gmail.com>
 <3308480.LZZ0YkAPVH@wuerfel>
 <CAM2a4uw_mq=NZHrg32KRf7js8+3iC59SB1NPdP8EwCov7z0DnQ@mail.gmail.com>
Message-ID: <5390072.c6vttxqWyK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 June 2013 14:59:17 mind entropy wrote:
> On Tue, Jun 4, 2013 at 2:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 04 June 2013 13:11:04 mind entropy wrote:
> 
> >> arch/arm/mach-s3c24xx/include/mach/map.h S3C24XX_SZ_IRQ is set to
> >> SZ_1M but in the documentation (Pg 1-27 of s3c2440.pdf datasheet) the
> >> physical address extends from 0X4A000000 to 0X4A00001C. So shouldn't a
> >> size of 4K(small page) or 1K(tiny page) be enough?
> >
> > Yes, that would be enough, but I think it makes little difference
> > either way.
> >
> 
> Just to clarify, this would create an overlap i.e. 2 different virtual
> address will point to the same physical address right?

I don't think it does. The mappings are

static struct map_desc s3c_iodesc[] __initdata = {
        IODESC_ENT(GPIO),
        IODESC_ENT(IRQ),
        IODESC_ENT(MEMCTRL),
        IODESC_ENT(UART)
};

using these virtual addresses:

#define S3C_ADDR_BASE   0xF6000000
#define S3C_ADDR(x)     ((void __iomem __force *)S3C_ADDR_BASE + (x))
#define S3C_VA_IRQ      S3C_ADDR(0x00000000)    /* irq controller(s) */
#define S3C_VA_SYS      S3C_ADDR(0x00100000)    /* system control */
#define S3C_VA_MEM      S3C_ADDR(0x00200000)    /* memory control */
#define S3C_VA_UART     S3C_ADDR(0x01000000)    /* UART */
#define S3C24XX_VA_GPIO   ((S3C24XX_PA_GPIO - S3C24XX_PA_UART) + S3C24XX_VA_UART)

and these physical addresses

#define S3C2410_PA_UART         (0x50000000)
#define S3C2410_PA_GPIO         (0x56000000)
#define S3C2410_PA_IRQ          (0x4A000000)
#define S3C2410_PA_MEMCTRL      (0x48000000)

Everything is aligned to full megabytes.

> I am just trying my hand on the minimal bootup of the board. I am
> looking at the existing port and trying to write my own. I am using
> the 3.9 vanilla kernel with pengutronix patches.

Ok, I see.

	Arnd
