From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Nov 2010 10:25:05 +0100
Subject: [PATCH 00/51] some more imx patches for 2.6.38
In-Reply-To: <4CE4E71A.2080909@eukrea.com>
References: <20101117212821.GF8942@pengutronix.de>
	<4CE4E71A.2080909@eukrea.com>
Message-ID: <20101118092505.GK8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 18, 2010 at 09:43:06AM +0100, Eric B?nard wrote:
> On 17/11/2010 22:28, Uwe Kleine-K?nig wrote:
>> The highlights are that for most devices for i.MX1, i.MX21, i.MX25 and
>> i.MX27 are allocated dynamically which reduces the memory footprint of
>> the kernel.  Moreover I moved support for i.MX25 to mach-imx targeting a
>> multi-SoC-kernel for i.MX.
>>
> do you have numbers concerning the memory footprint savings ?
I didn't recently and didn't save the results.  Taking commit "ARM: mx3:
dynamically allocate imx-keypad devices" (which is very low impact
because it only removes a single static device with just one user
(arch/arm/mach-mx3/mach-mx31_3ds.c) bloat-o-meter reports:

	add/remove: 3/2 grow/shrink: 0/0 up/down: 164/-264 (-100)
	function                                     old     new   delta
	imx_add_imx_keypad                             -     140    +140
	imx35_imx_keypad_data                          -      12     +12
	imx31_imx_keypad_data                          -      12     +12
	imx_kpp_resources                             56       -     -56
	imx_kpp_device                               208       -    -208

And there are some more things bloat-o-meter doesn't catch:

 - imx_add_imx_keypad, imx35_imx_keypad_data and imx31_imx_keypad_data
   all live in .init.text and .init.rodata, so after boot another 164
   bytes are freed.
 - platform data (here mx31_3ds_keymap_data) can be moved to .init.data
   (or .init.rodata)  This saves in general at least
   (#machines_using_the_device - 1) * sizeof(platform data) when the
   init data is discarded.
 - Of course when booting an mx31_3ds machine imx_kpp_device and
   imx_kpp_resources reappear in memory, so the main benefit is for
   devices that are not used on many machines.  So for mx31_3ds this
   patch yields +/-0.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
