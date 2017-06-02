From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Jun 2017 21:18:47 +0200
Subject: [PATCH 02/19] drm/sun4i: add components in two passes with
 encoders added in second pass
In-Reply-To: <20170602101024.18940-3-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
 <20170602101024.18940-3-wens@csie.org>
Message-ID: <20170602191847.6wuz2pthqtc44xxb@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 06:10:07PM +0800, Chen-Yu Tsai wrote:
> The encoder drivers use drm_of_find_possible_crtcs to get upstream
> crtcs from the device tree using of_graph. For the results to be
> correct, encoders must be probed/bound after _all_ crtcs have been
> created. The existing code uses a depth first recursive traversal
> of the of_graph, which means the encoders downstream of the TCON
> get add right after the first TCON. The second TCON or CRTC will
> never be properly associated with encoders connected to it.
> 
> Other platforms, such as Rockchip, deal with this by probing all
> crtcs first, then all subsequent components. This is easy to do
> since the crtcs correspond to just one device node, and are the
> first nodes in the pipeline.
> 
> However with Allwinner SoCs, the function of the CRTC is split between
> the display backend (DE 1.0) or mixer (DE 2.0), which does scan-out
> and compositing, and the TCON, which generating the display timing
> signals. Further complicating the process, there may be a Dynamic Range
> Controller between the backend and the TCON. Also, the backend is
> preceded by the frontend, with a Display Enhancement Unit possibly
> in between.
> 
> One solution would be, instead of a depth first traversal of the
> component of_graph, we do a breadth first traversal, so that components
> at the same depth are grouped together. This however requires us to
> implement extra code for a queue structure that is only used here.
> 
> Instead, since we can identify TCON device nodes, and since the
> component system can gracefully deal with duplicate entries, we can add
> components in two passes, using the existing recursive depth code. The
> first pass stops right after the TCON is added. The second pass will
> re-add all components up to the TCON, but these will be skipped since
> they will have already been bound with the entries from the first pass.
> The encoders added in the second pass will be the last entries in the
> list.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

This commit log is great. So great actually that it should be a
comment in the code ;)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170602/7654653d/attachment.sig>
