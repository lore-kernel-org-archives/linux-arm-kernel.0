From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 May 2014 02:08:51 -0400
Subject: [PATCHv4 3/3] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <1400165974-9059-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400165974-9059-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400165974-9059-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140516060851.GF27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 04:59:34PM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 375 and Armada 38x SOCs, which use the Cortex-A9
> CPU core, the PL310 cache and the Marvell PCIe hardware block are
> affected a L2/PCIe deadlock caused by a system erratum when hardware
> I/O coherency is used.
> 
> This deadlock can be avoided by mapping the PCIe memory areas as
> strongly-ordered (note: MT_UNCACHED is strongly-ordered), and by
> removing the outer cache sync done in software. This is implemented in
> this patch by:
> 
>  * Registering a custom arch_ioremap_caller function that allows to
>    make sure PCI memory regions are mapped MT_UNCACHED.
> 
>  * Adding at runtime the 'arm,io-coherent' property to the PL310 cache
>    controller. This cannot be done permanently in the DT, because the
>    hardware I/O coherency can only be enabled when CONFIG_SMP is
>    enabled, in the current kernel situation.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/coherency.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Applied to mvebu/soc.

thx,

Jason.
