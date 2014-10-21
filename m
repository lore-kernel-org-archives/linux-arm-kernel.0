From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Oct 2014 11:30:35 +0200
Subject: [PATCH] genirq: Introduce irq_read_line()
In-Reply-To: <alpine.DEB.2.11.1410211120430.5308@nanos>
References: <1408479811-26088-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAJAp7OgGPZZuCgC8iUiW2jrEVubK=KCATxd6eazdT1x1sSrffg@mail.gmail.com>
 <alpine.DEB.2.11.1410211120430.5308@nanos>
Message-ID: <1894914.TrPC3AEWES@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 October 2014 11:22:40 Thomas Gleixner wrote:
> On Thu, 4 Sep 2014, Bjorn Andersson wrote:
> 
> > On Tue, Aug 19, 2014 at 1:23 PM, Bjorn Andersson
> > <bjorn.andersson@sonymobile.com> wrote:
> > > Introduce the irq_read_line() function to allow device drivers to read
> > > the current logical state of an input when the hardware only exposes
> > > this through status bits in the interrupt controller.
> > >
> > > The new function is backed by a new callback function in the irq_chip -
> > > irq_read_line() - that can be implemented by irq_chips that owns such
> > > status bits.
> > >
> > > Based on rfc patch from April 2011 by Abhijeet.
> > >
> > > Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > 
> > ping?
> 
> Sorry, slipped through the cracks. I was talking about this to Marc
> last week and he needs it for yet another reason. He had some thoughts
> about the state representation, so I wait for him to comment.

I looked up my older email as well and found which gpio driver had the
requirement to get the irq status from the upstream controller. It was
"gpio: Add APM X-Gene standby GPIO controller driver". I'm adding the
APM developers on Cc here so they can participate in the discussion.

As a brief summary: APM have a GPIO driver that needs to read the status
from the ARM GIC in order to implement gpio_get_value. The KVM hypervisor
needs multiple bits from the GIC in order to implement suspend/resume,
and Qualcomm MSM (as Bjorn wrote above) also needs to expose the status
of the IRQ line like APM does.

These should all use the same interface for the interrupt controller,
but the interface still needs to be added.

	Arnd
