From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 13 Dec 2014 14:53:51 +0100
Subject: [PATCH v5 00/19] KVM GICv3 emulation
In-Reply-To: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20141213135351.GI16855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Mon, Dec 08, 2014 at 12:37:35PM +0000, Andre Przywara wrote:
> This is version 5 of the GICv3 guest emulation series (not for 3.19).
> 
> As the changes this time were much smaller, I updated to tree to
> 3.18.0, as it includes some bug fixes in the VGIC.
> 
> I addressed the remaining comments from Christoffer and Eric, thanks
> for the review! The changes this times were much smaller, most of them
> cosmetic or rewordings of commit messages and comments.
> I updated the kvm-gicv3/v4 branch in my repo[1] to carry all the delta
> patches. Those patches are just for reference to see what has changed
> between v4 and v5. For review and all other purposes please use the
> v5 branch.
> 
> For a changelog summary see below, also each patch carries a changelog
> now.
> Only patches 05, 08, 12, 15, 17, 18 and 19 have been changed compared
> to v4. I dropped Christoffer's Reviewed-by: tag from 05/19 because of
> the newly added function, but added the respective tags to the other
> commit messages.
> 
> I quickly tested this version with a GICv3 capable fast model in all
> endianness modes (LE guest on LE host, BE on LE, LE on BE, BE on BE).
> Both a GICv2 and a GICv3 guest were booted in all four combinations.
> 
So this is overall looking like it's getting ready to be merged for
v3.20.

However, here are the things we need resolved before putting it into
kvmarm/next:

1. You need to address the few remaining comments I had on this version.

2. You must rebase on the vgic_init series and the vcpu_nit series.
   Both are in kvmarm/queue, so I suggest you rebase on that or wait
   until both of those series hit kvm/next (later next week).  You also
   need to base this on Eric's VGIC init ioctl series
   (https://lists.cs.columbia.edu/pipermail/kvmarm/2014-December/012643.html),
   but with dropping patch 3.  As soon as Marc has taken a look at that
   series, I will merge it onto queue as well.
   This is likely going to be a pain (sorry about that) since the whole
   init/init_maps sequence has changed.

3. Get rid of any on-demand calls to vgic_init() for GICv3.  For GICv3,
   the only valid call to vgic_init() should be from the new device
   control ioctl, and all other paths that rely on vgic_init() must
   fail.

4. Resubmit a new (and hopefully final) version of the series soon after
   the merge window closes.

Then we'll queue this in kvmarm/next early so that we have time to test
it and expose it to a wider audience.

Thanks,
-Christoffer
