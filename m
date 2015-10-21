From: scottwood@freescale.com (Scott Wood)
Date: Wed, 21 Oct 2015 00:54:05 -0500
Subject: [PATCH v6 22/22] of/platform: Defer probes of registered devices
In-Reply-To: <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1445406845.701.55.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-09-21 at 16:03 +0200, Tomeu Vizoso wrote:
> Instead of trying to match and probe platform and AMBA devices right
> after each is registered, delay their probes until device_initcall_sync.
> 
> This means that devices will start probing once all built-in drivers
> have registered, and after all platform and AMBA devices from the DT
> have been registered already.
> 
> This allows us to prevent deferred probes by probing dependencies on
> demand.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
> 
> Changes in v4:
> - Also defer probes of AMBA devices registered from the DT as they can
>   also request resources.
> 
>  drivers/of/platform.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

This breaks arch/powerpc/sysdev/fsl_pci.c.  The PCI bus is an OF platform 
device, and it must be probed before pcibios_init() which is a 
subsys_initcall(), or else the PCI bus never gets scanned.

-Scott
