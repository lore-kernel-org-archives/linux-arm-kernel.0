From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Dec 2014 08:32:01 +0100
Subject: [PATCH 1/6] ARM: sunxi: DT: Convert to device tree includes
In-Reply-To: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <2559984.DiBeGaGfHy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 December 2014 22:59:54 Maxime Ripard wrote:
> Prepare the device trees to use the C preprocessor.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Hi Maxime,

Since you are doing a number of changes to all the sunxi files, I have
one more request for something that has been bugging me a while:

In your .dtsi files, you define devices like this:

                uart0: serial at 01c28000 {
                        compatible = "snps,dw-apb-uart";
                        reg = <0x01c28000 0x400>;
                        interrupts = <0 1 4>;
                        reg-shift = <2>;
                        reg-io-width = <4>;
                        clocks = <&apb1_gates 16>;
                        status = "disabled";
                };

and in the .dts files, you extend them like this:

                uart0: serial at 01c28000 {
                        pinctrl-names = "default";
                        pinctrl-0 = <&uart0_pins_a>;
                        status = "okay";
                };


which duplicates both the node names with their full path, and
the labels. Please use one or the other, but not both. I don't mind
you having the full path to each device in the dts files, just drop
all the labels in that case. Most other maintainers these days
just use the labels like this in the dts files however:

&uart0 {
	status = "okay";
};

which also seems completely fine.

I'm also a bit puzzled by all the pinctrl references you add in the .dts
files, but it's possible I'm missing something there. Why can't you move
these to the .dtsi files and avoid duplicating the pinctrl-0 and
pinctrl-names properties for every .dts file? I would assume that they
are not referenced for disabled devices.

	Arnd
