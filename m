From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 22 Oct 2016 12:37:13 +0100
Subject: Disabling an interrupt in the handler locks the system up
In-Reply-To: <580A7A2B.5000702@free.fr>
References: <580A4460.2090306@free.fr>
 <a79e2d2c-8ec8-744f-50fb-8c39216aa23e@arm.com>
 <580A60ED.3030307@free.fr> <20161021201448.3f4a0a7a@arm.com>
 <580A70B9.8060507@free.fr>
 <alpine.DEB.2.20.1610212147420.4855@nanos>
 <580A7A2B.5000702@free.fr>
Message-ID: <20161022123713.6dc788b3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Oct 2016 22:27:23 +0200
Mason <slash.tmp@free.fr> wrote:

> On 21/10/2016 21:49, Thomas Gleixner wrote:
> > On Fri, 21 Oct 2016, Mason wrote:  
> >> On 21/10/2016 21:14, Marc Zyngier wrote:  
> >>> If connecting a device that signals its interrupt as level low to an
> >>> input line configured as level high doesn't strike you as a major
> >>> issue, nothing will. At that point, you can put anything you want in
> >>> your DT.  
> >>
> >> If I understand correctly, you are saying that I should have
> >> specified IRQ_TYPE_LEVEL_LOW, instead of IRQ_TYPE_LEVEL_HIGH?
> >>
> >> If the HW outputs 1 when idle, and 0 when busy, that
> >> is level low? (Sorry if this is obvious, I'm absolutely
> >> clueless in this subject matter.)  
> > 
> > We describe the level which is raising the interrupt. So in your case the
> > line goes to 0 when the interrupt is active, so the level is LOW.  
> 
> I see. I'll try that on Monday.
> 
> In my mental picture of interrupts (which is obviously so
> incomplete as to be wrong) interrupts are a way for hardware
> to tell the CPU that they urgently need the CPU's attention.

That's how the CPU interprets it, but this is even more basic than
that, see below.

> Obviously, the hardware being idle (line high) is not an urgent
> matter which interests the CPU. Likewise, I'm not sure the CPU
> cares that the hardware is busy (line low). It seems to me the
> interesting event from the CPU's perspective is when the
> hardware completes a "task" (transition from low to high).

There is no such thing as "busy" when it comes to interrupts. An
interrupt signals the CPU that some device-specific condition has been
satisfied. It could be "I've received a packet" or "Battery is about to
explode", depending if the device is a network controller or a
temperature sensor. The interrupt doesn't describe the process that
leads to that condition (packet being received or temperature rising),
but the condition itself.

In your cases, as the device seems to do some form of processing
(you're talking about task completion), then the interrupt seems to
describe exactly this ("I'm done").

> So I had originally configured the interrupt as IRQ_TYPE_EDGE_RISING.
> (There is an edge detection block in the irqchip, but the HW designer
> warned me that at low frequencies, it is possible to "miss" some edges,
> and we should prefer level triggers if possible.)

Level and edge are not interchangeable. They do describe very different
thing:

- Level indicates a persistent state, which implies that the device
  needs to be serviced so that this condition can be cleared (the UART
  has received a character, and won't be able to received another until
  it has been read by the CPU). Once the device has been serviced and
  that condition cleared, it will lower its interrupt line.

- Edge is indicative of an event having occurred ("I'm done") that
  doesn't require any action from the CPU. Because the device can
  continue its life without being poked by the CPU, it can continue
  delivering interrupts even if the first one hasn't been serviced.
  Being edge triggered, the signals get coalesced into a single
  interrupt. For example, the temperature sensor will say "Temperature
  rising" multiple times before the battery explodes, and it is the
  CPU's job to go and read the sensor to find out by how much it has
  risen.

If your device only sends a pulse, then it is edge triggered, and it
should be treated as such, no matter what your HW guy is saying. This
usually involves looking at the device to find out how many times the
interrupt has been generated (assuming the device is some kind of
processing element). Of course, this is racy (interrupts can still be
generated whilst you're processing them), and you should design your
interrupt handler to take care of the possible race.

So, to make it short: find out how your device works, and configure
your interrupt controller in a similar way. Write your device driver
with the interrupt policy in mind (state vs event). Keep it simple.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
