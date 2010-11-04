From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 04 Nov 2010 14:16:54 -0700
Subject: [PATCHv2 2/3] ARM: Allow machines to override __delay()
In-Reply-To: <4CD31E67.60107@codeaurora.org>
References: <1288300770-18350-1-git-send-email-sboyd@codeaurora.org>
	<1288300770-18350-3-git-send-email-sboyd@codeaurora.org>
	<1288899002.21823.3.camel@c-dwalke-linux.qualcomm.com>
	<4CD31E67.60107@codeaurora.org>
Message-ID: <1288905414.21823.12.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-11-04 at 13:58 -0700, Stephen Boyd wrote:
> On 11/04/2010 12:30 PM, Daniel Walker wrote:
> > On Thu, 2010-10-28 at 14:19 -0700, Stephen Boyd wrote:
> >> +
> >> +static void (*delay_fn)(unsigned long) = delay_loop;
> >> +
> >> +void set_delay_fn(void (*fn)(unsigned long))
> >> +{
> >> +       delay_fn = fn;
> >> +}
> >
> > This needs to be a static inline in the header file.
> 
> Wouldn't that mean delay_fn needs to be exposed in the header file too?
> I like the fact that it's static and scoped to this file.

Yeah you would need to make an extern for that. Why is it better to have
it static in this file?

If you make it inline you should have smaller code size since all your
doing is "delay_fn = fn;" and that's not expected to be used much (if at
all).

> >> +/*
> >> + * loops = usecs * HZ * loops_per_jiffy / 1000000
> >> + */
> >> +void __delay(unsigned long loops)
> >> +{
> >> +       delay_fn(loops);
> >> +}
> >>  EXPORT_SYMBOL(__delay);
> >
> > Can we make this static inline also? I'm sure about the module issues..
> 
> Do you mean in the header file or in this file?

header file.

> I think it won't work because there actually needs to be a __delay
> symbol and it can't just be inlined away at all the call sites.

It would be inlined into delay_fn(loops); . So it's calling a function.
I think you can export the delay_fn symbol and use it that way.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
