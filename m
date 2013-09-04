From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 4 Sep 2013 13:59:07 -0700
Subject: [PATCH RFC v2 01/16] ARM: call clk_of_init from time_init
In-Reply-To: <52279D79.9070408@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <3837b119-baad-4e68-8805-2bc52c0135f9@DB9EHSMHS031.ehs.local>
 <521D2F1F.1070103@gmail.com> <201308291545.37520.arnd@arndb.de>
 <52278AC8.5080103@gmail.com>
 <6ba67c93-e0d0-42d4-b0a5-55c06938a15e@DB9EHSMHS013.ehs.local>
 <52279D79.9070408@gmail.com>
Message-ID: <cfedb014-695a-49cd-8e41-afabd585496a@DB8EHSMHS006.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Wed, Sep 04, 2013 at 10:52:09PM +0200, Sebastian Hesselbarth wrote:
> On 09/04/2013 10:41 PM, S?ren Brinkmann wrote:
> >On Wed, Sep 04, 2013 at 09:32:24PM +0200, Sebastian Hesselbarth wrote:
> >[ ... ]
> >>For mach-zynq I prepared a patch set that brings it close to .init_time
> >>removal. I have pushed it to
> >>   https://github.com/shesselba/linux-dove.git zynq-clk-init-v1
> >>and will maybe post a patch set after this one is done.
> >
> >I think Steffen had a similar approach and we turned it down:
> >Your proposal lets the clkc map the SLCR's registers. I think
> >that approach is not right. It might be okay now, since the
> >SLCR driver is pretty much a useless skeleton. But in general,
> >there is a driver for the SLCR which maps that register
> >region. No other driver should mess with it.
> >
> >Actually, one early version of my clkc looked pretty much like what you
> >propose now and we changed it because of above reason.
> 
> Erm, passing the base address to clkc is less "mess with it" then
> get it from DT?
> 
> Anyways, having a custom .init_time gives you full control over
> of_clk_init and clocksource_of_init back again thanks to your
> suggestion.
> 
> I'll stop converting zynq and let you decide on your own ;)

As I said, currently it's rather messy and neither solution is perfect.
Steffen seemed to already have looked towards syscon and regmap, which
are probably the right ways of making the SLCR regs available to other users.
Sure, passing down the pointer is not perfect, but having two drivers
map the same memory region seems slightly worse to me. And it would even
fail for one driver if you properly used request_mem_region() and friends.

	S?ren
