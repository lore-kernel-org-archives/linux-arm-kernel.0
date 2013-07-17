From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 17 Jul 2013 20:30:14 +0200
Subject: DT binding review for Armada display subsystem
In-Reply-To: <CAMLZHHSFW9o280yTURrBnvrEGWFi-a7Q2yQWsCh7X5kEWbZNyw@mail.gmail.com>
References: <20130712164428.AC3D2FAAE9@dev.laptop.org>
 <CAMLZHHRvWFrxxjr0sF0NRqvz+K1wB9Mb_OGG-8tx36A2rk-SNQ@mail.gmail.com>
 <20130715210900.GT14452@pengutronix.de>
 <CAMLZHHSFW9o280yTURrBnvrEGWFi-a7Q2yQWsCh7X5kEWbZNyw@mail.gmail.com>
Message-ID: <20130717203014.339cd37c@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Jul 2013 11:50:11 -0600
Daniel Drake <dsd@laptop.org> wrote:

> I am now facing a problem with i2c/TDA998x which Russell already noted:
> 
> http://lists.freedesktop.org/archives/dri-devel/2013-June/039632.html
>    What *can't* be done without a rewrite of the DRM slave encoder backend
>    is to have the TDA998x I2C device provided by DT.  There are mumblings
>    about redoing the slave encoder API, hopefully this will be fixed there.
> 
> This is because the existing DRM/encoder system works something like this:
> 1. i2c driver (e.g. tda998x_drv) registers as an i2c_driver via
> drm_i2c_encoder_register()
> 2. The drm driver (i.e. armada) later has to know that it is expecting
> a tda998x instance. It calls drm_i2c_encoder_init() to set this up.
> 
> drm_i2c_encoder init requires:
>  1. The i2c_adapter in question. In a DT world, we could get this from
> finding the parent node of the tda998x node (this is the i2c bus
> master), and then using i2c_for_each_dev to find the first i2c adapter
> instance that has the same of_node.
>  2. i2c_board_info - basically the address of the device on the i2c
> bus. This is basically the way of instantiating i2c devices from
> platform data. Not the DT way :(
> 
> In a DT world the i2c driver would be instantiated from a node in the
> DT, which already includes the info that would come in i2c_board_info.
> Then later it would have to be linked to a DRM slave/encoder, perhaps
> when the DRM device finds the of_node corresponding to it.
> 
> So I think the next step is fixing up DRM, as Russell hinted. Unless
> someone sees another acceptable option that doesn't break our DT
> design.

Hi Daniel,

I don't see the problem with the TDA998x.

Indeed, it needs some enhancement to handle the DT, but also, the
function drm_i2c_encoder_init() is not usable in the DT case (this
function loads the module, while the module must be loaded by the DT
for it gets all parameters - i2c address and irq).

Here is the simple solution I use:

- the tda998x is declared in the DT, so the module is loaded at system
  startup time.

- its probe function is void.

- when the connector of the drm driver scans the DT, it finds the
  phandle to the tda998x.

- if / after the tda998x is loaded, the connector calls the function
  encoder_init() of the tda998x (and also increment the reference
  counter of the tda998x module to avoid this last one to be unloaded).

- the function encoder_init() of the tda998x scans the DT and it has all
  elements to run.

This working is compatible with the ticlcd driver: calling
drm_i2c_encoder_init() just prevents the tda998x to use the irq (the
i2c address is hard coded, the display connect/disconnect event is
detected by polling and reading the EDID is synchronous).

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
