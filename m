From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 15 Jun 2016 20:46:28 +0200
Subject: [PATCH] Revert "gpio: bail out silently on NULL descriptors"
In-Reply-To: <1466014954-17956-1-git-send-email-hdegoede@redhat.com>
References: <1466014954-17956-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160615184628.GA5144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 15, 2016 at 08:22:34PM +0200, Hans de Goede wrote:
> This reverts commit 54d77198fdfb("gpio: bail out silently on NULL
> descriptors").
> 
> This commit causes the following code to fail:
> 
> gpio_desc = devm_gpiod_get_optional(dev, ...);
> gpio_irq  = gpiod_to_irq(gpio_desc);
> if (gpio_irq >= 0) {
> 	ret = devm_request_irq(dev, gpio_irq, ...);
> 
> And now ret is an error causing the probe function in question to bail.
> 
> The problem here is that gpiod_to_irq now returns 0 for a NULL
> gpio_desc while 0 is a valid irq-nr. Also see:
> commit 4c37ce8608a8("gpio: make gpiod_to_irq() return negative for NO_IRQ")
> which specifically avoids returning 0.

0 is not a valid interrupt number.

irq_find_mapping returns 0 in case of an error:
http://lxr.free-electrons.com/source/kernel/irq/irqdomain.c#L657

and see that mail from Linus:
http://yarchive.net/comp/linux/zero.html

"
(On a PC, hardware irq 0 is a real irq too, but it's a _special_ irq, and
it is set up by architecture-specific code. So as far as the generic
kernel and all devices are concerned, "!dev->irq" means that the irq
doesn't exist or hasn't been mapped for that device yet).
"

The proper way to solve this is to fix the driver, like Quentin did in
that patch:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/435881.html

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160615/f23634f1/attachment.sig>
