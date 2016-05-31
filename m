From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 31 May 2016 16:14:14 +0200
Subject: [PATCH v2 0/7] vgic fixes for 4.7-rc1
In-Reply-To: <1464186399-16604-1-git-send-email-marc.zyngier@arm.com>
References: <1464186399-16604-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160531141414.GB12568@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 03:26:32PM +0100, Marc Zyngier wrote:
> The dust has not yet settled on the new vgic, but here's the first
> batch of fixes anyway!
> 
> The first two patches are courtesy of Christoffer, who noticed that we
> fail to clear LRs that generate a maintenance interrupt, leading to
> potential screaming interrupts. This bug already exists in the current
> mainline (cc stable?)
> 
> The next two address a bug where we fail to properly resample the line
> level on exit, which could result in spurious interrupts being
> injected. This is specific to the new vgic implementation.
> 
> The following two patches tighten our GICv3 emulation by preventing
> the guest from changing the SRE setting. This bug already exists in
> mainline, though it is hardly critical.
> 
> The last patch is actually a performance optimization: if the guest is
> using GICv3, we can drop a number of barriers (since we don't need to
> change SRE, and there is no memory-mapped view to synchronize
> with). This results in a world switch that is 2.5% faster on my LS2085
> box when running GICv3 guests. I suspect that the bigger the box, the
> bigger this impact this change will have (system-wide DSBs don't really
> come cheap).
> 
> These patches have been tested on top of the kvmarm/next branch.
> 

Thanks, applied to queue (with cc stable for v4.6+ as I only think this
applies post our optimizations that went in for v4.6)

-Christoffer
