From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 30 Sep 2010 12:19:38 +0200
Subject: [PATCH 1/6] mmc: sdhci-pltfm: Add structure for host-specific data
In-Reply-To: <4CA45E6D.4070308@pelagicore.com>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
	<1285790884-3516-2-git-send-email-w.sang@pengutronix.de>
	<4CA3AE89.2030107@pelagicore.com>
	<20100930081605.GA2655@pengutronix.de>
	<4CA45E6D.4070308@pelagicore.com>
Message-ID: <20100930101938.GE2655@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 11:54:53AM +0200, Richard R?jfors wrote:
> On 09/30/2010 10:16 AM, Wolfram Sang wrote:
> >Hi Richard,
> >
> >On Wed, Sep 29, 2010 at 11:24:25PM +0200, Richard R?jfors wrote:
> >>On 09/29/2010 10:07 PM, Wolfram Sang wrote:
> >>>We need to carry some information per host, e.g. the clock. Add a
> >>>structure for it and initialize it in the generic part. Also do not use
> >>>the parent of the platform_device (if it is available), this breaks the
> >>>clock-matching on ARM.
> >>
> >>The reason it's there is for instance a case when the shdci device is exposed
> >>from a MFD device which sits on top of PCI. Then the parent (PCI device)
> >>is the device that is DMA capable. This patch will break such usage.
> >
> >I feared that there is a reason. The problem I see is now, that the parent gets
> >always set (from drivers/base/platform.c):
> 
> Then we obviously need to pass more information in the platform_data to be able
> to chose which device to be used.

Yeah, that was my idea, too.

> >So, sdhci-plftm cannot access the platform_data connected to the original
> >platform_device via host->mmc->parent.
> 
> You're right it wouldn't. But isn't it a bit risky even if you could access it,
> in the long the platform_data coild point to something that is in the __devinit section
> or similar?

The use-case we see now is in the custom init() call, i.e. setting up
GPIO, enabling clocks. That is in the same section. Accessing
platform_data later is in deed always risky and should not be done,
sdhci-pltfm is no special case here.

> What about extend the struct you defined with the pieces needed, and access it via
> sdhci_priv?

At the moment, I don't think this is needed. Will think more about it
(and the other comments) next week, already preparing for a long weekend
\o/

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100930/d0f79250/attachment.sig>
