From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Oct 2015 12:12:23 +0200
Subject: [PATCH v2 2/6] vfio: platform: reset: add
 vfio_platform_reset_private.h
In-Reply-To: <1445506922-6005-3-git-send-email-eric.auger@linaro.org>
References: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
 <1445506922-6005-3-git-send-email-eric.auger@linaro.org>
Message-ID: <4144159.DC8Yilf9Tr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 October 2015 11:41:58 Eric Auger wrote:
> v2: creation
> - this defines the module_vfio_reset_handler macro as suggested by Arnd
> 
> Although Arnd suggested me to remove the vfio_platform_register_reset
> symbol_get (since the module manager can handle the case where the
> vfio-platform driver is not loaded), I prefered to keep it while
> introducing the macro. The rationale is, when using symbol_get/put
> we are able to release the hold from the reset module on vfio-platform
> as soon as the registration is complete and I think this makes sense.

This makes it highly unusual. I can't think of a good reason to allow
unloading the vfio platform module while a reset module is registered,
that just causes a memory leak (or possibly a crash) when you do
unload the core module while it's used by a reset driver, it
prevents the reset module from getting loaded without loading the
vfio module first (because the autoloading doesn't work), and it
means we don't catch build errors in invalid configurations where you
have only the reset driver but not the vfio driver enabled.

	Arnd
