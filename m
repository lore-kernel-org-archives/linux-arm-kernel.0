From: dsd@laptop.org (Daniel Drake)
Date: Wed, 17 Jul 2013 11:50:11 -0600
Subject: DT binding review for Armada display subsystem
In-Reply-To: <20130715210900.GT14452@pengutronix.de>
References: <20130712164428.AC3D2FAAE9@dev.laptop.org>
 <CAMLZHHRvWFrxxjr0sF0NRqvz+K1wB9Mb_OGG-8tx36A2rk-SNQ@mail.gmail.com>
 <20130715210900.GT14452@pengutronix.de>
Message-ID: <CAMLZHHSFW9o280yTURrBnvrEGWFi-a7Q2yQWsCh7X5kEWbZNyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 3:09 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> You don't have to call drm_irq_install(). Both the exynos and i.MX
> driver do without it and at least the i.MX driver uses multiple irqs per
> drm_device.

Good point, thanks. That unblocks that item.

>> Secondly, devm. I understand from the "best practices" thread that we
>> want to have exactly one platform_device which corresponds to the
>> "super node", and all of the individual display controller components
>> will be represented by DT nodes but *without* their own
>> platform_device.
>
> A super node approach doesn't mean that there's only one platform
> device. You can still have a platform device for each component.

Yes. As noted, this was simply a preference that seemed to emerge in
the previous discussion. If in practice it causes too many headaches,
maybe we will change our minds. For now devm is the only issue I have
seen; I am avoiding devm where it is no longer possible under this
design.

The goal of getting this driver working properly on OLPC XO seems to
be a twisty path that presents a new issue at every turn. In the above
work I am trying to first implement the DT binding for Armada
510/cubox, as that is what the current code is aimed at.

I am now facing a problem with i2c/TDA998x which Russell already noted:

http://lists.freedesktop.org/archives/dri-devel/2013-June/039632.html
   What *can't* be done without a rewrite of the DRM slave encoder backend
   is to have the TDA998x I2C device provided by DT.  There are mumblings
   about redoing the slave encoder API, hopefully this will be fixed there.

This is because the existing DRM/encoder system works something like this:
1. i2c driver (e.g. tda998x_drv) registers as an i2c_driver via
drm_i2c_encoder_register()
2. The drm driver (i.e. armada) later has to know that it is expecting
a tda998x instance. It calls drm_i2c_encoder_init() to set this up.

drm_i2c_encoder init requires:
 1. The i2c_adapter in question. In a DT world, we could get this from
finding the parent node of the tda998x node (this is the i2c bus
master), and then using i2c_for_each_dev to find the first i2c adapter
instance that has the same of_node.
 2. i2c_board_info - basically the address of the device on the i2c
bus. This is basically the way of instantiating i2c devices from
platform data. Not the DT way :(

In a DT world the i2c driver would be instantiated from a node in the
DT, which already includes the info that would come in i2c_board_info.
Then later it would have to be linked to a DRM slave/encoder, perhaps
when the DRM device finds the of_node corresponding to it.

So I think the next step is fixing up DRM, as Russell hinted. Unless
someone sees another acceptable option that doesn't break our DT
design.

I am going away for 3-4 weeks now, so you won't be hearing for me for
a while. Just in case someone else wants to pick up the task in the
mean time, here is my work in progress. I'm still reading and
learning, so please don't do any detailed reviews yet :)

http://dev.laptop.org/~dsd/20130717/0001-dove-clk-dt-wip.patch

It includes the previous clock selection patch as this stuff is quite
closely bound with DT support.

Thanks
Daniel
