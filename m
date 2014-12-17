From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Dec 2014 15:31:25 +0100
Subject: [PATCHv1] rtc: bcm-iproc: Add support for Broadcom iproc rtc
In-Reply-To: <5490A9FC.6030305@broadcom.com>
References: <1418757750-3628-1-git-send-email-arun.ramamurthy@broadcom.com>
 <549095CA.7090505@broadcom.com> <5490A9FC.6030305@broadcom.com>
Message-ID: <1603624.EMYvBCWhuM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 December 2014 13:54:04 Arun Ramamurthy wrote:
> On 14-12-16 12:27 PM, Ray Jui wrote:
> > On 12/16/2014 12:19 PM, Arnd Bergmann wrote:
> >>
> >> It sounds like CRMU is some other unit aside from the RTC. Could this
> >> be something like a generic system controller? I think it should
> >> either have its own driver or use the syscon logic if that is what
> >> this is.
> >>
> > Giving that CRMU has scattered, miscellaneous control logic for multiple
> > different peripherals, it probably makes more sense to use the syscon
> > logic here.
> >
> Arnd, thanks for the feedback. If I was to write a separate driver for 
> the CRMU, I would have to export certain functions and create an api 
> that only this RTC driver would use. I am not sure that is efficient or 
> required. What is your opinion?
> Would it be better if I use the syson api in my current driver and move 
> the CRMU registers to separate syscon device tree entry?
> 

This is something that's normally up to the platform maintainers, depending
on what works best for a given SoC. If you have a control block that
wants to export the same high-level API for multiple drivers, that's
fine, but if literally every register does something different, a syscon
driver works best.

It's also possible that some of the functions of the CRMU already have
abstractions, like system-reset, device-reset, regulator or clock support.
In that case, you can still use syscon but have the more other drivers
use that for accessing the registers.

	Arnd
