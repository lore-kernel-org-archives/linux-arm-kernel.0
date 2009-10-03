From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Oct 2009 20:54:26 +0100
Subject: Sparsemem  on EP93XX
In-Reply-To: <4AC7AAAD.4000301@techworks.ie>
References: <4AC7A3D4.3080408@techworks.ie>
	<20091003194155.GA21857@n2100.arm.linux.org.uk>
	<4AC7AAAD.4000301@techworks.ie>
Message-ID: <20091003195426.GB21857@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 03, 2009 at 08:49:01PM +0100, Christian Gagneraud wrote:
> # CONFIG_EXPERIMENTAL is not set
...
> CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y

So yes, flatmem is still enabled... because there's a condition missing
in mm/Kconfig.  Try this patch:

diff --git a/mm/Kconfig b/mm/Kconfig
index 2477607..95b2965 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -67,7 +67,7 @@ config DISCONTIGMEM
 
 config SPARSEMEM
 	def_bool y
-	depends on SPARSEMEM_MANUAL
+	depends on (!SELECT_MEMORY_MODEL && ARCH_SPARSEMEM_ENABLE) || SPARSEMEM_MANUAL
 
 config FLATMEM
 	def_bool y
