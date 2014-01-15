From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 Jan 2014 14:56:17 +0100
Subject: device-tree: at91: irq and gpios: problem while requesting a
 gpio used as an interrupt source.
In-Reply-To: <CACh+v5Mccz47VMxDcrAC1NY30cY53gxEmp5MG4+n0PNn5RrsSw@mail.gmail.com>
References: <CACh+v5Os_FHh39oXGt=srw0s7bVkpnpH0pQ4ugit_k5BL_k-0A@mail.gmail.com>
 <52D3C166.5050908@overkiz.com>
 <CACh+v5OHtPXrUWQE82qsj7ajSVHFRnHTs7e1s4EUFQi7oxcgfA@mail.gmail.com>
 <20140115123338.GC9558@ns203013.ovh.net>
 <CACh+v5MyWs3Z6MEvx9Rq6XaopcDppmjWaEUt036vBRf0Uy9aAg@mail.gmail.com>
 <20140115132035.GE9558@ns203013.ovh.net>
 <CACh+v5Mccz47VMxDcrAC1NY30cY53gxEmp5MG4+n0PNn5RrsSw@mail.gmail.com>
Message-ID: <20140115135617.GF9558@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:44 Wed 15 Jan     , Jean-Jacques Hiblot wrote:
> 2014/1/15 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
> > On 14:04 Wed 15 Jan     , Jean-Jacques Hiblot wrote:
> >> 2014/1/15 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
> >> > On 12:05 Mon 13 Jan     , Jean-Jacques Hiblot wrote:
> >> >> Hi Boris,
> >> >>
> >> >> 2014/1/13 boris brezillon <b.brezillon@overkiz.com>:
> >> >> > On 13/01/2014 11:29, Jean-Jacques Hiblot wrote:
> >> >> >>
> >> >> >> Hello Nicolas, Jean-Christophe,
> >> >> >>
> >> >> >> As I was trying to enable the touchscreen on the at91sam9261ek with
> >> >> >> device-tree support, I ran into an issue. The touchscreen driver needs
> >> >> >> to know the state of the pendown gpio and also needs it as an
> >> >> >> interrupt source.
> >> >> >>
> >> >> >> The problem is that when a gpio is used as an interrupt, it's
> >> >> >> requested by the pinctrl driver during the xlate stage, marking it
> >> >> >> unavaliable for the other driver.
> >> >> >> It looks like the at91 pinctrl driver is the only one to use
> >> >> >> gpio_request() in the xlate stage. Maybe we should remove this:
> >> >> >
> >> >> >
> >> >> > You should only request it as a GPIO and then use gpio_to_irq to get the
> >> >> > related IRQ.
> >> >> > Because what is done here, is to solve the case where only the irq
> >> >> > is request, and in this specific case we need to request the pin as a
> >> >> > GPIO.
> >> >> >
> >> >>
> >> >> That's what I did first, and was about to submit the patch for the
> >> >> touchscreen driver.
> >> >> However it doesn't feel right. Being able to get the state of a gpio
> >> >> that is also an interrupt seems very useful to me, not only for a
> >> >> touchscreen controller.
> >> >>
> >> >> I understand why it's being done here. It's a matter of being sure
> >> >> that the GPIO is an input and that it'll not be configured otherwise
> >> >> latter.
> >> >> But:
> >> >> 1) I'm wondering why the atmel pinctrl is the only one to do that.
> >> >
> >> > because this the only to start to do it right
> >> > I had a very long discussion woth LinusW and Grant the Gpio need to stop to
> >> > use gpio_to_irq & co for irq.
> >> How can you get the value of the gpio that is also an interrupt source then ?
> >> Can you give a short example?
> >
> > you just have to check the irq source
> >
> > failing or raising
> >
> > but on 9261 impossible the gpio does not have such detail
> >
> > but anyway this is the invert you need to get the information from the IRQ no the way
> > arround
> 
> Should I modify the touchscreen driver to use irq_to_gpio() in this
> case then ? or is this also not proper ?
> 
no as said by arnd irq_to_gpio does not exsit

that's why I said the irq need to provide you the information as it's a
raising or failing irq

Best Regards,
J.
