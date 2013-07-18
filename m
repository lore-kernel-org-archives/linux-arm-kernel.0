From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jul 2013 17:50:07 +0100
Subject: [PATCH] arm: choose debug/uncompress.h include when uncompress
 debug is disabled
In-Reply-To: <51E81B39.2030805@linaro.org>
References: <1373897706-15331-1-git-send-email-julien.grall@linaro.org>
 <alpine.DEB.2.02.1307171420350.8258@kaball.uk.xensource.com>
 <20130717151148.GM24642@n2100.arm.linux.org.uk> <51E81B39.2030805@linaro.org>
Message-ID: <20130718165007.GA24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 05:43:37PM +0100, Julien Grall wrote:
> When Xen will boot, it will use one UART, given by the user, to be able
> to log its information. Xen will not map the UART region and the IRQ to
> dom0. Of course it will not be present in the device tree either. So if
> Linux tries to access to this memory region, it will crash.
> 
> When Linux will boot as dom0, it will either use an hvc console or
> another UART.
> 
> In case of multi-platform environments, there is no issue because when
> CONFIG_DEBUG_UNCOMPRESS is disabled.
> 
> Now, in non-multiplatform environment, the decompressor will use a
> pre-defined UART. This UART may be already used by Xen and Linux will
> abort at the first access.
> 
> I think, the decompressor should be able to detect if the UART exists
> (I'm not sure it's possible) or disabled at compile time uncompress log.
> 
> Do you have any better ideas?

Let me get this straight.

1. You want to run an _existing_ platforms kernel under Xen, where the
   platform assumes that it has various devices at various locations,
   and will make direct accesses to those devices.

2. You don't want to provide some of those devices, and you arrange for
   those unprovided devices to fault.

Excuse me if I think that's really silly.

Lastly, aren't all ARMv7 kernels (therefore Xen supporting kernels)
supposed to be part of the multiplatform kernel stuff now?
