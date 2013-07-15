From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Jul 2013 23:09:00 +0200
Subject: DT binding review for Armada display subsystem
In-Reply-To: <CAMLZHHRvWFrxxjr0sF0NRqvz+K1wB9Mb_OGG-8tx36A2rk-SNQ@mail.gmail.com>
References: <20130712164428.AC3D2FAAE9@dev.laptop.org>
 <CAMLZHHRvWFrxxjr0sF0NRqvz+K1wB9Mb_OGG-8tx36A2rk-SNQ@mail.gmail.com>
Message-ID: <20130715210900.GT14452@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 02:23:30PM -0600, Daniel Drake wrote:
> On Fri, Jul 12, 2013 at 10:44 AM, Daniel Drake <dsd@laptop.org> wrote:
> > Based on the outcomes of the "Best practice device tree design for display
> > subsystems" discussion I have drafted a DT binding. Comments much appreciated.
> >
> > At a high level, it uses a "super node" as something for the driver to bind
> > to, needed because there is no clear one device that controls all the
> > others, and also to distinguish between the Armada 510 possible use cases
> > of having one video card with two outputs, or two independent video cards.
> > It uses node-to-node linking beyond that point, V4L2 style.
> 
> As this hasn't been shot down very far, I've started to implement the
> driver side of this binding. I have already run into a couple of
> little problems.
> 
> First, interrupts. In the dt binding, each "lcd controller" node
> defines which interrupt it listens to, and in the armada 510 case
> there are indeed 2 interrupts (47 and 46, one for each LCD
> controller). And remember that the drm driver itself binds to the
> super-node.
> 
> Looking at drm_irq_install(), it looks like DRM only supports 1
> interrupt line per drm_device.

You don't have to call drm_irq_install(). Both the exynos and i.MX
driver do without it and at least the i.MX driver uses multiple irqs per
drm_device.

> 
> Secondly, devm. I understand from the "best practices" thread that we
> want to have exactly one platform_device which corresponds to the
> "super node", and all of the individual display controller components
> will be represented by DT nodes but *without* their own
> platform_device.

A super node approach doesn't mean that there's only one platform
device. You can still have a platform device for each component. The
super node should rather be seen as a node which contains phandles
to the different components..

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
