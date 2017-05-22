From: eric@anholt.net (Eric Anholt)
Date: Mon, 22 May 2017 09:23:36 -0700
Subject: [PATCH] drm/pl111: add ARM_AMBA dependency
In-Reply-To: <20170522152058.3346428-1-arnd@arndb.de>
References: <20170522152058.3346428-1-arnd@arndb.de>
Message-ID: <878tlolv1z.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The driver is written in a way to enable compile-testing without CONFIG_ARM_AMBA,
> but it just causes needless warnings:
>
> drivers/gpu/drm/pl111/pl111_drv.c:149:26: error: 'pl111_drm_driver' defined but not used [-Werror=unused-variable]
> drivers/gpu/drm/pl111/pl111_drv.c:81:12: error: 'pl111_modeset_init' defined but not used [-Werror=unused-function]
>
> This removes the #ifdef instead, and adds a dependency on ARM_AMBA to
> only let us build the driver when the base support is enabled.
>
> Unfortunately, this requires removing one redundant 'select ARM_AMBA'
> line from mach-s3c64xx to avoid a circular dependency.
>
> It might be good to allow manually enabling ARM_AMBA when COMPILE_TEST
> is turned on, but that should be a separate patch and may cause other
> build regressions.

If I understand the Kconfig, you're effectively disabling the build on
COMPILE_TEST && !ARM.  I'd rather that we just fix up the warnings, so
that people can keep build-testing DRM drivers:

https://patchwork.kernel.org/patch/9737857/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/951802e5/attachment.sig>
