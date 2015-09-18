From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Sep 2015 13:27:19 -0700
Subject: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
In-Reply-To: <20150918174836.GG8020@atomide.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-3-git-send-email-tony@atomide.com>
 <CABxcv=mGNmoVu3TDvd1888TiJ_vg0FJF6qz0p4XTu5T776sJ2Q@mail.gmail.com>
 <20150918174836.GG8020@atomide.com>
Message-ID: <20150918202718.GH8020@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150918 10:54]:
> * Javier Martinez Canillas <javier@dowhile0.org> [150918 10:39]:
> > Hello Tony,
> > 
> > [snip]
> > 
> > >
> > > +       vmmcsdio_fixed: fixedregulator-mmcsdio {
> > > +               compatible = "regulator-fixed";
> > > +               regulator-name = "vmmcsdio_fixed";
> > > +               regulator-min-microvolt = <1800000>;
> > > +               regulator-max-microvolt = <1800000>;
> > > +               gpio = <&gpio5 12 GPIO_ACTIVE_HIGH>;    /* gpio140 WLAN_EN */
> > 
> > I know that other OMAP boards use a fake fixed regulator to toggle the
> > WiFi enable pin but now the MMC subsystem has proper support for power
> > sequence providers so that should be used instead. For simple uses
> > like this, Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> > should be enough.
> 
> Hmm OK great, I'll take a look. Looks like that might also provide a
> nice solution for handling the 32k clock from palmas to the wl12xx.

It seems it's not quite working yet.. It seems pwrseq_simple.c can't
deal with delay on a power pin. It might be best to treat those using
the regulator framework because of the refcounting and start-up delay.
I don't think also having regulator handling in pwrseq_simple.c
conflicts with the MMC regulators as they can be separate?

Also not related to wl12xx, the power pin on mwifiex_sdio 8787 wlan
must be asserted low while reset is asserted and must stay low for
300ms after power pin has deasserted. Again using a regulator there
for the power pin might make more sense.

Then getting the 32k clock from palmas is not working either, it
seems some better deferred probe handling is needed there if
omap_hsmmc is built-in and palmas-clk is a loadable module.

I think for the fix I'll stick with regulator fixed, let's update
it later on unless you have better suggestions.

And also.. It seems wl18xx somehow keeps looing for a wrong

Cheers,

Tony
