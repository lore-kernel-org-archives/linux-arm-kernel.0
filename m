From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 9 Dec 2015 09:01:55 +0100
Subject: [RESEND RFC PATCH 0/2] Expose the PIO_ISR register on SAMA5D3
In-Reply-To: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
References: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
Message-ID: <20151209080155.GB7411@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Dec 08, 2015 at 04:20:06AM +0100, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> Hi!
> 
> I have a signal connected to a gpio pin which is the output of
> a comparator. By changing the level of one of the inputs to the
> comparator, I can detect the envelope of the other input to
> the comparator by using a series of measurements much in the
> same maner a manual ADC works, but watching for changes on the
> comparator over a period of time instead of only the immediate
> output.
> 
> Now, the input signal to the comparator might have a high frequency,
> which will cause the output from the comparator (and thus the GPIO
> input) to change rapidly.
> 
> A common(?) idiom for this is to use the interrupt status register
> to catch the glitches, but then not have any interrupt tied to
> the pin as that could possibly generate pointless bursts of
> (expensive) interrupts.
> 

Well I don't know if this use case as already been considered. I
understand you don't want to be overwhelmed by interrupts but why not
using the interrupt to start polling the PDSR (Pin Data Status
Register)?

I am really not confortable about exposing the ISR since there is a
clean on read. You have taken precautions by checking the IMR before but
if there is a single driver using a gpio as an irq, you will never get
the ISR.

Regards

Ludovic

> So, these two patches expose an interface to the PIO_ISR register
> of the pio controllers on the platform I'm targetting. The first
> patch adds some infrastructure to the gpio core and the second
> patch hooks up "my" pin controller.
> 
> But hey, this seems like an old problem and I was surprised that
> I had to touch the source to do it. Which makes me wonder what I'm
> missing and what others needing to see short pulses on a pin but not
> needing/wanting interrupts are doing?
> 
> Yes, there needs to be a way to select the interrupt edge w/o
> actually arming the interrupt, that is missing. And probably
> other things too, but I didn't want to do more work in case this
> is a dead end for some reason...
> 
> Cheers,
> Peter
> 
> Peter Rosin (2):
>   gpio: Add isr property of gpio pins
>   pinctrl: at91: expose the isr bit
> 
>  Documentation/gpio/sysfs.txt   |   12 ++++++++++
>  drivers/gpio/gpiolib-sysfs.c   |   30 ++++++++++++++++++++++++
>  drivers/gpio/gpiolib.c         |   15 ++++++++++++
>  drivers/pinctrl/pinctrl-at91.c |   50 ++++++++++++++++++++++++++++++++++++----
>  include/linux/gpio/consumer.h  |    1 +
>  include/linux/gpio/driver.h    |    2 ++
>  6 files changed, 106 insertions(+), 4 deletions(-)
> 
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
