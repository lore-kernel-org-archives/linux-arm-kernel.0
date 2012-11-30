From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Fri, 30 Nov 2012 13:20:06 +0100
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <50B88A59.6070207@arm.com>
References: <CAHod+GdVobkgOj6bsFhn6qqLhysQoEzcDtAS05u1kPnssSfObg@mail.gmail.com>
 <50B88A59.6070207@arm.com>
Message-ID: <CAHod+GeZQx6-pUHPocbyMJCLawMUhrZuZf=mrgWax=L7eNJGhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This is incredibly puzzling. I could understand your board not booting
> at all because of this patch, but an i2c device missing?
>
> Can you see the i2c controller at all? I'll try to dig my PXA270 board
> and see if I can reproduce your issue.
>
>         M.
> --
> Jazz is not dead. It just smells funny...
>

There are three i2c devices on my board:

static struct i2c_board_info spitz_i2c_devs[] = {
	{
		.type		= "wm8750",
		.addr		= 0x1b,
	}, {
		.type		= "max7310",
		.addr		= 0x18,
		.platform_data	= &akita_pca953x_pdata,
	},
};

These two are on bus 0.

static struct i2c_board_info spitz_pi2c_devs[] = {
	{
		.type		= "isl6271a",
		.addr		= 0x0c,
		.platform_data	= &isl6271a_info,
	},
};

This one is on bus 1.

With commit 424e5994e63326a42012f003f1174f3c363c7b62 applied
Only the max7310 is missing, the other two register and work fine.

Now, if i try to register _only_ the max7310 chip, it shows up but it doesn't
work. In that case i get this:

gpiochip_add: gpios 204..211 (max7310) failed to register
pca953x: probe of 0-0018 failed with error -16

And then when i revert 424e5994e63326a42012f003f1174f3c363c7b62
and register _only_ the max7310, it works fine.
