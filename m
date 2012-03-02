From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Mar 2012 14:56:47 +0000
Subject: [PATCH 4/4] ARM: kirkwood: convert orion-wdt to fdt.
In-Reply-To: <20120302141541.GE11986@titan.lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <20120302091510.GC29461@kw.sim.vm.gnt>
 <20120302141541.GE11986@titan.lakedaemon.net>
Message-ID: <201203021456.47896.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012, Jason wrote:
> Grr... good catch.  I originally had this in kirkwood-dreamplug.dts,
> which is always 200000000.  That's not the case in kirkwood.dtsi.  What
> I would like to do, and I haven't had time to look into it (I thought I
> would tackle it later as a refinement :-( ), is a reference of some
> sort, eg:
> 
> in kirkwood.dtsi:
> 
> / {
>         compatible = "marvell,kirkwood";
>         tclk:clock-frequency = <200000000>;
> 
>         wdt at fed20300 {
>                 compatible = "marvell,orion-wdt";
>                 reg = <0xfed20300 0x28>;
>                 clock-frequency = &tclk;
>         };
> };
> 
> then, in kirkwood-foobar.dts
> 
> include "kirkwood.dtsi"
> 
> / {
>         model = "foobar";
>         compatible = "...";
>         tclk:clock-frequency = <166000000>;
> };
> 
> but I'm not sure if that would work.

That would make wdt at fed20300/clock-frequency a phandle pointing to the
root property, which is not what we want here.

> In any case, the simplest answer is to set clock-frequency in
> kirkwood-dreamplug.dts as a root node property, and then each driver
> that needs tclk, requests the clock-frequency from the root node.
> Hopefully, Grant can chime in on this one.

I think you can just pick a reasonable default value for
wdt at fed20300/clock-frequency, and let the board override that
by setting it to something else if necessary. I suppose this
will also change a bit when kirkwood gets moved over to generic
clk support in the future and starts using the clk binding instead
of what you do now.

	Arnd
