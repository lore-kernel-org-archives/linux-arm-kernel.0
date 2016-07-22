From: mturquette@baylibre.com (Michael Turquette)
Date: Thu, 21 Jul 2016 17:14:05 -0700
Subject: [PATCH v4] xen/arm: Add a clock property
In-Reply-To: <457c61fd-4a64-b050-cd87-845b7e22ec39@arm.com>
References: <1468309605-19522-1-git-send-email-dirk.behme@de.bosch.com>
 <CAMuHMdU9yP2SMYa5ssrQSu1vwSN2gM4mD-EVYSGr2Pqf=jmCgw@mail.gmail.com>
 <cc28ef7e-dce3-fe5f-ab80-b662244bcbd0@arm.com>
 <CAMuHMdWeJjcuBHjnjppc5Ys5Ew8VssXzg=dLpLPCOQaBnUo_7Q@mail.gmail.com>
 <04d9dbfb-196d-a775-7fbb-526aba8085f4@arm.com>
 <CAMuHMdWdqdT4jnae8h9tDDzzh8ZAbJJwiMW-scPBNVwmjYSiWQ@mail.gmail.com>
 <457c61fd-4a64-b050-cd87-845b7e22ec39@arm.com>
Message-ID: <146914644542.8780.6400440784482743934@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Julien Grall (2016-07-20 06:21:45)
> 
> 
> On 20/07/2016 13:46, Geert Uytterhoeven wrote:
> > Hi Julien,
> 
> Hello Geert,
> 
> > On Wed, Jul 20, 2016 at 2:10 PM, Julien Grall <julien.grall@arm.com> wrote:
> >> On 20/07/16 12:49, Geert Uytterhoeven wrote:
> >>> On Wed, Jul 20, 2016 at 1:01 PM, Julien Grall <julien.grall@arm.com>
> >>> wrote:
> >>>> On 20/07/16 10:43, Geert Uytterhoeven wrote:
> >>>>> On Tue, Jul 12, 2016 at 9:46 AM, Dirk Behme <dirk.behme@de.bosch.com>
> >>>>> wrote:
> >>>>>> Clocks described by this property are reserved for use by Xen, and the
> >>>>>> OS
> >>>>>> must not alter their state any way, such as disabling or gating a
> >>>>>> clock,
> >>>>>> or modifying its rate. Ensuring this may impose constraints on parent
> >>>>>> clocks or other resources used by the clock tree.
> >>>>>>
> >>>>>> This property is used to proxy clocks for devices Xen has taken
> >>>>>> ownership
> >>>>>> of, such as UARTs, for which the associated clock controller(s) remain
> >>>>>> under the control of Dom0.
> >>>>>
> >>>>> I'm not familiar with using XEN at all, but I'm a bit puzzled...
> >>>>>
> >>>>> Can't you just add a clocks property to the (virtual) serial device node
> >>>>> in DT?
> >>>>> Then the (virtual) serial device driver can get and enable the clock?
> >>>>
> >>>> There is no DT node for the Xen console (hvc). The UART used by Xen will
> >>>> be
> >>>> completely removed from the Device tree.
> >>>
> >>> Why is it removed?
> >>
> >> Because the device is used exclusively by Xen and DOM0 should not touch it
> >> at all (IRQs and MMIOs are not mapped).
> >
> > IMHO then it's Xen's responsability to make sure not to disable the clock(s).
> 
> Xen does not disable the clock(s). The problem is Linux thinks the clock 
> is not used and therefore will disable the clock.
> 
> Actually Xen does not have any knowledge how to handle clocks (i.e 
> setting rate, enabling/disabling). I would recommend you to read the 
> binding description in the patch and not the implementation which is 
> IHMO misleading.
> 
> >
> > Who removes the device node from the DT? If Xen, can't it just remember
> > which clocks were present in removed device nodes?
> 
> Xen is removing the node from the DT. Not removing the node will not 
> change the problem. Linux is disabling the clock because there is no 
> driver which used those clocks.
> 
> As the clock subsystem will disable any unused clocks (from Linux point 
> of view), the UART will get disabled and the console will be lost.
> 
> What we want to achieve with this patch is to let Linux knows that this 
> clock is in use by someone else (hypervisor or guest) and:
>      * If the clock is not shared: don't disable it
>      * If the clock is shared: don't change the rate

Thanks for the explanation above. It helped clarify things for me.

So, can you have some sort of dummy driver in Linux that claims the
resources needed by Xen and calls the necessary Linux apis to insure
that Xen's needs are satisfied? As I mentioned in my previous reply
from a couple of minutes ago:

struct clk *clk = clk_get(xen_dev, ...);
clk_prepare_enable(clk);
clk_set_rate_range(...);

I'm not sure where the rate info should come from, but this represents a
correct use of clk consumer apis.

Regards,
Mike

> 
> >
> > What to do on SoCs where the serial device is part of a power area (e.g.
> > Renesas SH/R-Mobile)? Who will make sure it is not powered down?
> 
> I don't have any knowledge on the Renesas SH/R-Mobile. However, we 
> expect some cooperation between DOM0 and Xen to handle the power.
> 
> For instance managing the clocks in Xen would require to implement clock 
> driver for each SOC because it does not seem to have a generic way to do it.
> 
> Given that Linux already knows a lot about the clock, we want to hand 
> over the clock control to the hardware domain (i.e dom0). This means 
> that we have to find a way to cooperate with it to keep enable clocks 
> that we care about.
> 
> Regards,
> 
> -- 
> Julien Grall
