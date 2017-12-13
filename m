From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 13 Dec 2017 11:42:31 +0200
Subject: [PATCH v2 3/4] thermal: armada: add support for CP110
In-Reply-To: <874lovq9cx.fsf@free-electrons.com>
References: <f8c589337a4fb78852eadf15058e8f8d132d4dc0.1512299484.git.baruch@tkos.co.il>
 <d48c916a2502f9c75e9ea4ba41300e2ffbb254d8.1512299484.git.baruch@tkos.co.il>
 <20171211160932.692ba8be@xps13>
 <20171211152731.glkkes5errcxmsvz@sapphire.tkos.co.il>
 <87y3m9qjt2.fsf@free-electrons.com>
 <20171213083848.j5het742yavxvkkw@sapphire.tkos.co.il>
 <874lovq9cx.fsf@free-electrons.com>
Message-ID: <20171213094231.sk5fj6fxvpvik3i2@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Wed, Dec 13, 2017 at 10:13:02AM +0100, Gregory CLEMENT wrote:
>  On mer., d?c. 13 2017, Baruch Siach <baruch@tkos.co.il> wrote:

[...]

> > There are two separate issues here:
> >
> >   1. DT binding
> >
> >   2. init_sensor callback implementation
> >
> > We both agree on #1. The A38x and CP110 need separate compatible strings. In 
> > case we want to access the LSB control register on Armada 38x, we will need 
> > yet another compatible string (marvell,armada380-v2-thermal maybe?).
> 
> Actually, if it is _compatible_ then we will use the same compatible, ie
> "marvell,armadacp110-thermal"

Reusing the same compatible string for the same hardware peripheral in 
different SoCs is not a good idea. You often find out later that they are not 
actually the same.

But this point is moot. The A38x and CP110 thermal sensors are not the same. 
The overheat interrupt registers are in different offsets.

> > As for #2, I'm all for sharing as much code as possible. I find the vendor 
> > kernel approach of duplicating the init routines[1] unhelpful as it violates 
> > the DRY principle. The differences between armada380_init_sensor() and 
> > cp110_init_sensor() are minor. In my opinion, these differences should be 
> > expressed explicitly in the armada_thermal_data, in a similar way to my 
> > suggested control_msb_offset field. The vendor code hides these differences in 
> > slight variations of duplicated code.
> >
> > What is the advantage of a separate init routine?
> 
> The main advantage is to be able keep the armada380_init_sensor as the
> legacy init, and then being able to use the new armadacp110_init_sensor
> for the new binding.

I disagree, sorry. I don't think I can make my point any more clear than I 
did.

I am fine with you or Miquel making the code changes that you think are 
necessary. I'll comment on the code when I see it.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
