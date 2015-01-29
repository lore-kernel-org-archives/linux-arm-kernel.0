From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 29 Jan 2015 10:51:51 -0800
Subject: [PATCH] Input: sun4i-ts: add thermal driver dependency
In-Reply-To: <54C9E63A.6020806@redhat.com>
References: <2265502.1m7jYBaqyh@wuerfel>
 <54C9E63A.6020806@redhat.com>
Message-ID: <20150129185151.GA33547@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 08:50:18AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 28-01-15 16:17, Arnd Bergmann wrote:
> >The sun4i-ts driver has had a dependency on the thermal code
> >since it was first merged,
> 
> The "since it was first merged bit" is not true, this is caused
> by recent changes by ChenYu.
> 
> Other then that no objections from me against the proposed fix.
> 
> Regards,
> 
> Hans
> 
> 
>  but this is not currently enforced
> >in Kconfig, so in some randconfig builds we get
> >
> >drivers/built-in.o: In function `sun4i_ts_remove':
> >:(.text+0x2376f4): undefined reference to `thermal_zone_of_sensor_unregister'
> >drivers/built-in.o: In function `sun4i_ts_probe':
> >:(.text+0x237a94): undefined reference to `thermal_zone_of_sensor_register'
> >:(.text+0x237c00): undefined reference to `thermal_zone_of_sensor_unregister'
> >
> >We need the dependency on THERMAL in order to ensure that this
> >driver becomes a loadable module if the thermal support itself
> >is modular, while the dependency on THERMAL_OF is a runtime dependency
> >and the driver will still build but not work if it is missing.
> >
> >Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >Fixes: 6decea7c5438e2 ("Input: add driver for Allwinner sunxi SoC's rtp controller")
> >
> >diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> >index 58917525126e..e2447f0063b7 100644
> >--- a/drivers/input/touchscreen/Kconfig
> >+++ b/drivers/input/touchscreen/Kconfig
> >@@ -943,6 +943,8 @@ config TOUCHSCREEN_SUN4I
> >  	tristate "Allwinner sun4i resistive touchscreen controller support"
> >  	depends on ARCH_SUNXI || COMPILE_TEST
> >  	depends on HWMON
> >+	depends on THERMAL
> >+	depends on THERMAL_OF || COMPILE_TEST

THERMAL_OF does have proper stubs and I do not see why we need to force
having TERMAL even if we don't do compile test. Should the dependency be:

	depends on !THERMAL_OF || TERMAL

Thanks.

-- 
Dmitry
