From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 29 Apr 2016 17:19:40 +0800
Subject: Potential issue with SDHCI DMA
In-Reply-To: <5723227B.9070006@intel.com>
References: <1460362846-2906-1-git-send-email-akurz@blala.de>
 <6297512.2KmasKu6UN@wuerfel>	<5714857C.9070002@intel.com>
 <7893683.FFM02uuNdT@wuerfel>	<57232233.1030702@intel.com>
 <5723227B.9070006@intel.com>
Message-ID: <20160429171940.576ca5eb@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Adrian,

On Fri, 29 Apr 2016 11:59:39 +0300 Adrian Hunter wrote:

> + linux-mmc
> 
> On 29/04/16 11:58, Adrian Hunter wrote:
> > On 18/04/16 17:33, Arnd Bergmann wrote:  
> >> On Monday 18 April 2016 09:58:04 Adrian Hunter wrote:  
> >>>
> >>> Thanks for looking.
> >>>
> >>> It looked to me like sdhci-pxav3 devices created by mmp2_add_sdhost() might
> >>> also be candidates.
> >>>  
> >>
> >> Oh, you are right, I missed that.
> >>
> >> I remember looking at sdhci-pxav2 and not finding any machine defining one,
> >> but I must have skipped over sdhci-pxav3 failing to realize that this is
> >> a different one.
> >>
> >> 	Arnd
> >>  
> > 
> > OK, so my plan to email sdhci driver maintainers ran into a snag.  It turned
> > out to be too hard to dig up email addresses.  I have grabbed a few names
> > and cc'ed them to this email anyway.
> > 
> > For those people, the issue is this:
> > 
> > An unexpected side-effect of commit 7b91369b4655 ("mmc: sdhci: Set DMA mask
> > when adding host") is that SDHCI devices that do not define a DMA mask may
> > find that DMA no longer works.  That was the case for a sdhci-esdhc-imx
> > device, but that has been fixed - refer commit fc26fe9c3869 ("ARM: mach-imx:
> > sdhci-esdhc-imx: initialize DMA mask").
> > 
> > DeviceTree, ACPI and PCI always set up a DMA mask for devices that they
> > enumerate, so only hard-coded platform devices are expected to be affected.
> > 
> > We found only one other candidate: sdhci-pxav3 devices created by
> > mmp2_add_sdhost().  Not sure if anyone has looked at that though.

Thanks for the kind remind. All Marvell berlin SoCs' linux kernel (no matter
upstreamed or internal) are DT based, so we (berlin SoCs) are not affected by
this issue.

I'm not sure who is maintaining mmp.

Thanks,
Jisheng

> > 
> > Obviously, if you are unsure if your devices are affected, you can test and
> > if there is a problem you will see the warning messages "mmcX: Failed to set
> > 32-bit DMA mask" and "mmcX: No suitable DMA available - falling back to PIO".
> > 
> > Regards
> > Adrian
> > 
> >   
> 
