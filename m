From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jun 2014 17:42:14 +0200
Subject: [PATCH RFC] mfd: syscon: Decouple syscon interface from syscon
 devices
In-Reply-To: <1403019164-12514-1-git-send-email-t.figa@samsung.com>
References: <53A05E2D.6020702@samsung.com>
 <1403019164-12514-1-git-send-email-t.figa@samsung.com>
Message-ID: <5027740.B7iVUcUX2T@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 June 2014 17:32:44 Tomasz Figa wrote:
> Currently a syscon entity can be only registered directly through a
> platform device that binds to a dedicated driver. However in certain use
> cases it is desirable to make a device used with another driver a syscon
> interface provider. For example, certain SoCs (e.g. Exynos) contain
> system controller blocks which perform various functions such as power
> domain control, CPU power management, low power mode control, but in
> addition contain certain IP integration glue, such as various signal
> masks, coprocessor power control, etc. In such case, there is a need to
> have a dedicated driver for such system controller but also share
> registers with other drivers. The latter is where the syscon interface
> is helpful.
> 
> This patch decouples syscon object from syscon driver, so that it can be
> registered from any driver in addition to the original "syscon" platform
> driver.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>

Hi Tomasz,

This seems like a reasonable way of solving the problem, but I think
there is an even better one that we have about in the past: if we
promote syscon from a platform driver into a a drivers/base/ helper
that is independent of the platform device matching, we can use
call syscon_regmap_lookup_* for any device node, whether it's already
bound to a driver or not, which do what you need. It would also make
it easier to call the syscon code before the platform_device
infrastructure gets initialized, which is something a number of
people have asked for, e.g. for using regmap to do SMP bringup
or for clock registration.

	Arnd
