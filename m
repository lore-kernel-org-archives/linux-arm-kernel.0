From: joe@perches.com (Joe Perches)
Date: Mon, 14 Jan 2013 09:17:37 -0800
Subject: [PATCH 04/18] power: ab8500_fg: Replace msleep() with
 usleep_range() for greater accuracy
In-Reply-To: <1357909986-9262-5-git-send-email-lee.jones@linaro.org>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
 <1357909986-9262-5-git-send-email-lee.jones@linaro.org>
Message-ID: <1358183857.19400.13.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-01-11 at 13:12 +0000, Lee Jones wrote:
> Doing so provides a greater degree of accuracy when dealing with
> time-frames between 1us and 20ms. msleep() is only accurate for
> wake-ups greater than 20ms.
[]
> diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
[]
> @@ -956,7 +956,7 @@ static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
>  	do {
>  		vbat += ab8500_fg_bat_voltage(di);
>  		i++;
> -		msleep(5);
> +		usleep_range(5000, 5001);

If you're going to give a range that small
you might as well use usleep instead.

Otherwise, add some tolerance to allow any
other coalesced wakeup to occur.
