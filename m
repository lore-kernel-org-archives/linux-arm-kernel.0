From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 25 Jun 2018 19:32:04 +0200
Subject: [PATCH 2/2] usb: core: phy: fix return value checking about
 devm_of_phy_get_by_index()
In-Reply-To: <1529908621.32173.27.camel@mhfsdcap03>
References: <4c338a129ab14ab41949da5e3c21aed0d77dff8d.1529647619.git.chunfeng.yun@mediatek.com>
 <644d00edd2932c1a0d0a1bf368dd25427d1d9f64.1529647619.git.chunfeng.yun@mediatek.com>
 <CAFBinCBS+fpfx6jaaqD=kqFuMF6ko8GikbV1ZVwgbDh-Sn8T8w@mail.gmail.com>
 <1529908621.32173.27.camel@mhfsdcap03>
Message-ID: <CAFBinCDuGd-R1OR6h1UTTsWm2XNJC_f8iREgdE8fQQv1ph9hpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chunfeng,

On Mon, Jun 25, 2018 at 8:37 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Sun, 2018-06-24 at 20:00 +0200, Martin Blumenstingl wrote:
> > Hello Chunfeng,
> >
> > thank you for the patch!
> >
> > On Fri, Jun 22, 2018 at 8:33 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > >
> > > 1. use IS_ERR() but not IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
> > >     never return NULL value;
> > ACK - good catch!
> >
> > > 2. devm_of_phy_get_by_index() should not fail for a valid index
> > I have learned that the PHY framework can return -ENODEV if the PHY is:
> > 1. supposed to be handled by the legacy USB PHY framework
> > 2. the PHY node is disabled in devicetree
> A little confused, we can avoid this error by not using a disabled or
> "usb-nop-xceiv" phy in host node.
I think that would be the mid or long term goal

> If ignore error of -ENODEV, we will also skip an error case which we
> don't want it happen.
as far as I understand the problem is that there are .dts files out
there which specify "usb-nop-xceiv" in the "phys" property, see [0]
(there might be even some more out-of-tree cases)
so I think the -ENODEV check can only be removed once nothing uses
"usb-nop-xceiv" anymore


Regards
Martin


[0] https://patchwork.kernel.org/patch/10160181/
