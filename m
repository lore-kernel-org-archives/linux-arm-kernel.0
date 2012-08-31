From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 31 Aug 2012 11:30:46 +0300
Subject: [PATCH 0/3] ARM: OMAP2/3: DSS HWMOD fixes
In-Reply-To: <alpine.DEB.2.00.1207040610310.6760@utopia.booyaka.com>
References: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.00.1206271416420.27496@utopia.booyaka.com>
 <alpine.DEB.2.00.1207040610310.6760@utopia.booyaka.com>
Message-ID: <1346401846.32389.7.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-07-04 at 06:11 -0600, Paul Walmsley wrote:
> Hi Tomi
> 
> On Wed, 27 Jun 2012, Paul Walmsley wrote:
> 
> > On Thu, 10 May 2012, Tomi Valkeinen wrote:
> > 
> > > These patches fix DSS hwmod data related to sysc flags. I haven't seen any
> > > problem produced by these missing bits, but by looking at the TRM it's clear
> > > that they should be defined.
> > > 
> > > However, applying these will cause additional warnings to show during boot:
> > > 
> > > omap_hwmod: dss_dispc: softreset failed (waited 10000 usec)
> > > omap_hwmod: dss_rfbi: softreset failed (waited 10000 usec)
> > > 
> > > Most likely the softreset fails even now, but as there's no check to verify it,
> > > no warnings are visible.
> > > 
> > > I think the reason for the failing softreset is the same problem as we have on
> > > OMAP4: dss_core hwmod should be enabled before other dss hwmods can be enabled
> > > (and reset).
> > 
> > Thanks, queued for 3.6.
> > 
> > Not sure what to do about the softreset issues at the moment, due to 
> > competing priorities.  But for sure the data should match the hardware.
> 
> I've dropped these for 3.6 since they cause a PM regression during a 
> system suspend test:
> 
> [   39.721282] Powerdomain (dss_pwrdm) didn't enter target state 1
> 
> Probably before we can pull these in, we need to figure out what's going 
> on there.

Just tested with current mainline
(155e36d40cf31c17f2b629fc2f2f5527e4cfc324) on omap3 overo, with DSS,
USB, MMC disabled in the kernel config:

# echo mem > /sys/power/state 
[   14.140472] PM: Syncing filesystems ... done.
[   14.154205] Freezing user space processes ... (elapsed 0.02 seconds)
done.
[   14.184173] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   14.234283] PM: suspend of devices complete after 13.977 msecs
[   14.244567] PM: late suspend of devices complete after 4.028 msecs
[   14.257110] PM: noirq suspend of devices complete after 6.011 msecs
[   14.263885] Disabling non-boot CPUs ...
[   15.986541] Powerdomain (iva2_pwrdm) didn't enter target state 1
[   15.992858] Powerdomain (dss_pwrdm) didn't enter target state 1
[   15.999084] Powerdomain (per_pwrdm) didn't enter target state 1
[   16.005310] Powerdomain (core_pwrdm) didn't enter target state 1
[   16.011627] Powerdomain (usbhost_pwrdm) didn't enter target state 1
[   16.018188] Could not enter target state in pm_suspend
[   16.026580] PM: noirq resume of devices complete after 2.807 msecs
[   16.037597] PM: early resume of devices complete after 2.655 msecs

[   16.054870] PM: resume of devices complete after 10.620 msecs
[   16.065643] Restarting tasks ... done.

So things don't look correct even without my patches. Does the suspend
work for you?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120831/b032f29d/attachment.sig>
