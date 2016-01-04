From: jamesjj.liao@mediatek.com (James Liao)
Date: Mon, 4 Jan 2016 10:52:51 +0800
Subject: [PATCH 2/4] soc: mediatek: Init MT8173 scpsys driver earlier
In-Reply-To: <4141203.8f3N9nOLLy@wuerfel>
References: <1451457706-14798-1-git-send-email-jamesjj.liao@mediatek.com>
 <1451541566.10610.10.camel@mtksdaap41>
 <1451553394.10610.14.camel@mtksdaap41> <4141203.8f3N9nOLLy@wuerfel>
Message-ID: <1451875971.14940.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, 2015-12-31 at 15:45 +0100, Arnd Bergmann wrote:
> On Thursday 31 December 2015 17:16:34 James Liao wrote:
> > 
> > """
> > Take a example for our IOMMU(M4U) and SMI.  The IOMMU which is
> > subsys_init defaultly will depend on SMI. 
> > The SMI is a bridge between m4u and the Multimedia HW.  About the HW
> > block diagram and more other information please help check  [1].
> > SMI is responsible to enable/disable iommu and help transfer data for
> > each Multimedia HW,  Both have to wait until the power and the clocks is
> > enabled.  
> > 
> > So our iommu should probe done after smi, smi should be after
> > power-domain, and all the iommu consumer(display/vdec/venc/camera etc.)
> > should be after the iommu.
> > Then all the multimedia module will be delayed by power-domain who is
> > module_init currently.
> > 
> > After grep, we get some example whose  pm is not module_init:
> > core_initcall(exynos4_pm_init_power_domain);
> > subsys_initcall(imx_pgc_init);
> > 
> > So we expect move the power-domain initial more earlier too.  The
> > power-domain seems to be a basic module like ccf.
> > Is there some special reason about we should use module_init,  or do you
> > have any concern if we change it?
> > Thanks.
> 
> Ok, got it. Generally, we should try to avoid using the earlier initcall
> levels, but a few things like clock controllers, iommus etc are special
> enough that we need to make sure their dependencies are there by the
> time those are probed.
> 
> Please put your explanation above into the patch changelog and add a code
> comment about the IOMMU next to the subsys_initcall() so it doesn't
> accidentally get changed when someone tries to do a code cleanup.

OK, I'll add comments in next patch. Thanks for your comments.


Best regards,

James
