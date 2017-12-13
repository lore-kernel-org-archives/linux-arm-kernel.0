From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 13 Dec 2017 11:10:40 +0200
Subject: [PATCH v2 3/4] thermal: armada: add support for CP110
In-Reply-To: <20171213095501.1988749d@xps13>
References: <f8c589337a4fb78852eadf15058e8f8d132d4dc0.1512299484.git.baruch@tkos.co.il>
 <d48c916a2502f9c75e9ea4ba41300e2ffbb254d8.1512299484.git.baruch@tkos.co.il>
 <20171211160932.692ba8be@xps13>
 <20171211152731.glkkes5errcxmsvz@sapphire.tkos.co.il>
 <87y3m9qjt2.fsf@free-electrons.com>
 <20171213083848.j5het742yavxvkkw@sapphire.tkos.co.il>
 <20171213095501.1988749d@xps13>
Message-ID: <20171213091040.jwsphlax4yidm4qp@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

On Wed, Dec 13, 2017 at 09:55:01AM +0100, Miquel RAYNAL wrote:
> > > > How would a separate init_sensor routine improve things?
> > > 
> > > So yes please do it, thanks to this you won't have to add the
> > > control_msb_offset member and can use a clean function. Moreover if
> > > in the future we see some usefulness for this LSB register then we
> > > could use the new compatible for the Armada 38x.
> > 
> > There are two separate issues here:
> > 
> >   1. DT binding
> > 
> >   2. init_sensor callback implementation
> > 
> > We both agree on #1. The A38x and CP110 need separate compatible
> > strings. In case we want to access the LSB control register on Armada
> > 38x, we will need yet another compatible string
> > (marvell,armada380-v2-thermal maybe?).
> > 
> > As for #2, I'm all for sharing as much code as possible. I find the
> > vendor kernel approach of duplicating the init routines[1] unhelpful
> > as it violates the DRY principle. The differences between
> > armada380_init_sensor() and cp110_init_sensor() are minor. In my
> > opinion, these differences should be expressed explicitly in the
> > armada_thermal_data, in a similar way to my suggested
> > control_msb_offset field. The vendor code hides these differences in
> > slight variations of duplicated code.
> > 
> > What is the advantage of a separate init routine?
> 
> The advantage is that is the very near future I plan to add the
> overheat interrupt only on CP110 (not on 38x) and this needs some
> initialization. So if we don't make different routines now, I will
> have to do it right after.

I don't think so. The code of these functions in the vendor kernel overheat 
support implementation is the same, duplicated. The variations are only in 
registers/bits offsets. A single routine with one or two added 
armada_thermal_data fields would be much easier to comprehend and maintain.

> What would be fine is to have the shared code in a separate function,
> like it is done in Marvell kernel. What do you think about that?

The Marvell code does not "share" the code. Separate functions means 
duplicated code that obscures the hardware details, making maintenance harder 
on the long run.

https://en.wikipedia.org/wiki/Don%27t_repeat_yourself

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
