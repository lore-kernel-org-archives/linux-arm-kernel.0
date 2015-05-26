From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 26 May 2015 11:56:54 -0700
Subject: [PATCH 06/21] of/platform: Add of_platform_device_ensure()
In-Reply-To: <1432565608-26036-7-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-7-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150526185654.GE10571@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomeu,

On Mon, May 25, 2015 at 04:53:10PM +0200, Tomeu Vizoso wrote:
> This function ensures that the device that encloses the passed device
> node is registered, and thus probed if the corresponding driver has been
> registered already.

Even if the driver has already been registered this code will not
guarantee that the device has been probed if driver enabled asynchronous
probing (async probing should appear in 4.2 and the end goal is to have
async probing enabled by default for most drivers).

Also, why are we concentrating on platform drivers only? What about
other devices, for example a gpio expander behind i2c bus?

I am also concerned about adding OF-specific hooks into every subsystem
out there. Can we make process of instantiating OF devices iterative
instead and add them only if their parent has been already probed and
also devices corresponding to all phandles they reference have also been
probed? We could repeat scanning of the device tree every time we bind
a driver and bulk-add leftovers at late_initcall time. This would
mean that we could keep all logic in OF code (and maybe ACPI will add
their own implementation) and keep other subsystems unaware.

Thanks.

-- 
Dmitry
