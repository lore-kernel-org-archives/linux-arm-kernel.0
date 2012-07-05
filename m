From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarth)
Date: Thu, 05 Jul 2012 17:51:21 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <201207051454.24475.arnd@arndb.de>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <20120705130819.GV17534@lunn.ch> <4FF5A15A.8070309@googlemail.com>
 <201207051454.24475.arnd@arndb.de>
Message-ID: <4FF5B7F9.9020507@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2012 04:54 PM, Arnd Bergmann wrote:
> This way you have multiple nodes with the same register
> and different names, which is not how it normally works.

Ok.

>> This would have the advantage that DT describes gpio-to-irq dependencies.
>> Moreover, nodes that reference gpios can do gpios =<&gpio 71 0>; instead of
>> gpios =<&gpio3 7 0>;
>
> Is that desired?
>
> The device tree representation should match what is in the data sheet
> normally. If they are in a single continuous number range, then we should
> probably have a single device node with multiple register ranges
> rather than one device node for each 32-bit register. Looking at
> arch/arm/plat-orion/gpio.c I think that is not actually the case though
> and having separate banks is more logical.

Well, looking at the datasheet of Dove GPIOs are numbered [63:0] plus
GPOs [71:64]. This dt will be a lot shorter and maybe it is describing
the hardware as it is. (Not sure about the syntax for irqs, though)

gpio at d0400 {
	compatible = "marvell,orion-gpio";
	gpio-controller;
	reg = <0xd0400 0x20>, /* GPIO[31: 0] */
	      <0xd0420 0x20>, /* GPIO[63:32] */
	      <0xe8400 0x0c>; /* GPO [71:64] */
	ngpio = <72>;
	interrupts = <12 13 14 15>, <61>;
};

Sebastian
