From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 17 Jan 2016 16:21:08 +0100
Subject: [RFC/PATCH] drm/rockchip: don't wait for vblank if fb hasn't
 changed
In-Reply-To: <1452689614-6570-1-git-send-email-john@metanate.com>
References: <1452689614-6570-1-git-send-email-john@metanate.com>
Message-ID: <5745581.hZKD3MVpjF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 13. Januar 2016, 12:53:34 schrieb John Keeping:
> As commented in drm_atomic_helper_wait_for_vblanks(), userspace relies
> on cursor ioctls being unsynced.  Converting the rockchip driver to
> atomic has significantly impacted cursor performance by making every
> cursor update wait for vblank.
> 
> By skipping the vblank sync when the framebuffer has not changed (as is
> done in drm_atomic_helper_wait_for_vblanks()) we can avoid this for the
> common case of moving the cursor and only need to delay the cursor ioctl
> when the cursor icon changes.
> 
> I originally inserted a check on legacy_cursor_update as well, but that
> caused a storm of iommu page faults.  I didn't investigate the cause of
> those since this change gives enough of a performance improvement for my
> use case.
> 
> This is RFC because of that and because the framebuffer_changed()
> function is copied from drm_atomic_helper.c as a quick way to test the
> result.
> 
> Signed-off-by: John Keeping <john@metanate.com>

I've seen the effects now as well after making the atomic parts work on in 
my devtree - i.e. sluggish cursor movements.

This patch fixes that issue, so at least:
Tested-by: Heiko Stuebner <heiko@sntech.de>


Right now I still see flickering on animated cursors though (like ones used 
by KDE), that wasn't present before.


Heiko
