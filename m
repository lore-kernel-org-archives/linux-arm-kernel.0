From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 26 Mar 2013 16:23:58 +0100
Subject: [PATCH/RFC] ARM: shmobile: Disallow PINCTRL without GPIOLIB
In-Reply-To: <CANqRtoR+xVFx6ytvjcHxNcQ3X=avXs49-pR-XCr7ApqOq_WFRQ@mail.gmail.com>
References: <20130318135818.23765.51686.sendpatchset@w520>
 <7840344.mRAPGty7WD@avalon>
 <CANqRtoR+xVFx6ytvjcHxNcQ3X=avXs49-pR-XCr7ApqOq_WFRQ@mail.gmail.com>
Message-ID: <21658140.49USZQOU99@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Tuesday 26 March 2013 13:04:25 Magnus Damm wrote:
> On Thu, Mar 21, 2013 at 12:28 AM, Laurent Pinchart wrote:
> > On Monday 18 March 2013 22:58:18 Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >> 
> >> Modify mach-shmobile to only select PINCTRL in case of
> >> ARCH_WANT_OPTIONAL_GPIOLIB is set.
> >> 
> >> This fixes a build error triggered when adding a new SoC
> >> 
> >> lacking GPIO software support (ARCH_WANT_OPTIONAL_GPIOLIB=n):
> >>  CC      drivers/tty/vt/keyboard.o
> >> 
> >> In file included from drivers/pinctrl/core.c:30:0:
> >> include/asm-generic/gpio.h: In function 'gpio_get_value_cansleep':
> >> include/asm-generic/gpio.h:270:2: error: implicit declaration of function
> >> '__gpio_get_value'
> >> include/asm-generic/gpio.h: In function 'gpio_set_value_cansleep':
> >> include/asm-generic/gpio.h:276:2: error: implicit declaration of function
> >> '__gpio_set_value'
> >> drivers/pinctrl/core.c: In function 'pinctrl_ready_for_gpio_range':
> >> drivers/pinctrl/core.c:297:9: error: implicit declaration of function
> >> 'gpio_to_chip'
> >> drivers/pinctrl/core.c:297:27: warning: initialization makes pointer from
> >> integer without a cast
> >> drivers/pinctrl/core.c:304:45: error: dereferencing pointer to incomplete
> >> type
> >> drivers/pinctrl/core.c:305:26: error: dereferencing pointer to incomplete
> >> type
> >> drivers/pinctrl/core.c:305:39: error: dereferencing pointer to incomplete
> >> type
> >> make[2]: *** [drivers/pinctrl/core.o] Error 1
> >> make[1]: *** [drivers/pinctrl] Error 2
> >> make[1]: *** Waiting for unfinished jobs....
> >> 
> >>   LD      drivers/sh/built-in.o
> >> 
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> 
> >> ---
> >> 
> >>  Using renesas.git "next" 811689afc214564c4a5f238ecf4d8bdc0e52b615
> >>  
> >>  Trigger using the r8a73a4 patches that lack GPIO and PFC support.
> >>  
> >>  I am more than happy to replace this patch with something cleaner.
> > 
> > If I'm not mistaken your patch fixes the compilation breakage by
> > unselecting PINCTRL and making it possible no to select GPIOLIB. I'm fine
> > with that as an interim solution, but I wonder whether we shouldn't just
> > force PINCTRL and GPIOLIB for ARCH_SHMOBILE at some point.
> 
> Thanks for your comments. I'm quite fine with any approach myself. My
> main concern is to have to the mach-shmobile code in a state so it is
> possible to add SoC support incrementally and start without any PFC or
> GPIO and then add them one by one. Or add them together. Please note
> that EMEV2 supports GPIO but not yet PINCTRL.

Right. In that case your patch is fine.

> About this issue, the fact that selecting PINCTRL without GPIO results
> in compile error makes me think that something needs slight adjustment
> in the PFC code.

The above errors come from the pinctrl core (although the PFC driver might not 
compile either in this case). Linus, what's your opinion on this ? Do we want 
to support systems with pinctrl but without gpiolib ?

> Or perhaps PINCTRL without GPIO isn't a valid combination? But if so, why do
> we have separate Kconfig entries?

-- 
Regards,

Laurent Pinchart
