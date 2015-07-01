From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 1 Jul 2015 10:03:03 -0700
Subject: [PATCH 1/2] watchdog: NXP LPC18XX Windowed Watchdog Timer Driver
In-Reply-To: <CAAEAJfCz23VKA49CJN51KwF8WFsjYuaCiHFcXfyWxonK-Qty6g@mail.gmail.com>
References: <1435343072-8753-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1435343072-8753-2-git-send-email-ariel@vanguardiasur.com.ar>
 <20150626190700.GC23078@roeck-us.net>
 <55903943.10309@vanguardiasur.com.ar>
 <5590CDF6.7000103@roeck-us.net> <5593CF3F.9040206@santafe.gov.ar>
 <5593D6CC.10201@vanguardiasur.com.ar>
 <5593F10D.5000507@roeck-us.net>
 <CAAEAJfCz23VKA49CJN51KwF8WFsjYuaCiHFcXfyWxonK-Qty6g@mail.gmail.com>
Message-ID: <20150701170303.GD12711@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 12:22:12PM -0300, Ezequiel Garcia wrote:
> Hi Guenter,
> 
> First of all, thanks a lot for your feedback.
> 
> On 1 July 2015 at 10:54, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 07/01/2015 05:02 AM, Ariel D'Alessandro wrote:
> >>
> >> (Sorry, I sent the last mail with an incorrect mail account)
> >>
> >> El 01/07/15 a las 08:30, adalessandro escibi?:
> >>>
> >>>
> >>> El 29/06/15 a las 01:47, Guenter Roeck escibi?:
> >>>>
> >>>> On 06/28/2015 11:13 AM, Ariel D'Alessandro wrote:
> >>>>>>>
> >>>>>>> +/* Timeout values in seconds */
> >>>>>>> +#define LPC_WDT_DEF_TIMEOUT        1
> >>>>>>> +
> >>>>>>
> >>>>>>
> >>>>>> One second ? This is highly unusual. 30 or 60 seconds is more common,
> >>>>>> and one second would be very challenging for user space.
> >>>>>>
> >>>>>> Any special reason for using such a tight default ?
> >>>>>
> >>>>>
> >>>>> Considering that LPC18xx Watchdog has a fixed divide-by-4 clock
> >>>>> pre-scaler and a 24-bit counter and that Watchdog clock runs at a fixed
> >>>>> frequency of 12MHz, timeout range goes from 1 to 5 seconds.
> >>>>>
> >>>>> I think you're right, 1 sec is very challenging, so it's 5 secs then.
> >>>>>
> >>>> Ultimately you might want to consider a soft timer as backup to the
> >>>> system
> >>>> timeout. But that can be done later if/when needed.
> >>>
> >>>
> >>> I understand your point, but just to be sure, what do mean by soft timer?
> >>>
> >
> > A kernel function which pings the watchdog periodically even if the
> > watchdog is open.
> >
> > Example: Timeout is set to 30 seconds. Since the HW watchdog times out
> > earlier than that, it needs to be pinged regularly (eg every 2.5 seconds).
> > The kernel does that with a timer unless user space does not ping the
> > watchdog within the configured interval of 30 seconds.
> >
> 
> Do we really need this? It sounds like bloat to me. Considering this watchdog
> controller is included in cortex-M MCUs, you wouldn't expect the
> scheduler to be under so much pressure.
> 
No, this would be your call. There are also plans to add this into the watchdog
core, which is really where it should be.

Guenter
