From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 Apr 2014 19:44:14 +0530
Subject: [PATCH] arm: edma: Fix xbar mapping
In-Reply-To: <alpine.DEB.2.02.1404132123100.22697@ionos.tec.linutronix.de>
References: <alpine.DEB.2.02.1404132123100.22697@ionos.tec.linutronix.de>
Message-ID: <534BED36.2060907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Matt with current e-mail address.

On Monday 14 April 2014 02:18 AM, Thomas Gleixner wrote:
> Subject: arm: edma: Fix xbar mapping
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Sun, 13 Apr 2014 20:44:46 +0200
> 
> This is another great example of trainwreck engineering:
> 
> commit 2646a0e529 (ARM: edma: Add EDMA crossbar event mux support)
> added support for using EDMA on peripherals which have no direct EDMA
> event mapping.

I committed it, so the blame goes to me (at least in part).

> 
> The code compiles and does not explode in your face, but that's it.
> 
> 1) Reading an u16 array from an u32 device tree array simply does not
>    work. Even if the function is named "edma_of_read_u32_to_s16_array".
> 
>    It merily calls of_property_read_u16_array. So the resulting 16bit
>    array will have every other entry = 0.
> 
> 2) The DT entry for the xbar registers related to xbar has length 0x10
>    instead of the real length: 0xfd0 - 0xf90 = 0x40.
> 
>    Not a real problem as it does not cross a page boundary, but
>    wrong nevertheless.
> 
> 3) But none of this matters as the mapping never happens:
> 
>    After reading nonsense edma_of_read_u32_to_s16_array() invalidates
>    the first array entry pair, so nobody can ever notice the
>    braindamage by immediate explosion.
> 
> Seems the QA criteria for this code was solely not to explode when
> someone adds edma-xbar-event-map entries to the DT. Goal achieved,
> congratulations!
> 
> Not really helpful if someone wants to use edma on a device which
> requires a xbar mapping.
> 
> Fix the issues by:
> 
> - annotating the device tree entry with "/bits/ 16" as documented in
>   the of_property_read_u16_array kernel doc
> 
> - make the size of the xbar register mapping correct
> 
> - invalidating the end of the array and not the start
> 
> This convoluted mess wants to be completely rewritten as there is no
> point to keep the xbar_chan array memory and the iomapping of the xbar
> regs around forever. Marking the xbar mapped channels as used should
> be done right there.
> 
> But that's a different issue and this patch is small enough to make it
> work and allows a simple backport for stable.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

This time, I tested this patch and FWIW you can add:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
