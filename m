From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Jun 2013 23:12:06 -0600
Subject: [PATCH] reset: provide dummy API entries to avoid link errors
In-Reply-To: <CAGsJ_4xY4anEme-S1AvE5aDf_R5zPmx7wzHM=rmRRxgqFiqR3Q@mail.gmail.com>
References: <1370755846-27011-1-git-send-email-Baohua.Song@csr.com>
 <51B5F970.1080505@wwwdotorg.org>
 <CAGsJ_4xY4anEme-S1AvE5aDf_R5zPmx7wzHM=rmRRxgqFiqR3Q@mail.gmail.com>
Message-ID: <51B6B1A6.6020505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2013 07:39 PM, Barry Song wrote:
> 2013/6/11 Stephen Warren <swarren@wwwdotorg.org>:
>> On 06/08/2013 11:30 PM, Barry Song wrote:
>>> this patch provides dummy reset API entries like other subsystem e.g.
>>> gpiolib to avoid link errors when RESET_CONTROLLER is not enabled.
>>
>> I would tend to think that any driver that needs to use this API to
>> reset its HW should depend on the reset API (or select it) to ensure
>> that the API was present.
>>
>> That way, problems would be detected at compile-time, not run-time.
> 
> Hi Stephen,
> your point is right if the hardware IP always need a real reset to
> work. but the current situation is that many common IP can be used in
> many chips. in some chips, the designer might provide a reset
> controller with a bit set to reset this IP module, but in some other
> chips, there can be no.

I would tend to think that if a HW module needs a reset input, it would
always need one, so an SoC that didn't hook one up would be a bit
broken. Still, I suppose perhaps they could hook it up to a global
system reset rather than to a per-module SW-controlled reset, so you may
have a point.

There is still an issue to resolve:

Just because /a/ particular IP block doesn't have a SW-controlled reset
input, that doesn't imply that the reset API won't/can't be enabled in
Kconfig. Think multi-platform zImage, or multiple IP blocks, some of
which do have a reset input.

What about drivers that attempt to reset their IP block to ensure a
known-good HW state before programming it?

So, I think that drivers that use the reset API should still select or
depend on it. However, the reset API and/or DT bindings for it need some
way of providing a dummy do-nothing reset provider.

Actually, this is just like dummy (fixed) regulators in that framework;
in the regulator case, if the board/... doesn't actually have a
regulator, the board is still supposed to provide a fixed/dummy
regulator so that the drivers can't tell. I'd suggest the same approach
here.

> so a common driver for this IP should be able
> to work with calling device_reset even while lacking of
> RESET_CONTROLLER. here we are considering a case for chipidea,
> ci13xxx, there is a reset bit for it on sirf, but it seems these is no
> code showing a reset bit exists for imx.
