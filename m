From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 1 Nov 2016 16:17:08 -0700
Subject: [PATCH v3] ARM: dts: Add gyro and accel to APQ8060 Dragonboard
In-Reply-To: <CACRpkdbipgysCjQDgvBhex7SewVaV379gL-wsZuHCY4Mz1p-aw@mail.gmail.com>
References: <1477473794-26030-1-git-send-email-linus.walleij@linaro.org>
 <20161031222029.GG25787@tuxbot>
 <CACRpkdbipgysCjQDgvBhex7SewVaV379gL-wsZuHCY4Mz1p-aw@mail.gmail.com>
Message-ID: <20161101231708.GM25787@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 01 Nov 04:31 PDT 2016, Linus Walleij wrote:

> On Mon, Oct 31, 2016 at 11:20 PM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> 
> >> +                                     interrupt-parent = <&pm8058_gpio>;
> >> +                                     interrupts = <208 IRQ_TYPE_EDGE_FALLING>;
> >
> > To remove the need of resetting the interrupt-parent in each child you
> > can use the following form:
> >
> >     interrupts-extended = <&pm8058_gpio 208 IRQ_TYPE_EDGE_FALLING>;
> >
> > But, if we correct the ssbi gpio driver then this would no longer be
> > interrupt 208 in this parent, right?. I believe that if you say
> > <&pmicintc 208 IRQ_TYPE_EDGE_FALLING> instead, which should work even
> > after we correct the gpio translation.
> 
> Yes. It should be fixed everywhere but is not related to this
> patch. But I can do a two-patch series first fixing this and then
> adding the gyro+accelerometer on top referencing the MFD
> pmicintc as parent.
> 

Sorry, I'm not sure I'm following.

What I tried to say was that before the correction of the GPIO block's
window this particular IRQ would be #208 in &pmicintc and #208 in
&pm8058_gpio. After the correction of the window the IRQ is #208 in
&pmicintc and #17 in &pm8058_gpio.

As such, using #208 from &pmicintc would make this work through the
correction of the GPIO driver. Perhaps I'm wrong about this?


Either way, it's no big deal. I'm fine with either path.

> > (Which probably means we need to get that redesigned, before we
> > introduce to many of these)
> 
> What needs to happen is for the SSBI and SPMI GPIO to use a
> hierarchical irqdomain so their GPIO local line offset and hwirq
> are the same. Then we can reference the GPIO IRQ lines directly
> in a correct manner.
> 

Right. Do you have any example of drivers getting this right? I did take
a quick look but didn't find one.

Regards,
Bjorn
