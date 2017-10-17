From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 16:29:49 +0200
Subject: [PATCH 01/23] drm/sun4i: Implement endpoint parsing using kfifo
In-Reply-To: <CAGb2v65zJh1Fqqxo22RTL8TQ90FrxywVo0J_bhD04JYHnVjdhg@mail.gmail.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <4ecb323e787918208f6a5d9f0ebba12c62583c98.1508231063.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65zJh1Fqqxo22RTL8TQ90FrxywVo0J_bhD04JYHnVjdhg@mail.gmail.com>
Message-ID: <20171017142949.lkefs4m7majjh4ey@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 05:19:04PM +0800, Chen-Yu Tsai wrote:
> On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The commit da82b8785eeb ("drm/sun4i: add components in breadth first
> > traversal order") implemented a breadth first traversal of our device tree
> > nodes graph. However, it was relying on the kernel linked lists, and those
> > are not really safe for addition.
> >
> > Indeed, in a single pipeline stage, your first stage (ie, the mixer or
> > fronted) will be queued, and it will be the final iteration of that list as
> > far as list_for_each_entry_safe is concerned. Then, during that final
> > iteration, we'll queue another element (the TCON or the backend) that
> > list_for_each_entry_safe will not account for, and we will leave the loop
> > without having iterated over all the elements. And since we won't have
> > built our components list properly, the DRM driver will be left
> > non-functional.
> >
> > We can instead use a kfifo to queue and enqueue components in-order, as was
> > the original intention. This also has the benefit of removing any dynamic
> > allocation, making the error handling path simpler too. The only thing
> > we're losing is the ability to tell whether an element has already been
> > queued, but that was only needed to remove spurious logs, and therefore
> > purely cosmetic.
> >
> > This means that this commit effectively reverses e8afb7b67fba ("drm/sun4i:
> > don't add components that are already in the queue").
> >
> > Fixes: da82b8785eeb ("drm/sun4i: add components in breadth first traversal order")
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_drv.c | 71 +++++---------------------------
> >  1 file changed, 13 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > index b5879d4620d8..a27efad9bc76 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > @@ -11,6 +11,7 @@
> >   */
> >
> >  #include <linux/component.h>
> > +#include <linux/kfifo.h>
> >  #include <linux/of_graph.h>
> >  #include <linux/of_reserved_mem.h>
> >
> > @@ -222,29 +223,15 @@ static int compare_of(struct device *dev, void *data)
> >   * matching system handles this for us.
> >   */
> >  struct endpoint_list {
> > -       struct device_node *node;
> > -       struct list_head list;
> > +       DECLARE_KFIFO(fifo, struct device_node *, 16);
> >  };
> 
> Is there any reason to keep using struct endpoint_list, other than
> to avoid using kfifo in function parameter lists?

It appears that you can't just pass a kifo pointer as a function
argument, so the only two remaining solutions were to have a global
pointer or embed it in a structure. It just seems like the best
solution.

> 
> Otherwise the rest of the code looks sound.
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171017/1013eea8/attachment-0001.sig>
