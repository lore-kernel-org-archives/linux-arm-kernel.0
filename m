From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 30 Sep 2016 09:53:25 -0700
Subject: [PATCH] Adding Support for Coresight Components on Zynq 7000.
In-Reply-To: <920cac6c-e56a-60d5-4882-22892058346d@supelec.fr>
References: <c6836102-9b7e-a9d9-bad9-34b100d4ae49@supelec.fr>
 <20160929143411.GE16583@xsjsorenbubuntu>
 <920cac6c-e56a-60d5-4882-22892058346d@supelec.fr>
Message-ID: <20160930165325.GA7630@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Muhammad,

On Fri, 2016-09-30 at 09:39:51 +0200, Muhammad Abdul WAHAB wrote:
> Hi S?ren,
> 
> Thank you for your remarks. I corrected a few things as you suggested.
> 
[...]
> >> +        tpiu at F8803000 {
> >>>
> >>> +            compatible = "arm,coresight-tpiu", "arm,primecell";
> >>> +            reg = <0xf8803000 0x1000>;
> >>> +            clocks = <&clkc 47>, <&clkc 16>;
> >>
> >
> > I'm not sure this is correct for every setup. Sorry, that I don't recall
> > all the details, I haven't used tracing in a long time. But I guess this
> > clock is configurable as you're referring an fclk here. The other thing
> > that makes me a little suspicious is, that nothing in here uses the
> > 'dbg_trc' clock that the clock controller provides.
> 
> The TPIU setup included in my patch is specific to my configuration of TPIU.
> The second clock is configurable but I didn't know how to do so. As in
> Vivado setup I chose "fclk1" as the clock for TPIU, I decided to put fclk1.
> But, I am not sure about this. I am having some problems when I recover the
> trace from TPIU: it is not the same as in ETB even though it resembles a
> lot.
> I don't know if the problem is coming from the device tree or from the
> driver.
> I will have a look at 'dbg_trc' clock.

I tried to refresh my Zynq knowledge a bit. The clkc provides the
dbg_trc clock, and that is the clock you need (not fclk). I couldn't
find it in the binding (I guess I messed that up), but apparently,
you can provide a 'trace_emio_clk' as input to the clkc node in the
Zynq DT. Then, with the muxes correctly configured (FSBL should do
that if you select the EMIO trace clock in Vivado), the dbg_trc
output of the clkc should be that EMIO clock. And the dbg_trc output
of the clkc is what should be consumed by the tpiu node. Though, as
I see it the binding/driver for the TPIU do not support that.

I.e.
In the clkc description you'd have to add 'trace_emio_clk' to the
clock-names property together with a matching reference in the 'clocks'
property. As this change would be specific to local setups, this is not
really appropriate for upstream.

Then, for the trace clock, ideally the TPIU would consume and enable it
as needed.

> 
> >>
> >> +            clock-names = "apb_pclk", "fclk1";
> >>
> > Those names (at least fclk1) is not a good name for tpiu to identify
> > it's input. fclk1 is a zynq-specific clock, and as mentioned above, it
> > seems likely that this could easily become a different one. The
> > clock-names are meant to identify an input from the consumer's
> > perspective. The correct names should be documented in the DT binding.
> 
> The first name was chosen as "apb_pclk" because it was recommended in
> Documentation. On the second name, I agree with you but again for TPIU DT
> entry, I am not sure how to make this clock configurable. So, that's why
> I put the same clock name as I had in my Vivado setup. If you have any
> leads on how to make it configurable, I will be happy to take a look
> into it.

Unfortunately, this is not how it works. The DT bindings are not a
recommendation. The DT description must follow the binding, otherwise
drivers will not work correctly, or best case, just ignore what you put
there.

> 
> >> +            clock-frequency=<0xee6b280>;
> >>
> > I cannot find this property in the binding.
> >
> 
> This property was described in clock binding (in an example [2]) and the
> value here (250MHz) corresponds to the value I had chosen in Vivado for
> TPIU input clock.

As I don't see this in the coresight binding, I doubt that it has any
effect or should be here.

	S?ren
