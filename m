From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 12 Sep 2016 15:47:44 +0300
Subject: [PATCH v2 3/4] ARM: dts: Add NextThing GR8 dtsi
In-Reply-To: <CACRpkdbrvDZGM3OJsAMk4T5awSSbrJ4MDyKXV2C45ZSE7zUVNQ@mail.gmail.com>
References: <20160907145400.27192-1-maxime.ripard@free-electrons.com>
 <20160908073748.GF8913@lukather>
 <CACRpkdbrvDZGM3OJsAMk4T5awSSbrJ4MDyKXV2C45ZSE7zUVNQ@mail.gmail.com>
Message-ID: <1975640.ctuo4Obpao@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Monday 12 Sep 2016 14:40:15 Linus Walleij wrote:
> On Thu, Sep 8, 2016 at 9:37 AM, Maxime Ripard wrote:
> > On Thu, Sep 08, 2016 at 12:46:14PM +0800, Chen-Yu Tsai wrote:
> >> Also, I think we are needlessly using pin groups, 1 pin per group.
> >> Can pinconf/pinctrl work without them? Would there be any harm
> >> converting the sunxi driver to work directly with pins? This would
> >> make it match generic pinconf parsing, and make it easier to get
> >> both working together.
> > 
> > I think it comes from a requirement that you had to have groups at
> > some point (I don't know if it's still the case), which is why we
> > ended up with single-pin groups, because we can mux each pins entirely
> > separately.
> > 
> > If it's not required anymore, then yes, it makes total sense to remove
> > it.
> 
> The groups vs individual pins is an eternal debate that has
> been going on since the inception of pinctrl.
> 
> If you see it from the point of the programmer, you may just see
> a register for each pin and they seem all independent. This is
> why pinctrl-single exist, and that driver is for this purpose: one
> register per pin, software-wise independent.
> 
> HOWEVER it often turns out that while you can programmatically
> and individually set pins to any function (and biasing etc), the
> person designing the hardware was not thinking that you should
> be able to do whatever you like, e.g. even if it is possible to
> take two pins and use one of them for half an SPI bus and the
> other for half an I2C bus, that doesn't mean that this is useful
> or makes any kind of electronic sense, it just makes "software
> sense".
> 
> So for a deeper understanding, several SoCs (amongst them
> my own and Qualcomm etc) define groups that are not really
> about software restrictions for what you can do with the pins, but
> about usecase and electronic restrictions for what can be done
> with the pins.
> 
> E.g. it makes *sense* to have a group for muxing I2C on two
> pins, and not allow one of them to be muxed to I2C and the other
> not, because it does not make electronic sense.
> 
> One-group-per-pin groups is usually coming from a failure or
> inability to identify these electronically sound and usecase
> oriented pingroups.

I'd argue that you would find out about lots of clever/insane use cases that 
don't fit this model if you looked at all the hardware available out there, 
especially non-phone devices. Your SPI example is a good one, I've seen SPI 
being used in unidirectional mode only, with only MISO or MOSI mattering. In 
that case the other pin could be used as a GPIO for a totally unrelated 
purpose when the design is short on GPIOs or when GPIOs have been allocated 
without any knowledge of the Linux pinctrl subsystem.

Looking at the sh-pfc driver, I wish the hardware had followed the pinctrl-
single model. sh-pfc is a good example of how bloated a pinctrl driver can 
become when there is no choice but model all the relationships betweens pins 
and functions in C code.

> Some (like pinctrl-single) say they don't care, and wish to
> see things as the world is just software and one register per
> pin, removing those electric usecase restrictions, and only
> keeping the muxing restrictions to e.g. the four different functions
> that can be muxed on that pin, disregarding the bigger picture.
> 
> I don't know about this driver or the pins it manages,
> I seldom have time or brains to dive in and review things
> deeply enough :(

-- 
Regards,

Laurent Pinchart
