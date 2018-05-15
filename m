From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 15 May 2018 13:17:11 +0200
Subject: [PATCH v2 4/4] ARM: PWM: add allwinner sun8i pwm support.
In-Reply-To: <CAJeuY7-Dz1u9J8GMu=OdzJ2cJUnE3wEobJoQz6RV-ibjBjoW4A@mail.gmail.com>
References: <20180225135308.GA14561@arx-s1>
 <20180226090038.etk5q4pd4rl5dvf6@flea.lan>
 <CAJeuY7-Dz1u9J8GMu=OdzJ2cJUnE3wEobJoQz6RV-ibjBjoW4A@mail.gmail.com>
Message-ID: <20180515111711.l2g4vgsal7yr6dbr@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 14, 2018 at 10:45:44PM +0800, Hao Zhang wrote:
> 2018-02-26 17:00 GMT+08:00 Maxime Ripard <maxime.ripard@bootlin.com>:
> > Thanks for respinning this serie. It looks mostly good, but you still
> > have a quite significant number of checkpatch (--strict) warnings that
> > you should address.
> 
> Thanks for reviews :) ,i'm sorry for that, it will be fixed next
> time.  and, besides, in what situation were the checkpatch warning
> can be ignore?

The only one that can be reasonably be ignored is the long line
warning, and only if complying to the limit would make it less easy to
understand.

> >
> > On Sun, Feb 25, 2018 at 09:53:08PM +0800, hao_zhang wrote:
> >> +#define CAPTURE_IRQ_ENABLE_REG       0x0010
> >> +#define CFIE(ch)     BIT(ch << 1 + 1)
> >> +#define CRIE(ch)     BIT(ch << 1)
> >
> > You should also put your argument between parentheses here (and in all
> > your other macros).
> 
> Do you mean like this ?
> #define CFIE(ch)     BIT((ch) << 1 + 1)
> #define CRIE(ch)     BIT((ch) << 1)

Yep, exactly. Otherwise, if you do something like CRIE(1 + 1), the
result will be BIT(1 + 1 << 1), which will expand to 3, instead of 4.

Also, CFIE looks a bit weird here, is it the offset that is
incremented, or the value? You should probably have parentheses to
make it explicit.

> >
> >> +static const u16 div_m_table[] = {
> >> +     1,
> >> +     2,
> >> +     4,
> >> +     8,
> >> +     16,
> >> +     32,
> >> +     64,
> >> +     128,
> >> +     256
> >> +};
> >
> > If this is just a power of two, you can use either the power of two /
> > ilog2 to switch back and forth, instead of using that table.
> 
> I think using table is more explicit and extended...

If you didn't have a simple mapping between the register values and
the divider value, then yeah, sure. But it's not the case here.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180515/23ba351d/attachment.sig>
