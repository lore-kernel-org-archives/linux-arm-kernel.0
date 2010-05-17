From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 May 2010 10:15:17 +0100
Subject: Physical address access / Temporary MMU disable
In-Reply-To: <AANLkTinERP4BJFMXWtQqrwxPBtvb1lpJ73yQzO-Wb5zp@mail.gmail.com>
References: <AANLkTinERP4BJFMXWtQqrwxPBtvb1lpJ73yQzO-Wb5zp@mail.gmail.com>
Message-ID: <20100517091517.GF23118@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 11:04:09AM +0200, Hans H?bner wrote:
> I am implementing a device driver that has very strict timing and
> jitter requirements.  It uses a FIQ handler, written in assembly, that
> transfers data from the on-chip SRAM to GPIO ports.  In the default
> configuration, it appears that the FIQ handler is invoked with the MMU
> enabled, so the SRAM (and I/O) accesses are undergoing virtual address
> translation.  If there is a TLB miss, this means that the MMU tables
> in SDRAM are consulted, which violates the timing requirements of my
> driver.
> 
> In order to reduce FIQ response time jitter, I would like to not use
> virtual addresses in the FIQ handler.  Is disabling the MMU for the
> duration of the FIQ handler through the CP15 coprocessor register the
> right way to do this, or is there another way to make some section of
> code use physical addresses?

If you can't tolerate the delay it takes for a TLB miss, you certainly
can't tolerate the delay it would take to disable and flush caches, and
re-enable the MMU.  (You can't just disable the MMU - you must disable
the data cache as well.)

It sounds like you instead need to think about TLB lockdown.
