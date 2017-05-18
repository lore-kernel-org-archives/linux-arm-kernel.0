From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 18 May 2017 17:01:34 +0200
Subject: [PATCH v2] misc: sram-exec: Use aligned fncpy instead of memcpy
In-Reply-To: <20170410145247.6023-1-d-gerlach@ti.com>
References: <20170410145247.6023-1-d-gerlach@ti.com>
Message-ID: <20170518150134.GA3142@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 09:52:47AM -0500, Dave Gerlach wrote:
> Currently the sram-exec functionality, which allows allocation of
> executable memory and provides an API to move code to it, is only
> selected in configs for the ARM architecture. Based on commit
> 5756e9dd0de6 ("ARM: 6640/1: Thumb-2: Symbol manipulation macros for
> function body copying") simply copying a C function pointer address
> using memcpy without consideration of alignment and Thumb is unsafe on
> ARM platforms.
> 
> The aforementioned patch introduces the fncpy macro which is a safe way
> to copy executable code on ARM platforms, so let's make use of that here
> rather than the unsafe plain memcpy that was previously used by
> sram_exec_copy. Now sram_exec_copy will move the code to "dst" and
> return an address that is guaranteed to be safely callable.
> 
> In the future, architectures hoping to make use of the sram-exec
> functionality must define an fncpy macro just as ARM has done to
> guarantee or check for safe copying to executable memory before allowing
> the arch to select CONFIG_SRAM_EXEC.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Can you rebase this and resend as it doesn't apply to the tree right now
:(

thanks,

greg k-h
