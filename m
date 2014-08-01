From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 01 Aug 2014 12:01:39 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <53DB6B4F.9080605@arm.com>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
 <53DB6B4F.9080605@arm.com>
Message-ID: <1406890899.2794.40.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-08-01 at 11:26 +0100, Sudeep Holla wrote:
> 
> On 22/07/14 19:01, Olof Johansson wrote:
> > This is a major refresh of the multi_v7_defconfig:
> >
> > - Bring over a bunch of Samsung drivers to make ODROID-U3 and Chromebooks usable
> >   * Enable big.LITTLE
> >   * MCPM
> [...]

> > +CONFIG_BIG_LITTLE=y
> > +CONFIG_BL_SWITCHER=y
> 
> IIUC, this will enable switcher code by default. I am not sure if this
> is intentional ? E.g.: After this I can have only 2 active cpus instead
> of 5 on my Vexpress TC2 platform.
> 
> IMO we can keep this enabled by default in the build, but disabled
> by default on boot.

TC2 has a big.LITTLE processor and the switcher is the only mainlined
way of making any kind of proper use of big.LITTLE, so why not have it
enabled by default?

>  One way to achieve this:
> (There's sysfs to re-enable it runtime)

The opposite is also true, if you don't want the switcher enabled you
can disable it by the same method after boot ;-)

> -->8
> diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> index 490f3dced749..f4c36e70166a 100644
> --- a/arch/arm/common/bL_switcher.c
> +++ b/arch/arm/common/bL_switcher.c
> @@ -794,7 +794,7 @@ static int bL_switcher_hotplug_callback(struct 
> notifier_block *nfb,
>          return NOTIFY_DONE;
>   }
> 
> -static bool no_bL_switcher;
> +static bool no_bL_switcher = true;

This changes the default for everyone, which I guess is fair enough if
there is a good reason, but I'm not sure there is.

-- 
Tixy
