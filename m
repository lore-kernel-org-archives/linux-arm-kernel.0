From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Aug 2016 07:54:50 +0200
Subject: [PATCH -next] ASoC: sun4i-codec: Fix error return code in
 sun4i_codec_probe()
In-Reply-To: <d48eceb4-c26d-3b3c-8577-1ba19a04b040@gmail.com>
References: <1470836554-11569-1-git-send-email-weiyj.lk@gmail.com>
 <CAGb2v67cVXWtM=AzeFcftnajSs=+C6F12P_EvnXHB=oKsAm5Cw@mail.gmail.com>
 <d48eceb4-c26d-3b3c-8577-1ba19a04b040@gmail.com>
Message-ID: <20160822055450.GA21741@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 11, 2016 at 10:15:27PM +0800, Wei Yongjun wrote:
> Hi
> 
> On 08/10/2016 10:04 PM, Chen-Yu Tsai wrote:
> > On Wed, Aug 10, 2016 at 9:42 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> >> Fix to return error code -ENOMEM instead of 0 when create card
> >> failed, as done elsewhere in this function.
> >>
> >> Fixes: 45fb6b6f2aa3 ("ASoC: sunxi: add support for the on-chip
> >> codec on early Allwinner SoCs")
> >> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> >> ---
> >>  sound/soc/sunxi/sun4i-codec.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> >> index 0e19c50..e741659 100644
> >> --- a/sound/soc/sunxi/sun4i-codec.c
> >> +++ b/sound/soc/sunxi/sun4i-codec.c
> >> @@ -846,6 +846,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
> >>         card = sun4i_codec_create_card(&pdev->dev);
> >>         if (!card) {
> >>                 dev_err(&pdev->dev, "Failed to create our card\n");
> >> +               ret = -ENOMEM;
> >>                 goto err_unregister_codec;
> >>         }
> >>
> > This works, though it might be better to fix the create_card function and
> > any custom functions called in there to pass back a proper error value.
> >
> Since sun4i_codec_create_card() can only failed when kmalloc() return NULL, so
> still need to change sun4i_codec_create_card()?

Yes, please do. It's better to return whatever the function was
returning. That was, if we add a new error code, we don't have to
rework the code over and over again.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/10d1397b/attachment.sig>
