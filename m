From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 27 Aug 2013 00:43:45 +0000
Subject: [PATCH v2 0/4] watchdog: at91sam9_wdt: handle already
 configured wdt
In-Reply-To: <521B5754.2070603@overkiz.com>
References: <1371799176-3408-1-git-send-email-b.brezillon@overkiz.com>
 <521B5754.2070603@overkiz.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364172E328AD@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: boris brezillon [mailto:b.brezillon at overkiz.com]
> Sent: 2013?8?26? 21:26
> To: Boris BREZILLON; Yang, Wenyou
> Cc: Wim Van Sebroeck; Ferre, Nicolas; Jean-Christophe PLAGNIOL-VILLARD;
> Desroches, Ludovic; linux-watchdog at vger.kernel.org;
> linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 0/4] watchdog: at91sam9_wdt: handle already
> configured wdt
> 
> Hello Yang,
> 
> Did you test/review this series ?
> 
> If you did, could you add your Acked, Reviewed and/or Tested-by.
> I'd really like to get this series merged to mainline.
> 
> Thanks.
> 
> Best Regards,
> Boris
> 
> On 21/06/2013 09:19, Boris BREZILLON wrote:
> > Hello,
> >
> > This patch series is a porposal to enhance the sam9 watchdog timer support.
> >
> > The at91sam9 watchdog timer can only be configured once, and the current
> > implementation tries to configure it in a static way:
> > - 2 seconds timeout
> > - wdt restart every 500ms
> >
> > If the timer has already been configured with different values, it returns an
> > error and do not create any watchdog device.
> >
> > This is not critical if the watchdog is disabled, but if it has been enabled
> > with different timeout values it will lead to a SoC reset.
> >
> > This patch series tries to address this issue by adapting the heartbeat value
> > according the WDT timer config:
> > - it first tries to configure the timer as requested.
> > - if it fails it fallbacks to the current config, adapting its heartbeat timer
> > to the needs
> >
> > This patch series also move to a dynamically allocated at91wdt device instead
> > of the static instance. I'm not sure this is the best solution, so please tell
> > me if you prefer to keep static instance of watchdog.
> >
> > It adds a new at91 wdt type: software. This new type make use of the at91
> wdt
> > interrupt to trigger a software reboot.
> >
> > Finally it adds several properties to the device tree bindings.
> >
> > Best Regards,
> > Boris
> >
> > Change since v1:
> >   - fix typo in documentaion
> >   - fix irq dt definition for sama5d3 SoC
> >
> > Boris BREZILLON (4):
> >    watchdog: at91sam9_wdt: better watchdog support
> >    watchdog: at91sam9_wdt: update device tree doc
> >    ARM: at91/dt: add sam9 watchdog default options to SoCs
> >    ARM: at91/dt: add watchdog properties to kizbox board
> >
> >   .../devicetree/bindings/watchdog/atmel-wdt.txt     |   30 +-
> >   arch/arm/boot/dts/at91sam9260.dtsi                 |    5 +
> >   arch/arm/boot/dts/at91sam9263.dtsi                 |    5 +
> >   arch/arm/boot/dts/at91sam9g45.dtsi                 |    5 +
> >   arch/arm/boot/dts/at91sam9n12.dtsi                 |    5 +
> >   arch/arm/boot/dts/at91sam9x5.dtsi                  |    5 +
> >   arch/arm/boot/dts/kizbox.dts                       |    6 +
> >   arch/arm/boot/dts/sama5d3.dtsi                     |    5 +
> >   drivers/watchdog/at91sam9_wdt.c                    |  319
> +++++++++++++++-----
> >   9 files changed, 300 insertions(+), 85 deletions(-)
> >

Tested on sama5d34ek, at91sam9g25ek, linux-next_20130620

Tested-by Wenyou Yang <Wenyou.yang@atmel.com>


Best Regards,
Wenyou Yang
