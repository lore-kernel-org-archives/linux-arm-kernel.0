From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 22 Aug 2016 22:18:15 +0200 (CEST)
Subject: [PATCH V3 2/5] ARM: dts: bcm283x: Add dtsi for USB host mode
In-Reply-To: <87fupw4rgm.fsf@eliezer.anholt.net>
References: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
 <1471792204-21908-3-git-send-email-stefan.wahren@i2se.com>
 <87fupw4rgm.fsf@eliezer.anholt.net>
Message-ID: <533983163.19485.709cd5b7-97dd-4dda-9392-7c46ec5e192c.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 22. August 2016 um 19:57 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > In case dr_mode isn't passed via DT, the dwc2 defaults to OTG mode.
> > But all Raspberry Pi boards here are designed only for host mode.
> > So fix this issue by providing a dtsi file which set the dr_mode
> > to host.
> 
> Can you explain what change this should cause for these boards?  Is it
> just going to drop this message from dmesg:
> 
> dwc2 3f980000.usb: Configuration mismatch. dr_mode forced to host

IMO it isn't a message which could be ignored. The dwc2 tries to detected the
USB role from compile configuration and hardware capabilities, but according to
the decision table [1] we should provide the correct dr_mode which is import for
FIFO configuration and so on.

Another problem that i see is that the USB behavior is influenced by compile
settings in a unexpected way. With arm/configs/bcm2835_defconfig the driver is
forced to host, but in a multiplatform config like arm64/configs/defconfig not.
I would expect a more stable dr_mode.

At the end the dwc2 can't reliable detect the dr_mode because it depends on the
board design.

Any concerns?

Stefan

[1] -
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=5268ed9d2e3b52f703f3661eef14cecbb2b572d4

> 
> or something else?
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
