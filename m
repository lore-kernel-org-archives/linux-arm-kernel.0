From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 31 Mar 2011 12:00:44 +0200
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
In-Reply-To: <AANLkTikf63wTfM1z2cpV+GuK28y1wrT7UWvw4TanBj4R@mail.gmail.com>
References: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
	<20110330073651.GR7285@pengutronix.de>
	<AANLkTikf63wTfM1z2cpV+GuK28y1wrT7UWvw4TanBj4R@mail.gmail.com>
Message-ID: <20110331100044.GX30938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Matt,

On Wed, Mar 30, 2011 at 05:23:12PM -0500, Matt Sealey wrote:
> I have a serious problem with the way the "new"
> "imx_add_this_and_that" platform devices are done. Why is there so
> much done in little helper functions and defines?
The reason for that is to get rid of these static struct
platform_devices (and some more things) to save memory.

For example look at commit

	a5fcfef (ARM: mx5: dynamically allocate imx-keypad devices)

. It get's rid of mxc_kpp_resources[] (= 2 * 28 Byte, .data) and
mxc_keypad_device (= 320 Byte, .data).
It only adds imx51_imx_keypad_data (= 12 Byte, .init.rodata). Moreover
it allows to move platform data (here: mbimx51_map_data and
mx51_3ds_map_data) from .data to .init.rodata. And you need some
.init.text memory for the imx_add_this_and_that function.

So if you consider a kernel that supports mx51_3ds, eukrea_cpuimx51 and
mx51_babbage. On mx51_3ds and eukrea_cpuimx51 the saving at runtime
isn't that big, they only save the platform data of the other machine.
But on mx51_babbage you profit from the whole stuff that is 376 Bytes.
Up to you to do the same calculation for e.g. imx-uart that has up to 6
instances on i.MX27 with usually only two or three used on a single
machine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
