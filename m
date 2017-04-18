From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 18 Apr 2017 22:53:34 +0200 (CEST)
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <CAD=FV=VHkJFrsJDmMytbUw=WjKQaGZ-8Ewfy5bPCA82AWS4O2Q@mail.gmail.com>
References: <1795308650.27171.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
 <172093673.40121.1492427140661@email.1und1.de>
 <CAD=FV=WJBTUcMPw8OgQT_jhz0H8AsH=YqWMR7LtudUKrF5-XOA@mail.gmail.com>
 <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
 <186569458.91967.1492547106553@email.1und1.de>
 <CAD=FV=VHkJFrsJDmMytbUw=WjKQaGZ-8Ewfy5bPCA82AWS4O2Q@mail.gmail.com>
Message-ID: <358578833.147337.1492548814446@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Doug Anderson <dianders@chromium.org> hat am 18. April 2017 um 22:41 geschrieben:
> 
> 
> Stefan,
> 
> On Tue, Apr 18, 2017 at 1:25 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > Hi,
> >
> > [add Johan]
> >
> >> Stefan Wahren <stefan.wahren@i2se.com> hat am 18. April 2017 um 10:07 geschrieben:
> >>
> >>
> >> Am 18.04.2017 um 00:37 schrieb Doug Anderson:
> >> > Hi,
> >> >
> >> > On Mon, Apr 17, 2017 at 4:05 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >> >> Hi,
> >> >>
> >> >>> Stefan Wahren <stefan.wahren@i2se.com> hat am 31. Oktober 2016 um 21:34 geschrieben:
> >> >>>
> >> >>>
> >> >>> I inspired by this issue [1] i build up a slightly modified setup with a
> >> >>> Raspberry Pi B (mainline kernel 4.9rc3), a powered 7 port USB hub and 5 Prolific
> >> >>> PL2303 USB to serial convertors. I modified the usb_test for dwc2 [2], which
> >> >>> only tries to open all ttyUSB devices one after the other.
> >> >>>
> >> >>> Unfortunately the complete system stuck after opening the first ttyUSB device (
> >> >>> heartbeat LED stop blinking, no reaction to debug UART). The only way to
> >> >>> reanimate the system is to powerdown the USB hub with the USB to serial
> >> >>> convertors.
> >> >>>
> >> >>> [1] - https://github.com/raspberrypi/linux/issues/1692
> >> >>> [2] - https://gist.github.com/lategoodbye/dd0d30af27b6f101b03d5923b279dbaa
> >> >> since this issue still exists with 4.11 (even without or with microframe scheduler enabled), i want to ask some additional questions:
> >> >>
> >> >> Is this issue reproducible with other dwc2 platforms than bcm2835?
> >> > +Edmund Szeto, who I seem to remember emailing me about similar
> >> > questions in the past.
> >> >
> >> >
> >> >> Does the soft lockup also occurs after opening the second serial convertor or later?
> >> > I don't have serial converters easily available to me, but back in the
> >> > day when I was stressing things out on rk3288 I never saw anything
> >> > this bad.  ...of course, on rk3288 we've got 4 A17 cores running
> >> > really fast, so possibly just being slower is what causes your
> >> > problems here?
> >>
> >> The downstream kernel of the Raspberry Pi foundation with it's
> >> out-of-tree dwc_otg driver is able to handle 8 serial converter on a RPI
> >> B. I would be happy to get at least 2 or 3 working on mainline.
> >>
> >> >
> >> > I will make the following observations:
> >> >
> >> > 1. With dwc2 you often end up in the situation where you need to
> >> > service an interrupt every 125 uS.  If servicing that interrupt takes
> >> > anywhere near 125 uS in the common case then you'll be in trouble.
> >>
> >> I will try to measure this with a logic analyzer.
> >>
> >
> > i took GPIO17 to measure _dwc2_hcd_irq and GPIO18 to measure _dwc2_hcd_urb_enqueue (patch against 4.11rc1 below).
> >
> > So i made my observations for 3 test cases:
> >
> > 1) no serial converter connected (idle)
> > 2) 1 FTDI serial converter connected
> > 3) 1 PL2303 serial converter connected
> >
> > case   | ksoftirq cpu     | mean duration | max duration  | max duration | urb_enqueue  |
> >        |                  | hcd_irq       | hcd_irq       | urb_enqueue  | within 10 sec|
> > -------+------------------+---------------+---------------+--------------+--------------+
> > idle   | 0.0%             | 2 us          | 16.5 us       |     12 us    | 5            |
> > FTDI   | 25.0%            | 8.5 us        | 18.0 us       |  31000 us    | ~ 400        |
> > PL2303 | top doesn't work | 8.5 us        | 22.5 us       | 900000 us    | 4            |
> 
> It's hard to know for sure that all of this time is really in
> urb_enqueue().  Possible we could have task switched out and been
> blocked elsewhere.  Using ftrace to get more fine-grained timings
> would be useful.  ktime_get(), ktime_sub(), and ktime_to_us() are your
> friends here if you want to use trace_printk.
> 

I saw your last reply after sending my last mail. I will go further with ftrace.
