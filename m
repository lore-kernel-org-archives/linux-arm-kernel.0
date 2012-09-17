From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Mon, 17 Sep 2012 10:02:32 -0400
Subject: [PATCH v4 12/24] xen/arm: introduce CONFIG_XEN on ARM
In-Reply-To: <50571289.3040509@mvista.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
 <1347621207-11294-12-git-send-email-stefano.stabellini@eu.citrix.com>
 <505374E2.5080308@mvista.com>
 <alpine.DEB.2.02.1209171155010.29232@kaball.uk.xensource.com>
 <50571289.3040509@mvista.com>
Message-ID: <20120917140232.GA11996@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 04:07:37PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 17-09-2012 14:57, Stefano Stabellini wrote:
> 
> >>>Changes in v2:
> 
> >>>- mark Xen guest support on ARM as EXPERIMENTAL.
> 
> >>>Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> >>>Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >>>---
> >>>  arch/arm/Kconfig |   10 ++++++++++
> >>>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> >>>diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >>>index 2f88d8d..e92518d 100644
> >>>--- a/arch/arm/Kconfig
> >>>+++ b/arch/arm/Kconfig
> >>>@@ -1897,6 +1897,16 @@ config DEPRECATED_PARAM_STRUCT
> >>>  	  This was deprecated in 2001 and announced to live on for 5 years.
> >>>  	  Some old boot loaders still use this way.
> >>>
> >>>+config XEN_DOM0
> >>>+	def_bool y
> >>>+
> >>>+config XEN
> >>>+	bool "Xen guest support on ARM (EXPERIMENTAL)"
> >>>+	depends on EXPERIMENTAL && ARM && OF

I think the CONFIG_EXPERIMENTAL is going away. Or it has already
gone away?

> >>>+	select XEN_DOM0
> 
> >>    What's the point of selecting it if it's always "y"?
> 
> >That's because on X86 is not always "y": there are things under
> >drivers/xen that compile on both platforms and depend on XEN_DOM0.
> 
>    But we're not on x86. On ARM this select is pointless.

Sure, but parts of the generic Xen (drivers/xen) code functionality has checks
for that (CONFIG_DOM0) to use some functionality that is not neccessarily
considered "dom0" specific for ARM.

The right way is to seperate those to be more of a 'backend' config and
'frontend' config. But those CONFIG options are a maze and I figured I
will fix this Gordon knot once this is all accepted/compiled/works, and then
slowly untangle the CONFIG-mess.

> 
> WBR, Sergei
