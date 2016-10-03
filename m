From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 3 Oct 2016 06:30:19 -0700
Subject: [PATCH] Adding Support for Coresight Components on Zynq 7000.
In-Reply-To: <5b56a00a-ac69-b15d-1155-bab53ed766f3@supelec.fr>
References: <c6836102-9b7e-a9d9-bad9-34b100d4ae49@supelec.fr>
 <20160929143411.GE16583@xsjsorenbubuntu>
 <920cac6c-e56a-60d5-4882-22892058346d@supelec.fr>
 <20160930165325.GA7630@xsjsorenbubuntu>
 <5b56a00a-ac69-b15d-1155-bab53ed766f3@supelec.fr>
Message-ID: <20161003133019.GF7630@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Muhammad,

On Mon, 2016-10-03 at 14:56:16 +0200, Muhammad Abdul WAHAB wrote:
> Hi S?ren,
> 
> > I tried to refresh my Zynq knowledge a bit. The clkc provides the
> > dbg_trc clock, and that is the clock you need (not fclk). I couldn't
> > find it in the binding (I guess I messed that up), but apparently,
> > you can provide a 'trace_emio_clk' as input to the clkc node in the
> > Zynq DT. Then, with the muxes correctly configured (FSBL should do
> > that if you select the EMIO trace clock in Vivado), the dbg_trc
> > output of the clkc should be that EMIO clock. And the dbg_trc output
> > of the clkc is what should be consumed by the tpiu node. Though, as
> > I see it the binding/driver for the TPIU do not support that.
> >
> > I.e.
> > In the clkc description you'd have to add 'trace_emio_clk' to the
> > clock-names property together with a matching reference in the 'clocks'
> > property. As this change would be specific to local setups, this is not
> > really appropriate for upstream.
> >
> > Then, for the trace clock, ideally the TPIU would consume and enable it
> > as needed.
> 
> Thank you very much for this. I will have a look into it.
> Below is the patch without TPIU, is it possible to submit it ? I will submit
> the TPIU part very soon once I manage to get it working.

Sounds good. AFAICT, the change below should be OK. Probably some
stylistic changes to make it blend in with the rest of the DT (e.g.
use lower case characters in the address parts of the node name).

> 
> > Unfortunately, this is not how it works. The DT bindings are not a
> > recommendation. The DT description must follow the binding, otherwise
> > drivers will not work correctly, or best case, just ignore what you put
> > there.
> 
> Thanks. The idea of including TPIU part was to get feedback as I am far from
> being an expert on DT.
> 
> > As I don't see this in the coresight binding, I doubt that it has any
> > effect or should be here.
> 
> That's what I was thinking also. I will re-look into TPIU part and send it
> soon. Besides, if I want to ask you a question regarding TPIU or DT, can I
> contact you alone or should I keep sending it to all the CS/DT maintainers ?

I'd say that depends on what it is about. If it is about DT and the TPIU
Linux driver, I'd say, keep it on list and probably even include the
authors of that driver (the folks the get_maintainers script is
identifying for that driver).

If it's specific to Zynq, the Xilinx forums can be quite helpful as
there are a lot of people familiar with the device
(https://forums.xilinx.com/t5/Embedded-Linux/bd-p/ELINUX).

But when in doubt, feel free to reach out to me directly.

	S?ren
