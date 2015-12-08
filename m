From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 17:59:44 +0100
Subject: [PATCH v3] bus: uniphier-system-bus: add UniPhier System Bus
 driver
In-Reply-To: <1449591718-21753-1-git-send-email-yamada.masahiro@socionext.com>
References: <1449591718-21753-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <14233302.P9onBQovHz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 December 2015 01:21:58 Masahiro Yamada wrote:
> The UniPhier System Bus is an external that connects on-board devices
> to the UniPhier SoC.  Each bank (chip select) is dynamically mapped
> to the CPU-viewed address base via the bus controller.  The bus
> controller must be configured before any access to the bus.
> 
> This driver parses the "ranges" property of the System Bus node and
> initialized the bus controller.  After the bus becomes ready, devices
> below it are populated.
> 
> Note:
> Each bank can be mapped anywhere in the supported address space;
> there is nothing preventing us from assigning bank 0 on 0x42000000,
> 0x43000000, or anywhere as long as such region is not used by others.
> So, the "ranges" is just one possible software configuration, which
> does not seem to fit in device tree because device tree is a hardware
> description language.  However, of_translate_address() requires
> "ranges" in every bus node between CPUs and device mapped on the CPU
> address space.  In other words, "ranges" properties must be statically
> defined in device tree.  After some discussion, I decided the dynamic
> address reassignment by the driver is too bothersome.  Instead, the
> device tree should provide a reasonable translation setup that the OS
> can rely on.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Rob Herring <robh@kernel.org>

Looks very nice.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Just a little thought about one thing I found odd:

> +static int uniphier_system_bus_check_overlap(
> +					struct uniphier_system_bus_priv tmp)
> +{

Did you intentionally pass this by value? Maybe do it explicitly using a pointer
and memcpy to a local variable, which has a similar effect. Alternatively
just check each newly probed child node for conflicts with any of the
previous children. That is slightly more expensive at O(n^2) instead of O(n)
but n is always small here and you can avoid sorting first.

	Arnd
