From: geoff@infradead.org (Geoff Levand)
Date: Wed, 27 Jul 2016 11:11:47 -0700
Subject: [PATCH v1 2/4] kexec: Add common device tree routines
In-Reply-To: <20160722071924.GQ20774@linaro.org>
References: <cover.1468970114.git.geoff@infradead.org>
 <8ed220ee82b4819a9107a6ce0f020497d1688c7b.1468970114.git.geoff@infradead.org>
 <20160722071924.GQ20774@linaro.org>
Message-ID: <1469643107.2889.65.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2016-07-22 at 16:19 +0900, AKASHI Takahiro wrote:
> On Tue, Jul 19, 2016 at 11:28:13PM +0000, Geoff Levand wrote:
> > --- /dev/null
> > +++ b/kexec/dt-ops.c
> > +int dtb_set_property(char **dtb, off_t *dtb_size, const char *node,
> > +> > 	> > const char *prop, const void *value, int value_len)
> > +{
> > +> > 	> > int result;
> > +> > 	> > int nodeoffset;
> > +> > 	> > void *new_dtb;
> > +> > 	> > int new_size;
> > +
> > +> > 	> > value_len = FDT_TAGALIGN(value_len);
> > +
> > +> > 	> > new_size = FDT_TAGALIGN(*dtb_size + fdt_node_len(node)
> > +> > 	> > 	> > + fdt_prop_len(prop, value_len));
> 
> As James pointed out before, this will increase the size of dtb
> if kexec is executed repeatedly.

I will look into this later, as it will take some time to
do, and I don't think it should hold up merge of the arm64
support.

> > +> > 	> > new_dtb = malloc(new_size);
> > +
> > +> > 	> > if (!new_dtb) {
> > +> > 	> > 	> > dbgprintf("%s: malloc failed\n", __func__);
> > +> > 	> > 	> > return -ENOMEM;
> > +> > 	> > }
> > +
> > +> > 	> > result = fdt_open_into(*dtb, new_dtb, new_size);
> > +
> > +> > 	> > if (result) {
> > +> > 	> > 	> > dbgprintf("%s: fdt_open_into failed: %s\n", __func__,
> > +> > 	> > 	> > 	> > fdt_strerror(result));
> > +> > 	> > 	> > goto on_error;
> > +> > 	> > }
> > +
> > +> > 	> > nodeoffset = fdt_path_offset(new_dtb, node);
> > +> > 	
> > +> > 	> > if (nodeoffset == -FDT_ERR_NOTFOUND) {
> > +> > 	> > 	> > result = fdt_add_subnode(new_dtb, nodeoffset, node);
> > +
> > +> > 	> > 	> > if (result) {
> > +> > 	> > 	> > 	> > dbgprintf("%s: fdt_add_subnode failed: %s\n", __func__,
> > +> > 	> > 	> > 	> > 	> > fdt_strerror(result));
> > +> > 	> > 	> > 	> > goto on_error;
> > +> > 	> > 	> > }
> > +> > 	> > } else if (nodeoffset < 0) {
> > +> > 	> > 	> > dbgprintf("%s: fdt_path_offset failed: %s\n", __func__,
> > +> > 	> > 	> > 	> > fdt_strerror(nodeoffset));
> > +> > 	> > 	> > goto on_error;
> > +> > 	> > }
> > +
> > +> > 	> > result = fdt_setprop(new_dtb, nodeoffset, prop, value, value_len);
> > +
> > +> > 	> > if (result) {
> > +> > 	> > 	> > dbgprintf("%s: fdt_setprop failed: %s\n", __func__,
> > +> > 	> > 	> > 	> > fdt_strerror(result));
> > +> > 	> > 	> > goto on_error;
> > +> > 	> > }
> > +
> > +> > 	> > /*
> > +> > 	> >  * Can't call free on dtb since dtb may have been mmaped by
> > +> > 	> >  * slurp_file().
> > +> > 	> >  */
> > +
> > +> > 	> > *dtb = new_dtb;
> > +> > 	> > *dtb_size = new_size;
> 
> So you might better call fdt_pack(), which will set "totalsize" of
> the blob to an appropriate value.

I fixed this.  It is in my master branch now, and will post with v3.

Thanks for the review.

-Geoff
