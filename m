From: kevin.bracey@broadcom.com (kevin.bracey at broadcom.com)
Date: Thu, 28 Nov 2013 10:07:55 +0000
Subject: pinctrl - detailed gpio-mode pinconf design
Message-ID: <EB2BCA6A838C7B4FB238C534ED5D770422395F79@renexmb02.roe2.renesasmobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm working on converting an shmobile-based system that has a lot of custom GPIO/pin manipulation to use pure pinctrl.  I'm a bit stuck on some of the design details.

I'm going to have to extend the sh-pfc pinctrl driver a fair bit to support all the necessary functionality, but I'm not quite sure how some of it should look. I have a first-pass prototype, but I'm worried that the consumer API just isn't right.

Basically, our system has an existing mechanism to get pins into "safe" state for sleep. It uses the legacy SH "gpio_request(FN)" mechanism to switch pinmux between function and GPIO, and then sets GPIO direction through normal GPIO APIs, and pin pulls through a custom API.

Clearly, this can now be replaced with default+sleep pinctrl states. But I'm not seeing a clear model to follow in the upstream code at the level of detail I need.

The pins that we're dealing with basically look like this diagram from pinctrl.txt:

                       pin config
                       logic regs
                       |               +- SPI
     Physical pins --- pad --- pinmux -+- I2C
                               |       +- mmc
                               |       +- GPIO
                               pin
                               multiplex
                               logic regs

The control bits we have in the GPIO function are "input enable", "output enable" and "output data". Those manual controls are only effective when the GPIO mux is selected. The pad config bits are "pull up enable" and "pull down enable", and they're always manually controllable.

So adding a "gpio-mode" function to each pin group as per pinctrl.txt seems the obvious thing to do.

And we need to extend the sh-pfc driver to let us control the GPIO through pinconf once the "gpio-mode" function is selected. But how exactly should this work? The questions are really about the intent of generic pinconf, rather than anything platform-specific.

At present, the sh-pfc driver only supports BIAS_PULL_UP, BIAS_PULL_DOWN, and BIAS_DISABLE, which control only the pad pulls, and don't touch the GPIO bits.

Now, if specifying hi-Z/output for a "gpio-mode" pin, it seems that we should use generic pinconf BIAS_HIGH_IMPEDANCE and OUTPUT(0,1). Yes?

But then how do we describe a pull? It seems most natural for pinctrl consumers to express this as simply MUX("gpio-mode"), CONF(BIAS_PULL_UP).

So, should BIAS_PULL_UP automatically select "input" in gpio-mode? Or does the DT/board have to explicitly say MUX("gpio-mode"), CONF(BIAS_PULL_UP, BIAS_HIGH_IMPEDANCE) to select pull up and input? Or does that just make no sense - it certainly looks odd. What's the intent here in the generic pinconf design?

Looking at it another way - do we model the pinconf as these 2 sets of independent settings - you can always set 1 of the first 3, and you can also set 1 of the second 3 in gpio-mode:

  (BIAS_PULL_UP | BIAS_PULL_DOWN | BIAS_DISABLE)  = (pull=UP | pull=DOWN | pull=OFF)
  (BIAS_HIGH_IMPEDANCE | OUTPUT 0 | OUTPUT 1)     = (IEN=OEN=0 | IEN=0,OEN=1,DATA=0 | IEN=0,OEN=1,DATA=1 ) 

Or we treat it as one set where you can only ever enable 1:

   BIAS_PULL_UP                         pull=UP, IEN=OEN=0
   BIAS_PULL_DOWN                       pull=DOWN, IEN=OEN=0
   BIAS_HIGH_IMPEDANCE                  pull=OFF, IEN=OEN=0
   OUTPUT 0                             pull=OFF, IEN=0, OEN=1, DATA=0
   OUTPUT 1                             pull=OFF, IEN=0, OEN=1, DATA=1

(and I guess BIAS_DISABLE is equivalent then to BIAS_HIGH_IMPEDANCE in gpio-mode; with other functions selected, or a real GPIO request, you would only be able to modify the pulls with pinconf, as with the current driver).

And once you have the answer to that, what about glitch-free handover? What is the canonical ordering for MUX+CONF in state tables/DT? If MUX comes first, should the driver defer the actual GPIO mux switch until the CONF specification, to avoid glitches? (The driver already applies this logic internally for GPIO API requests). Or do we require consumers to specify the CONF /before/ the MUX to get a glitch-free transition? That seems a bit odd, as they'd be requesting a pin config that wouldn't (yet) take effect, ruling out some error-checking.

Any guidance appreciated,

Kevin
