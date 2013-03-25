From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 25 Mar 2013 13:42:22 +0100
Subject: [PATCH] ARM: dove: add more hardware description in the DT
In-Reply-To: <CABJ1b_RrFpKdH3w=v4gvRQ-8UniKOz9o9VVJ8Q=AQz5WaN0NRQ@mail.gmail.com>
References: <20130325103159.0c1b4f17@armhf>
 <CABJ1b_RrFpKdH3w=v4gvRQ-8UniKOz9o9VVJ8Q=AQz5WaN0NRQ@mail.gmail.com>
Message-ID: <20130325134222.56fe44fc@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Mar 2013 11:21:13 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On Mon, Mar 25, 2013 at 10:31 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > The 88AP510 chip (Marvell Dove) contains a LCD and display controler
> > and two audio controlers.
	[snip]
> > +               lcd0: lcd0 at 820000 {
> 
> please choose a more informative node names like
> 
> lcd0: lcd-controller at 820000 and
> i2s0: audio-controller at b0000

OK.

> Besides lcd and i2s there is also
> 
> dcon: display-controller at 830000 and
> ire: image-rotation-engine at 831000
> 
> I am not yet 100% sure how to hook them up in dove-drm that I am
> writing on but I want to have them in somehow. DCON will allow to
> mux lcd0/lcd1 data streams, i.e. clone or pan lcd0 to lcd1. IRE allows
> to rotate the memory buffer loaded by -90/90deg.

My first aim is to have the dove-drm in the mainline. These devices
could be added later, as the ac'97, gpu and vpu. Also, rotating the
image is not very useful when your monitor cannot rotate! (I wonder if
such monitors still exist as the one I used on a MAC in the 80's)

But, anyway, I may do it. The only problem is that dcon and ire are
sharing the same irq. How should I declare that?

	[snip]
> Why did you choose gpio interrupt-parent for i2s?

Bug. Thanks.

> From Dove datasheet I can see that, Audio0 has irqs 19, 20
> and Audio1 has irqs 21, 22 on the main irq controller.
> The corresponding nodes for i2s0 and i2s1 should look like
> 
> i2s0: audio-controller at b0000 {
>         compatible = "marvell,kirkwood-i2s";
>         reg = <0xb0000 0x4000>;
>         interrupts = <19>, <20>;
>         clocks = <&gate_clk 12>;
>         status = "disabled";
> }

OK.

BTW, I am ready to upload a new version of the dove-drm on my site. It
now uses the dt for getting the hdmi encoder. Do you prefer I or you do
the merge?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
