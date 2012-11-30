From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Nov 2012 14:34:35 +0000
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <CAHod+GeZQx6-pUHPocbyMJCLawMUhrZuZf=mrgWax=L7eNJGhg@mail.gmail.com>
References: <CAHod+GdVobkgOj6bsFhn6qqLhysQoEzcDtAS05u1kPnssSfObg@mail.gmail.com>
 <50B88A59.6070207@arm.com>
 <CAHod+GeZQx6-pUHPocbyMJCLawMUhrZuZf=mrgWax=L7eNJGhg@mail.gmail.com>
Message-ID: <20121130143435.GP19440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 01:20:06PM +0100, Marko Kati? wrote:
> There are three i2c devices on my board:
> 
> static struct i2c_board_info spitz_i2c_devs[] = {
> 	{
> 		.type		= "wm8750",
> 		.addr		= 0x1b,
> 	}, {
> 		.type		= "max7310",
> 		.addr		= 0x18,
> 		.platform_data	= &akita_pca953x_pdata,
> 	},
> };
> 
> These two are on bus 0.
> 
> static struct i2c_board_info spitz_pi2c_devs[] = {
> 	{
> 		.type		= "isl6271a",
> 		.addr		= 0x0c,
> 		.platform_data	= &isl6271a_info,
> 	},
> };
> 
> This one is on bus 1.
> 
> With commit 424e5994e63326a42012f003f1174f3c363c7b62 applied
> Only the max7310 is missing, the other two register and work fine.
> 
> Now, if i try to register _only_ the max7310 chip, it shows up but it doesn't
> work. In that case i get this:
> 
> gpiochip_add: gpios 204..211 (max7310) failed to register
> pca953x: probe of 0-0018 failed with error -16

-16 is -EBUSY.  This happens because this check fails:

        /* these GPIO numbers must not be managed by another gpio_chip */
        for (id = base; id < base + chip->ngpio; id++) {
                if (gpio_desc[id].chip != NULL) {
                        status = -EBUSY;
                        break;
                }
        }

and it basically means that the GPIO numbers have already been taken.

There is another device in spitz.c that could occupy the same space, and
that's the scoop 2 device - but that won't be registered if your platform
is Akita.

Hang on a moment - look at how the I2C devices are registered:

        int size = ARRAY_SIZE(spitz_i2c_devs);

        /* Only Akita has the max7310 chip */
        if (!machine_is_akita())
                size--;

        i2c_register_board_info(0, spitz_i2c_devs, size);

So, the first entry is _always_ registered, but the second entry is only
registered if the platform is an Akita.

This all sounds like the kernel isn't booting with the correct platform
ID.  Check the kernel messages - the first few, it tells you what platform
it's booting for.  And yes, you have CONFIG_PXA_SHARPSL_DETECT_MACH_ID
enabled which inserts code into the decompressor to detect the platform
type, and it's highly likely that some change has disrupted that code,
though it still reads fine in the disassembly.

My guess is there's a timing issue between the MMU turning off and the
other accesses; knowing which platform you end up being identified as may
help.
