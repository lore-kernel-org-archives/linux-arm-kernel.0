From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 17 Nov 2011 06:57:38 +0000
Subject: [PATCH 0/3] make stmp-style devices mach-independent
In-Reply-To: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
References: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722E3955@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Wednesday, November 16, 2011 6:48 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Sascha Hauer; Guo Shawn-R65073; Dong Aisheng-B29396; Arnd Bergmann;
> Wolfram Sang
> Subject: [PATCH 0/3] make stmp-style devices mach-independent
> 
> It seems I haven't been following the lists too closely lately, so I
> might have missed similar patches. Yet, I noticed some patches dealing
> with drivers using mxs-specific features, so they need to include mach-
> specific files which is troublesome. I started to address the problem as
> well some time ago, so I push out the patches now as RFC to enrich the
> discussion. The patches are rebased to linux 3.2-rc2 and are boot tested.
> 
> The basics: mach-mxs uses ip-cores which follow a register layout I have
> first seen on STMP SoCs. That means, every register has four incarnations:
>  - one u32 to store a value
>  - a SET register where every 1-bit sets the corresponding bit,
>    others are unaffected
>  - similar with a CLR register
>  - and a TGL (toggle) register
> 
> Also, the 2 MSBs in register 0 are always the same and can be used to
> reset the block.
> 
> All this is strictly speaking not mach-specific (but ip-core specific)
> and, thus, doesn't need to be in mach-mxs/include. As I have been told,
> mx50 and
> mx6(?) might also use IP cores following the STMP-style; so I wondered if
> it can't be exported like the following patch series does:
> 
> Introduce a stmp-style device, put the code around that in a public place
> (currently drivers/base/; dunno if that is the best place, though), and
> let drivers for stmp-style devices select that code.
> 
> Voila, mach dependency gone, reusable code introduced. Note that I didn't
> remove the duplicated code from mach-mxs yet, first all drivers have to
> be converted.
> 
> Right thing to do? If so, I'll repost properly to the right lists.
> Fishing for feedback right now :)

Good thing to do.
I think it addressed my concern which raised in another patch
[PATCH 1/1] gpio: gpio-mxs: remove the duplicated micro define.

One thing is that for some people not know the history
between smtp and mxs, it maybe a little confused to see calling smtp_xx code
in mxs code.
Just as Shawn said, if we will final move to mxs in the long term,
maybe mxs name is better, right?


> Thanks,
> 
>    Wolfram
> 
> Wolfram Sang (3):
>   drivers: base: add support for stmp-style devices
>   i2c: mxs: use global reset function
>   rtc: stmp3xxx: use global stmp_device functionality
> 
>  drivers/base/Kconfig         |    3 ++
>  drivers/base/Makefile        |    1 +
>  drivers/base/stmp_device.c   |   80
> ++++++++++++++++++++++++++++++++++++++++++
>  drivers/i2c/busses/Kconfig   |    1 +
>  drivers/i2c/busses/i2c-mxs.c |    9 +----
>  drivers/rtc/Kconfig          |    1 +
>  drivers/rtc/rtc-stmp3xxx.c   |   29 +++++----------
>  include/linux/stmp_device.h  |   19 ++++++++++
>  8 files changed, 117 insertions(+), 26 deletions(-)  create mode 100644
> drivers/base/stmp_device.c  create mode 100644
> include/linux/stmp_device.h
> 
> --
> 1.7.7.1
> 
