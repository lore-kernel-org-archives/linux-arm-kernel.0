From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Feb 2011 15:10:47 +0100
Subject: [PATCH 5/5] arm: mach-mmp: brownstone.c support multiple sd slots
In-Reply-To: <23C25DE3-86A5-4115-8539-D9837268F63F@marvell.com>
References: <23C25DE3-86A5-4115-8539-D9837268F63F@marvell.com>
Message-ID: <201102141510.48137.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 February 2011, Philip Rakity wrote:
> +
> +       gpio_direction_output(poweron, 1);
> +       mdelay (20);
> +       gpio_direction_output(reset, 0);
> +       mdelay (20);
> +       gpio_direction_output(reset, 1);
> +       gpio_free(reset);
> +       gpio_free(poweron);

mdelay is not nice, especially in boot code, because a lot of people
are interested in reducing boot times, and 40 miliseconds is definitely
in the range that people notice.

At the very least, change it from mdelay() to msleep(), to allow other
processes to continue.

Ideally, you can run the function in the background using schedule_work(),
but there may be better ways to do that for the entire platform code.

	Arnd
