From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Feb 2014 17:26:20 +0100
Subject: [PATCH v3 00/13] pinctrl: mvebu: restructure resource allocation
In-Reply-To: <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140213172620.76e760ba@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

Thanks again for working on this! I have boot tested this successfully
on an Armada XP platform, and it seems to behave normally, the debugfs
pinctrl contents make sense.

I have a few comments below, though.

On Wed, 12 Feb 2014 16:59:23 +0100, Sebastian Hesselbarth wrote:

> Also, in the meantime, pinctrl driver stubs for new Armada 375/28x have
> been posted [3]. Before any of this patches move to a stable branch, I
> plan to send an updated version comprising the required patches for the
> new SoCs. As the new driver stubs are very much like what we already have
> for Armada 370/XP, let's only discuss the general approach now and add
> the branch dependency and patches later.

I am not sure what you mean here in terms of the ordering for the
patches. I'm attaching several patches, and the first three patches
adapt your patch series to also cover 375 and 38x, assuming the pinctrl
support for 375 and 38x is merged before your patch series.

With these patches, I have 


> Patches 1-3 first deal with the way we handle unnamed "generic" mpp
> controls. Patch 1 consolidates the per-control allocation of name buffers
> to counting unnamed controls first and then allocate a global name buffer
> for all those controls. Patch 2 then removes the now obsolete per-control
> allocation of name buffers. Patch 3 then makes the common driver to
> identify "generic" mpp controls by an empty name and adds some valuable
> comments about that special treatment.

I must say I dislike quite a bit this unnamed mpp controls mechanism.
Why isn't the name statically defined in the source code by the
MPP_MODE macro, which already takes as first argument the pin number?

All the calculation of the buffer size, generating the names and so on,
looks like a lot of unnecessary code to me. But well, this unnamed
thing was already here, so I'm not saying your patch series should do
anything about it.

> Patch 4 removes passing struct mvebu_mpp_ctrl to the special callback
> as the only relevant information in that struct for the callback is the
> pin number which is passed directly instead.
> 
> Patches 5-9 then add some global defines and provide SoC specific
> callbacks even for the "generic" mpp controls. This allows Patch 10 to
> move resource allocation to SoC specific drivers and remove the common
> generic callbacks in Patch 11.

This is definitely good, but I'm wondering why the core cannot provide
helper functions for the generic case where we have 4 bits per pin in
contiguous registers. This would avoid duplicating the helper function
six times (you have four in your patch series, and we'll need two more
for A375 and A38x).

I've also attached other patches:

 * One patch that fixes your Armada XP handling, which missed the
   mv78230 and mv78260 cases (PATCH 4)

 * One patch that removes MPP_REG_CTRL (PATCH 5)

 * One patch that adjusts a comment in the code that was no longer true
   (PATCH 6)

Feel free to squash these patches into the appropriate patches.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-pinctrl-mvebu-armada-375-provide-generic-mpp-callbac.patch
Type: text/x-patch
Size: 1659 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140213/9f210261/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-pinctrl-mvebu-armada-38x-provide-generic-mpp-callbac.patch
Type: text/x-patch
Size: 1604 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140213/9f210261/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-fixup-pinctrl-mvebu-move-resource-allocation-to-SoC-.patch
Type: text/x-patch
Size: 2639 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140213/9f210261/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-fixup-pinctrl-mvebu-move-resource-allocation-to-SoC-.patch
Type: text/x-patch
Size: 1255 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140213/9f210261/attachment-0003.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0005-pinctrl-mvebu-remove-MPP_REG_CTRL-macro.patch
Type: text/x-patch
Size: 1299 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140213/9f210261/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0006-pinctrl-mvebu-update-comment-about-mvebu_mpp_ctrl.patch
Type: text/x-patch
Size: 1293 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140213/9f210261/attachment-0005.bin>
