From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 8 May 2013 12:56:19 +0200
Subject: [PATCH] ARM: tegra: disable LP2 cpuidle state if PCIe is enabled
In-Reply-To: <20130508094004.GL7949@tbergstrom-lnx.Nvidia.com>
References: <1367872744-25002-1-git-send-email-swarren@wwwdotorg.org>
 <20130507124849.GM7949@tbergstrom-lnx.Nvidia.com>
 <20130507130850.GA11202@avionic-0098.adnet.avionic-design.de>
 <518915A7.1020105@wwwdotorg.org>
 <20130508094004.GL7949@tbergstrom-lnx.Nvidia.com>
Message-ID: <20130508105619.GA6682@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 12:40:04PM +0300, Peter De Schrijver wrote:
> On Tue, May 07, 2013 at 04:54:31PM +0200, Stephen Warren wrote:
> > On 05/07/2013 07:08 AM, Thierry Reding wrote:
> > > On Tue, May 07, 2013 at 03:48:49PM +0300, Peter De Schrijver
> > > wrote:
> > >> On Mon, May 06, 2013 at 10:39:04PM +0200, Stephen Warren wrote:
> > >>> From: Stephen Warren <swarren@nvidia.com>
> > >>> 
> > >>> Tegra20 HW appears to have a bug such that PCIe device
> > >>> interrupts, whether they are legacy IRQs or MSI, are lost when
> > >>> LP2 is enabled. To work around this, simply disable LP2 if the
> > >>> PCI driver and DT node are both enabled.
> > >>> 
> > >> 
> > >> Wouldn't it make more sense to disable LP2 when we actually
> > >> detect a PCIe device?
> > 
> > I did consider that, but rejected the idea for the reasons Thierry
> > mentioned.
> > 
> > > I'm not sure a patch to do so would be as simple as this one. For
> > > one, the cpuidle framework will already have been initialized when
> > > PCIe enumeration completes. So some way of permanently disabling
> > > one state at runtime would be required and I don't think cpuidle
> > > provides an API to do so. I know the latter isn't really a good
> > > reason, but I don't think adding that kind of API just because
> > > Tegra20 seems to have a bug would be appropriate.
> > 
> > There is a way to do this, since it can be done via sysfs, but I don't
> > think it's exposed as an API from cpuidle. I agree it seems a little
> > silly to expose it just to support this HW bug though.
> > 
> > > Furthermore, it is quite likely that the PCIe controller will only
> > > be enabled in DT for devices that actually have a PCIe device
> > > hooked up.
> > 
> 
> That's not always true though. Eg Harmony has a miniPCIe slot, so it should be
> listed in DT, but there is not necessarily a card present in the slot.

That's true. I suppose one could argue that Harmony is a development
board and more typical setups wouldn't have user-accessible slots.

Then again it seems like LP2 causes some more fallout like very slow
output on the serial console and a decrease in FPS for some 2D/3D use-
cases I've been playing around with. While these are only performance
issues they still indicate that something is seriously flawed with the
current LP2 implementation (at least on Tegra20). So maybe it would be
preferable to disable it altogether if it cannot be fixed otherwise.

I was able to mitigate the problems a bit on Tamonten by reducing the
value of the nvidia,cpu-pwr-good-time and nvidia,cpu-pwr-off-time from
5000 us to 500 and 100 us respectively. That gives much better
performance for the serial console and 2D/3D test-cases, but the 2D/3D
performance is still down by about 10% compared to runs with LP2
disabled.

Now the 2D and 3D test-cases aren't very complex and there's certainly
much that could be improved with regard to job submission and such, but
neither removes the fundamental issue that LP2 is causing a lot of
problems that it shouldn't.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130508/ba3e2b17/attachment.sig>
