From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 22 Dec 2011 12:13:05 +0200
Subject: [PATCH] OMAP3: hwmod_data: add HWMOD_INIT_NO_RESET flag for
 dss_dispc
In-Reply-To: <1324515653-17287-1-git-send-email-yanok@emcraft.com>
References: <1324515653-17287-1-git-send-email-yanok@emcraft.com>
Message-ID: <1324548785.13282.10.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-12-22 at 02:00 +0100, Ilya Yanok wrote:
> Resetting DISPC when a DISPC output is enabled causes the DSS to go into
> an inconsistent state.
> 
> commit b923d40dd4211c4ef7d4efa2bd81b7ca1d8744c1
> Author: Archit Taneja <archit@ti.com>
> Date:   Thu Oct 6 18:04:08 2011 -0600
> 
>     ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if display is
> enabled in bootloader
> 
> tries to deal with this problem by checking if display is enabled and
> disabling it before doing reset.
> 
> But in my setup dss_dispc is resetted from omap_hwmod_setup_all function
> _before_ calling omap_dss_reset. So when dispc_disable_outputs is
> executed dispc is already reset and nothing happens.

Hmm, why is that? You don't have the dss hwmod before dispc in the list
of hwmods? The code presumes that dss hwmod is handled first.

> This patch and HWMOD_INIT_NO_RESET flags to dss_dispc hwmod thus leaving
> DISPC untouched so that omap_dss_reset can take care of it.

omap_dss_reset() doesn't reset dispc, so this will leave dispc
un-reseted.

The idea of the current code is to do the reset similarly on all OMAPs.
The sequence should be:

- omap_dss_reset(), which disables dispc outputs and manually resets dss
registers.
- then the rest of the dss modules reset themselves normally, using the
softreset bit.

Your patch would break that.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111222/f0e484eb/attachment.sig>
