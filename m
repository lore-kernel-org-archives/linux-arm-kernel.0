From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 May 2014 11:39:06 +0200
Subject: [PATCH 03/11] pinctrl: sunxi: Move setting of mux to irq type
 from unmask to set_type
In-Reply-To: <5384544F.6000806@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-4-git-send-email-hdegoede@redhat.com>
 <20140527080952.GC4730@lukather> <5384544F.6000806@redhat.com>
Message-ID: <20140528093906.GO4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 11:01:03AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 05/27/2014 10:09 AM, Maxime Ripard wrote:
> > On Mon, May 26, 2014 at 09:47:58AM +0200, Hans de Goede wrote:
> >> With level triggered interrupt mask / unmask will get called for each
> >> interrupt, doing the somewhat expensive mux setting on each unmask thus is
> >> not a good idea. Instead move it to the set_type callback, which is typically
> >> done only once for each irq.
> > 
> > *This* is the bad idea. Nothing prevents you from calling
> > gpio_get_value whenever you just got your interrupt, that will change
> > the muxing, and never change it back, effectively breaking the
> > interrupts.
> 
> Hmm, interesting point, but your assuming 2 things which are both not true:
> 
> 1) That calling gpiod_get_value changes the muxing, which is not true, all
> gpiod_get_value variants end up in drivers/gpio/gpiolib.c _gpiod_get_raw_value()
> which does no such thing

Somehow I was convinced it was the case, but yeah, it doesn't really
make much sense, especially since you can get the value of an output,
without wanting to change it to input.

> 
> 2) That unmask will always get called after the gpio_get_value to restore the mux
> setting for us, which is not guaranteed at all. Before this patch set pinctrl-sunxi.c
> was using handle_simple_irq which does not mask / unmask at all.
> 
> And even with an irq-handler which masks / unmasks, what if the irq wakes up
> a thread and that thread then does the gpio_get_value ?
> 
> Note this is *exactly* what e.g. the mmc gpio card-detect code does, it uses
> a thread to read the gpio for debouncing.
> 
> Luckily 2. is not a problem, since 1. means that the mux won't get changed at all
> so we don't need to change it back.

Ok.

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/f07876e3/attachment.sig>
