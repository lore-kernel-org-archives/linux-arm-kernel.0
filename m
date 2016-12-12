From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2016 10:23:43 +0000
Subject: [PATCH 1/1] arm/module: maximum utilization of module area.
In-Reply-To: <1481012975-44478-1-git-send-email-maninder1.s@samsung.com>
References: <1481012975-44478-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <20161212102342.GT14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 01:59:35PM +0530, Maninder Singh wrote:
> This patch defines new macro MODULE_START to ensure kernel text
> and module remains within 32 MB of address range.
> 
> Tried this patch by inserting 20 MB size module on 4.1 kernel:-
> 
> Earlier:-
> ==========
> sh# insmod size.ko
> ....
> insmod: ERROR: could not insert module size.ko: Cannot allocate memory
> sh#
> 
> With this patch
> ===============
> sh# insmod size.ko
> ...
> sh# lsmod
> Module                  Size  Used by
> size                20972425  0
> 
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Reviewed-by: Ajeet Yadav <ajeet.y@samsung.com>

A PC24 relocation has a range of +/-32MB.  This means that where-ever
the module is placed, it must be capable of reaching any function
within the kernel text, which may itself be quite large (eg, 8MB, or
possibly larger).  The module area exists to allow modules to be
located in an area where PC24 relocations are able to reach all of the
kernel text on sensibly configured kernels, thereby allowing for
optimal performance.

If you wish to load large modules, then enable ARM_MODULE_PLTS, which
will use the less efficient PLT method (which is basically an indirect
function call) for relocations that PC24 can't handle, and will allow
the module to be loaded into the vmalloc area.

Growing the module area so that smaller modules also get penalised by
the PLT indirection is not sane.

So, I'm afraid this change is not acceptable.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
