From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 1 Apr 2016 07:02:18 -0700
Subject: [PATCH] ARM: sa1100: Initialize gpio after gpio subsystem has
 been initialized
In-Reply-To: <CACRpkdYg3-XBBCmrKHK5EukEwxU3J4h_4BAKnoVHEiZbFkU5QA@mail.gmail.com>
References: <1459275349-11356-1-git-send-email-linux@roeck-us.net>
 <20160331162116.GB5605@roeck-us.net>
 <CACRpkdYg3-XBBCmrKHK5EukEwxU3J4h_4BAKnoVHEiZbFkU5QA@mail.gmail.com>
Message-ID: <20160401140218.GA14502@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 10:04:57AM +0200, Linus Walleij wrote:
> On Thu, Mar 31, 2016 at 6:21 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Tue, Mar 29, 2016 at 11:15:49AM -0700, Guenter Roeck wrote:
> >> The sa1100 gpio driver was initialized from interrupt initialization code,
> >> which is earlier than the gpio subsystem is initialized. Since commit
> >> ff2b13592299 ("gpio: make the gpiochip a real device"), this is fatal
> >> and causes the system to crash.
> >>
> >> The sa1100 gpio driver must be initialized prior to arch_initcall, since
> >> its gpio pins are used in arch_initcall code, but after the gpio subsystem
> >> is initialized (core_initcall). Initialize it with postcore_initcall.
> >>
> >> Fixes: ff2b13592299 ("gpio: make the gpiochip a real device")
> >> Cc: Linus Walleij <linus.walleij@linaro.org>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >
> > Please ignore/drop this patch - a better (cleaner) fix is in the works
> > for gpiolib.
> 
> This delivers though. I tested it on my also regressing iPAQ.
> 
I am a bit concerned that the gpio initialization was that early on purpose,
and that by moving it we might miss some use cases. I did not find any, but that
doesn't mean that there are none. Without knowing _why_ the initialization was
that early, I would prefer not to touch the code if it can be avoided.

Thanks,
Guenter
