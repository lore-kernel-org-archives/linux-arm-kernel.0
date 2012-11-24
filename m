From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 24 Nov 2012 21:34:23 +0100
Subject: [PATCH v4 05/11] pwm: pwm-tiecap: pinctrl support
In-Reply-To: <87mwy8eb7w.fsf@dell.be.48ers.dk>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-6-git-send-email-avinashphilip@ti.com>
 <20121122205944.GC16716@avionic-0098.adnet.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E9EE991@DBDE01.ent.ti.com>
 <20121123105110.GA6884@avionic-0098.adnet.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E9EEAAA@DBDE01.ent.ti.com>
 <20121123111811.GA5072@avionic-0098.adnet.avionic-design.de>
 <87mwy8eb7w.fsf@dell.be.48ers.dk>
Message-ID: <20121124203423.GA26951@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 01:48:51PM +0100, Peter Korsgaard wrote:
> >>>>> "Thierry" == Thierry Reding <thierry.reding@avionic-design.de> writes:
> 
> Hi,
> 
>  Thierry> Everybody seems to be doing it with a warning, so I guess
>  Thierry> that's fine for now. I just find it strange that if you
>  Thierry> request the default pin group to be selected when in fact the
>  Thierry> hardware doesn't support pinctrl at all you shouldn't be
>  Thierry> getting an error either.
> 
> There's several different situations:
> 
> - Platform without pinctrl support
> - Platform with pinctrl support but no pinmux specified in dt for device
>   (E.G. pinmux setup in bootloader)
> - Pinmux specified in dt
> - Some kind of misconfiguration in dt
> 
> You could argue that devm_pinctrl_get_select_default() shouldn't return
> an error for the first situation, but how should it be able to know the
> difference between 2 and 4?

In case where the platform supports pinctrl but no pinmux is specified
for the device it should just assume that no pinmuxing is needed. That
sounds like the most logical behaviour to me. In those cases pinctrl
could just assume that the default has already been selected and not
return an error.

But you can't reasonably expect to cope with misconfigured DT content.
Heck, there's no way for you to even know if it is misconfigured.

That said, I'm not sure how much of an issue this really is. Pinmuxing
is only used for functions local to a given chip, right? So if an SoC
supports pinctrl and a given peripheral needs pinmuxing then we can
reasonably assume that your second case can't happen, can't we?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121124/7332c5fe/attachment.sig>
