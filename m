From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Tue, 23 Sep 2014 23:08:51 +0800
Subject: [PATCH v2 4/4] ARM: dts: mt8135: Add pinctrl node for mt8135.
In-Reply-To: <CAGb2v67F_3CCA2LA887X4TbewUcFj+bXzq912x6t5K4t2X_9mA@mail.gmail.com>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411443545-24951-5-git-send-email-srv_hongzhou.yang@mediatek.com>
 <2770365.r419rjIAOU@wuerfel> <1411480694.21299.18.camel@mtksdaap41>
 <CAGb2v67F_3CCA2LA887X4TbewUcFj+bXzq912x6t5K4t2X_9mA@mail.gmail.com>
Message-ID: <1411484931.21299.45.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-09-23 at 22:16 +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Tue, Sep 23, 2014 at 9:58 PM, Joe.C <srv_yingjoe.chen@mediatek.com> wrote:
> > On Tue, 2014-09-23 at 15:03 +0200, Arnd Bergmann wrote:
> >> On Tuesday 23 September 2014 11:39:05 Hongzhou. Yang wrote:
> >> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_GPIO0 (MT_PIN_NO(0) | 0)
> >> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_MSDC0_DAT7 (MT_PIN_NO(0) | 1)
> >> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_EINT49 (MT_PIN_NO(0) | 2)
> >> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_I2SOUT_DAT (MT_PIN_NO(0) | 3)
> >> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_DAC_DAT_OUT (MT_PIN_NO(0) | 4)
> >> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_PCM1_DO (MT_PIN_NO(0) | 5)
> >> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_SPI1_MO (MT_PIN_NO(0) | 6)
> >> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_NALE (MT_PIN_NO(0) | 7)
> >> > +
> >>
> >> This list looks like it just describes the hardware, I think it would
> >> be better to put the values directly into the DT, rather than
> >> using such macros.
> >
> > Hi,
> >
> > Thanks for review.
> > The intend for these macros is helpin pinctrl user to write DT node.
> > With these macro, we could write like this for i2c0:
> >
> > mediatek,pinfunc = <MT8135_PIN_100_SDA0__FUNC_SDA0
> >                         MT8135_PIN_101_SCL0__FUNC_SCL0>;
> >
> > We feel this is less error prone and easier to write than this:
> >
> > mediatek,pinfunc = <MT_PIN_FUNC(100, 1) MT_PIN_FUNC(101, 1)>
> 
> 
> Since you've already imposed the following limit in the DT bindings:
> 
>   The mediatek,pinfunc can be either a single value or an array.
>   If it is an array, that means all pins use same config in this node.
> 
> Maybe you could split the bindings into
> 
>   mediatek,pins = <1 2 3 4>;
>   mediatek,func = <1>;  (or some macro)
> 
> Or better yet, since you've already defined all the function names
> in the pinctrl driver, you could just match by name for the functions.
> That makes it very verbose and explicit about what you specify.
> 
> That's how we do it for sunxi anyway. Of course we have all the pin
> function documentation open, so users and reviewers alike can double
> check. Just a suggestion. :)
> 
> 
> Cheers
> ChenYu

Actually, this is exactly what we do in our first version(matching names
and use separate pins/func). That's why the source code and
pinctrl-mtk-mt8135.h are very simlar to sunxi one (Thanks :))

But we think it might worth to reduce string mathching at boot time,
that's why we changed to use integer + macro in this version.

Unfortunately, we still can't release documents openly now. I hope we
could change that someday.

Joe.C
