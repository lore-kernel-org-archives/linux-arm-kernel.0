From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 May 2017 09:01:27 -0700
Subject: [PATCH v2] misc: sram-exec: Use aligned fncpy instead of memcpy
In-Reply-To: <20170503185533.GS23750@n2100.armlinux.org.uk>
References: <20170410145247.6023-1-d-gerlach@ti.com>
 <20170503185533.GS23750@n2100.armlinux.org.uk>
Message-ID: <20170516160127.GH31418@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [170503 11:58]:
> On Mon, Apr 10, 2017 at 09:52:47AM -0500, Dave Gerlach wrote:
> > Currently the sram-exec functionality, which allows allocation of
> > executable memory and provides an API to move code to it, is only
> > selected in configs for the ARM architecture. Based on commit
> > 5756e9dd0de6 ("ARM: 6640/1: Thumb-2: Symbol manipulation macros for
> > function body copying") simply copying a C function pointer address
> > using memcpy without consideration of alignment and Thumb is unsafe on
> > ARM platforms.
> > 
> > The aforementioned patch introduces the fncpy macro which is a safe way
> > to copy executable code on ARM platforms, so let's make use of that here
> > rather than the unsafe plain memcpy that was previously used by
> > sram_exec_copy. Now sram_exec_copy will move the code to "dst" and
> > return an address that is guaranteed to be safely callable.
> > 
> > In the future, architectures hoping to make use of the sram-exec
> > functionality must define an fncpy macro just as ARM has done to
> > guarantee or check for safe copying to executable memory before allowing
> > the arch to select CONFIG_SRAM_EXEC.
> > 
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> 
> Looks a lot saner, thanks.  It's just a bit sad that we lose the type
> checking.
> 
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Looks like this is still pending so I'll add it into
omap-for-v4.12/fixes so we can get this out of the way.

Regards,

Tony
