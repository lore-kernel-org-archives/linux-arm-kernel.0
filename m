From: dsd@laptop.org (Daniel Drake)
Date: Mon, 15 Jul 2013 14:23:30 -0600
Subject: DT binding review for Armada display subsystem
In-Reply-To: <20130712164428.AC3D2FAAE9@dev.laptop.org>
References: <20130712164428.AC3D2FAAE9@dev.laptop.org>
Message-ID: <CAMLZHHRvWFrxxjr0sF0NRqvz+K1wB9Mb_OGG-8tx36A2rk-SNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 10:44 AM, Daniel Drake <dsd@laptop.org> wrote:
> Based on the outcomes of the "Best practice device tree design for display
> subsystems" discussion I have drafted a DT binding. Comments much appreciated.
>
> At a high level, it uses a "super node" as something for the driver to bind
> to, needed because there is no clear one device that controls all the
> others, and also to distinguish between the Armada 510 possible use cases
> of having one video card with two outputs, or two independent video cards.
> It uses node-to-node linking beyond that point, V4L2 style.

As this hasn't been shot down very far, I've started to implement the
driver side of this binding. I have already run into a couple of
little problems.

First, interrupts. In the dt binding, each "lcd controller" node
defines which interrupt it listens to, and in the armada 510 case
there are indeed 2 interrupts (47 and 46, one for each LCD
controller). And remember that the drm driver itself binds to the
super-node.

Looking at drm_irq_install(), it looks like DRM only supports 1
interrupt line per drm_device. As we have no known users who will want
these two LCD controllers represented as 2 CRTCs on 1 DRM device
(which would require management of 2 interrupt lines), I figured this
might be a reason to ignore that use case for now (from the coding
standpoint), meaning that in all cases we are left with each DRM
device having 1 CRTC, corresponding to 1 LCD controller, which has
exactly 1 interrupt line.

That still doesn't solve the problem though. drm_irq_install calls
into drm_platform to figure out which IRQ number to use, and that code
looks at the platform_device (i.e. super node). In this case we don't
have the irq info there, we have it in the "lcd controller" node.

Do I invent our own "DRM bus" implementation so that we can override
get_irq()? Start to standardise our DT design as a generic drm_dt.c
bus implementation? Any thoughts?


Secondly, devm. I understand from the "best practices" thread that we
want to have exactly one platform_device which corresponds to the
"super node", and all of the individual display controller components
will be represented by DT nodes but *without* their own
platform_device. As we now put things (clocks, interrupts) into DT
nodes that don't have a corresponding platform_device, we lose the
ability to use devm. Russell wasn't too pleased last time I posted a
patch moving away from devm, admittedly last time the patch was bad
and it wasn't necessary, but this time it looks like it might be.


Finally, just curious, do we still want to support non-DT platform
data type setups on this driver? That adds a bit of coding effort. Not
a problem, just wanted to check.

Daniel
