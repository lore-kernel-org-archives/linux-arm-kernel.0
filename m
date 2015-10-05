From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 05 Oct 2015 16:18:46 +0300
Subject: [PATCH v2 0/7] Add support for Exynos SROM Controller driver
In-Reply-To: <5612719E.60006@samsung.com>
References: <1440403348-8974-1-git-send-email-pankaj.dubey@samsung.com>
 <018501d0ff62$1650b410$42f21c30$@samsung.com> <5612719E.60006@samsung.com>
Message-ID: <01cb01d0ff70$6027b760$20772620$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> That is interesting. What do you mean by that? Although SROM controller
> can access external memory (SRAM, ROM) but it is not exactly a bus. How
> is the SMSC9111 "connected"? What interface or protocol is used?

 SROM controller actually provides a demultiplexed external address and data bus. This way you could
hook up old good ROM chip to it (hence its name). However, you can plug in there anything else with
the appropriate interface, and SMSC9111 uses exactly that. Just some address + control + data wires.
Therefore, you can think of SROMc as a simple bus.

> I am sorry but I cannot figure out what exactly are you talking about.
> The Device Tree is the glue to describe the board, the hardware and its
> configuration. Please elaborate a little more.

 Yes, exactly that. SROM controller has 4 outputs, and for every of these outputs you have to choose
mode and timings. Once you set them correctly, you can use peripherial behind them. These timings
actually depend on the actual peripherial.

 By this time i remembered that u-boot guys also did something with this. And here are links:
http://git.denx.de/?p=u-boot.git;a=blob;f=arch/arm/dts/exynos5250-smdk5250.dts;h=8b695442b1a29dec4e3
53ebd3cfee0ff89f218a6;hb=HEAD#l43 - this is how connection is described
http://git.denx.de/?p=u-boot.git;a=blob;f=board/samsung/common/board.c;h=d32c75de50858f131284e28db0c
7ed55883f1cb0;hb=HEAD#l184 - and this is parsing code

 There's only one small problem with their code. "bank" parameter is device-wide, therefore you
cannot configure more than one bank. For SMDK boards it's OK, but in future you may run into problem
with this.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
