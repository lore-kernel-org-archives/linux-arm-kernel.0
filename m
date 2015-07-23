From: marex@denx.de (Marek Vasut)
Date: Thu, 23 Jul 2015 09:02:53 +0200
Subject: [PATCH v2 2/5] Documentation: mtd: add a DT property to set the
 number of dummy cycles
In-Reply-To: <55AFCBE9.2030700@atmel.com>
References: <cover.1437569902.git.cyrille.pitchen@atmel.com>
 <201507221543.54761.marex@denx.de> <55AFCBE9.2030700@atmel.com>
Message-ID: <201507230902.53358.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 22, 2015 at 06:59:21 PM, Cyrille Pitchen wrote:
> Hi Marek,
> 
> Le 22/07/2015 15:43, Marek Vasut a ?crit :
> > On Wednesday, July 22, 2015 at 03:17:07 PM, Cyrille Pitchen wrote:
> >> Depending on the SPI clock frequency, the Fast Read op code and the
> >> Single/Dual Data Rate mode, the number of dummy cycles can be tuned to
> >> improve transfer speed.
> >> The actual number of dummy cycles is specific for each memory model and
> >> is provided by the manufacturer thanks to the memory datasheet.
> >> 
> >> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> >> ---
> >> 
> >>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> >> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt index
> >> 2bee68103b01..4387567d8024 100644
> >> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> >> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> >> 
> >> @@ -19,6 +19,11 @@ Optional properties:
> >>                     all chips and support for it can not be detected at
> >> 
> >> runtime. Refer to your chips' datasheet to check if this is supported by
> >> your chip.
> >> +- m25p,num-dummy-cycles : Set the number of dummy cycles for Fast Read
> >> commands. +                          Depending on the manufacturer
> >> additional dedicated +                          commands are sent to the
> >> flash memory so the +                          controller and the memory
> >> can agree on the number of +                          dummy cycles to
> >> use.
> > 
> > Can't you just try negotiating this value at probe time, starting with
> > some high value and see how low you can get with the negotiations ? This
> > way, you'd be able to effectively auto-detect this value at probe-time.
> > 
> > I might be wrong though :)
> 
> I don't know whether it would be reliable enough. It is the exact same idea
> as for the latency code used by Spansion QSPI memories. Micron memories
> allow to skip the step of converting the number of dummy cycles into a
> latency code, you directly program the right number of dummy cycles into a
> Micron specific register, the Volatile Configuration Register.
> 
> However for both manufacturers the number of dummy cycles to use during
> Fast Read commands is given though tables found into the memory datasheet.
> The number of dummy cycles depends on the Fast Read command, the SPI bus
> clock frequency and the Single/Dual Data Rate mode.
> 
> It should be confirmed by Quad SPI memory manufacturers but since the
> number of dummy cycles depends on the bus clock frequency, I guess the
> values provided by the datasheets are recommendations. I think a too low
> value should not be so easy to detect. For a given frequency one Fast Read
> command may succeed whereas the same command with the very same number of
> dummy cycles might fail on the next try. To be honest, I'm not sure about
> the memory behavior in limit conditions so maybe the command will always
> succeed or always fail.
> 
> Also we can't be sure the read data are valid if we don't write them first.
> So we would have to save the original data to restore them at the end of
> the probing. Writing data at each probe would also reduce the memory
> lifetime. We should also be aware of the bad blocks, which is more a job
> for upper layers.

I see, understood, OK. I really like how you explain those things btw :)

> It would be interesting to have some feedbacks from Micron, Spansion or
> other QSPI memory manufacturer :)

Definitelly!
