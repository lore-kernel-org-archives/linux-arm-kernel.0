From: balbi@ti.com (Felipe Balbi)
Date: Wed, 6 Mar 2013 10:10:44 +0200
Subject: [V8 PATCH 01/16] usb: phy: mv_usb2: add PHY driver for marvell
 usb2 controller
In-Reply-To: <CADApbeg1KfW4xW=YQcqOwgyaOfes=Nu=9pmtxWgazW23vYS9yw@mail.gmail.com>
References: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
 <1361419646-9052-2-git-send-email-chao.xie@marvell.com>
 <20130304142143.GG3397@arwen.pp.htv.fi>
 <CADApbeigW=1fQtUZmLMX8H2+0RiiBFjcSBNojQRSZbCa_ORZVw@mail.gmail.com>
 <20130305110457.GF7899@arwen.pp.htv.fi>
 <CADApbeg1KfW4xW=YQcqOwgyaOfes=Nu=9pmtxWgazW23vYS9yw@mail.gmail.com>
Message-ID: <20130306081044.GD28587@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 06, 2013 at 10:11:41AM +0800, Chao Xie wrote:
> 3. For the revison register. It exists in some SOCes(pxa168), but for
> some SOCes, the register dispears(pxa910, armada610). These SOCes are
> developed by different desgin teams, and it need to be enhanced, but
> for current products i have to use the device_id to detect the PHY
> controller.

fair enough, make sure to add a comment to the driver about this so
grumpy maintainers stop complaining ;-)

> 4. For the mutex and refcount. The "USB controller" includes two
> blocks - the udc and ehci. In fact they will not be used at same time,
> but for some SOCes it duplicates the ehci block. It means that the
> SOCes have two or more ehci blocks. The added ehci blocks depend on
> the PHY to be initialized, and they can be used at same time as the
> "USB controller". That is the reason i add mutex and refcount for phy
> driver.

alright, let's add refcounting to the generic PHY layer then.

> 5. For the clock name. Can you describe it in details? For clkdev, if
> it want to find the clock, it still depends on the dev_name and
> con_id.

right, the idea of clkdev is that you associate a clock provider with
its consumer by means of dev_name. Then you can fetch the clock from
driver with any name you want. Which means if you do you clkdev properly
you could:

clk_get(dev, "clk1");
clk_get(dev, "clk2");
...

and so on.

good luck

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130306/c75c0f9c/attachment.sig>
