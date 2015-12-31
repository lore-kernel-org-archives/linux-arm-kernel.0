From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 31 Dec 2015 17:16:34 +0800
Subject: [PATCH 2/4] soc: mediatek: Init MT8173 scpsys driver earlier
In-Reply-To: <1451541566.10610.10.camel@mtksdaap41>
References: <1451457706-14798-1-git-send-email-jamesjj.liao@mediatek.com>
 <1670989.QknqqsXE3p@wuerfel> <1451470328.22426.5.camel@mtksdaap41>
 <6145950.8rtkDup7QD@wuerfel> <1451541566.10610.10.camel@mtksdaap41>
Message-ID: <1451553394.10610.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
> On Wed, 2015-12-30 at 11:35 +0100, Arnd Bergmann wrote:
> > On Wednesday 30 December 2015 18:12:08 James Liao wrote:
> > > On Wed, 2015-12-30 at 09:52 +0100, Arnd Bergmann wrote:
> > > > On Wednesday 30 December 2015 14:41:44 James Liao wrote:
> > > > > Some power domain comsumers may init before module_init.
> > > > > So the power domain provider (scpsys) need to be initialized
> > > > > earlier too.
> > > > > 
> > > > > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > > > > ---
> > > > > 
> > > > 
> > > > Why?
> > > 
> > > Some drivers use different init level to ensure they can be initialized
> > > before other drivers. To support these drivers, moving scpsys driver's
> > > initial function to subsys_init is the most easy way.
> > 
> > This is just the same generic explanation that you already have.
> > 
> > Please be more specific what the dependency is and why we can't rely
> > on deferred probing here.
> 
> In our case, there is a SMI driver provide APIs to control multiple
> devices that attached to different power domains.Video encoder / decoder
> and GPU drivers are SMI users. It's not easy for SMI users to detect SMI
> and scpsys driver are initialized or not. A most easy way to resolve the
> init sequence issue is moving SMI and scpsys driver in early init stage.
> 
> Do you prefer to keep scpsys driver's init in module_init? If yes, I can
> remove this patch in next version.

After discuss with our SMI / IOMMU driver owner, he still prefer to keep
scpsys driver init in subsys_init. Here is his explanation:

"""
Take a example for our IOMMU(M4U) and SMI.  The IOMMU which is
subsys_init defaultly will depend on SMI. 
The SMI is a bridge between m4u and the Multimedia HW.  About the HW
block diagram and more other information please help check  [1].
SMI is responsible to enable/disable iommu and help transfer data for
each Multimedia HW,  Both have to wait until the power and the clocks is
enabled.  

So our iommu should probe done after smi, smi should be after
power-domain, and all the iommu consumer(display/vdec/venc/camera etc.)
should be after the iommu.
Then all the multimedia module will be delayed by power-domain who is
module_init currently.

After grep, we get some example whose  pm is not module_init:
core_initcall(exynos4_pm_init_power_domain);
subsys_initcall(imx_pgc_init);

So we expect move the power-domain initial more earlier too.  The
power-domain seems to be a basic module like ccf.
Is there some special reason about we should use module_init,  or do you
have any concern if we change it?
Thanks.

[1]:
http://lists.linuxfoundation.org/pipermail/iommu/2015-December/015105.html


Best Regards.

James
