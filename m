From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Mon, 5 Mar 2018 09:23:08 +0800
Subject: [PATCH v2 4/4] pintcrl: support bias-disable of generic and
 special pins simultaneously
In-Reply-To: <1519890183.8089.114.camel@mtkswgap22>
References: <1519634042-12063-1-git-send-email-zhiyong.tao@mediatek.com>
 <1519634042-12063-5-git-send-email-zhiyong.tao@mediatek.com>
 <1519803217.8089.31.camel@mtkswgap22> <1519804157.23198.9.camel@mhfsdcap03>
 <1519876072.23198.17.camel@mhfsdcap03>
 <1519890183.8089.114.camel@mtkswgap22>
Message-ID: <1520212988.23198.22.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-03-01 at 15:43 +0800, Sean Wang wrote:
> On Thu, 2018-03-01 at 11:47 +0800, Zhiyong Tao wrote:
> > On Wed, 2018-02-28 at 15:49 +0800, Zhiyong Tao wrote:
> > > On Wed, 2018-02-28 at 15:33 +0800, Sean Wang wrote:
> > > > On Mon, 2018-02-26 at 16:34 +0800, Zhiyong Tao wrote:
> > > > > For generic pins, parameter "arg" is 0 or 1.
> > > > > For special pins, bias-disable is set by R0R1,
> > > > > so we need transmited "00" to set bias-disable
> > > > > When we set "bias-disable" as high-z property,
> > > > > the parameter should be "MTK_PUPD_SET_R1R0_00".
> > > > > 
> > > > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > > > ---
> > > > >  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 13 +++++++++++--
> > > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > > > > index 3cf384f..e88ba04 100644
> > > > > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > > > > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > > > > @@ -301,8 +301,17 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
> > > > >  	 * resistor bit, so we need this special handle.
> > > > >  	 */
> > > > >  	if (pctl->devdata->spec_pull_set) {
> > > > > -		ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl, pin),
> > > > > -			pin, pctl->devdata->port_align, isup, arg);
> > > > > +		if (enable) {
> > > > > +			ret = pctl->devdata->spec_pull_set(
> > > > > +				mtk_get_regmap(pctl, pin), pin,
> > > > > +				pctl->devdata->port_align, isup,
> > > > > +				arg);
> > > > > +		} else {
> > > > > +			ret = pctl->devdata->spec_pull_set(
> > > > > +				mtk_get_regmap(pctl, pin), pin,
> > > > > +				pctl->devdata->port_align, isup,
> > > > > +				MTK_PUPD_SET_R1R0_00);
> > > > > +		}
> > > > 
> > > > 
> > > > it looks like you can use as following snippet with reusing original
> > > > logic and less effort on maintaining these common code (?)
> > > ==> Thanks for your suggestion very much. It seems better.
> > > I will change it in v3.
> > 
> > ==>
> >  Hi sean,
> > 
> > we try it in our site. we can't change like this.
> > Because we will check "arg" after setting "arg = MTK_PUPD_SET_R1R0_00;".
> > following snippet which check "arg" value is o or 1. If it not, which
> > will print error. so we can't change like this.
> > /* For generic pull config, default arg value should be 0 or 1. */
> > if (arg != 0 && arg != 1) {
> > 	dev_err(pctl->dev, "invalid pull-up argument %d on pin %d .\n", arg,
> > pin);
> > 	return -EINVAL;
> > }
> > 
> > Thanks.
> 
> why not rewrite it with

==> Hi sean,
Thanks for your comments, we will try to do it. If it is ok, we will
modify it in v3.
> 
> @@ -301,8 +301,10 @@ static int mtk_pconf_set_pull_select(struct
> mtk_pinctrl *pctl,
>          * resistor bit, so we need this special handle.
>          */
>         if (pctl->devdata->spec_pull_set) {
> +               unsigned int r1r0 = enable ? arg : MTK_PUPD_SET_R1R0_00;
> +
>                 ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl,
> pin),
> -                       pin, pctl->devdata->port_align, isup, arg);
> +                       pin, pctl->devdata->port_align, isup, r1r0);
>                 if (!ret)
>                         return 0;
>         }
> 
> and also I appeared to find another bug in the original code when I had
> a close look at the code path, but it's not related to the patch: 
> 
> a special pin would still go through the code path to handle
> generic pin when the special pin uses an invalid argument.
> 
> It looks like err-code from pctl->devdata->spec_pull_set cannot be
> used directly to judge its pin type. It's also possible to use it as an
> indication of the real failure during special pin is being set up.
> 
==>Hi sean,

The function seems ok. it is not related to the patch. We will think
about your comment. If there is better idea to modify the code flow. We
will change it in another patch.

Thanks.
> > > > 
> > > > 
> > > > if (pctl->devdata->spec_pull_set) {
> > > > 	+ if (!enable)
> > > > 	+ 	arg = MTK_PUPD_SET_R1R0_00;
> > > > 
> > > > 	ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl, pin),
> > > > 		pin, pctl->devdata->port_align, isup, arg);
> > > > 
> > > > 
> > > > Also, it's better to add more comments to such kind of special path for
> > > > allowing future SoCs to follow and extend more easily.
> > > 
> > > ==> Thanks for your suggestion very much. I will add more comments here.
> > > > 
> > > > >  		if (!ret)
> > > > >  			return 0;
> > > > >  	}
> > > > 
> > > > 
> > > 
> > 
> > 
> 
> 
