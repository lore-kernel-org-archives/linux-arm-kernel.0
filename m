From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 02 Jul 2013 13:35:33 +0200
Subject: [PATCHv3 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
In-Reply-To: <CAOMZO5CLcT=OXYd=ggxpDzUqFxoXSaanqUPGugYLT2Og-VgzCA@mail.gmail.com>
References: <1372094699-3832-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372094699-3832-3-git-send-email-alexandre.belloni@free-electrons.com>
 <CAOMZO5CLcT=OXYd=ggxpDzUqFxoXSaanqUPGugYLT2Og-VgzCA@mail.gmail.com>
Message-ID: <51D2BB05.9040201@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/07/2013 04:45, Fabio Estevam wrote:
> Are you able to use the mxs i2c controller instead of bitbang if you
> use this patch?
> http://www.spinics.net/lists/stable/msg13202.html
> 

Actually, it gets worse. I'm probably doing something wrong but I get:

mxs-i2c 8005a000.i2c: Failed to get PIO reg. write descriptor.

That is the one line 243. I'm open to any suggestion.

BTW, I also tested PIO mode with and without touchscreen support as that
seemed to toggle the issue on your side. It is also worse than what it
was in 3.9. Trying to read the nau7802 ADC never returns.

The excerpt from my DT:

i2c1: i2c at 8005a000 {
	pinctrl-names = "default";
	pinctrl-0 = <&i2c1_pins_a>;
	status = "okay";
};

i2cmux {
	compatible = "i2c-mux-gpio";
	#address-cells = <1>;
	#size-cells = <0>;
	pinctrl-names = "default";
	pinctrl-0 = <&i2cmux_pins_cfa10049>;
	mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
	i2c-parent = <&i2c1>;

	i2c at 0 {
		reg = <0>;
		#address-cells = <1>;
		#size-cells = <0>;

		adc0: nau7802 at 2a {
			compatible = "nuvoton,nau7802";
			reg = <0x2a>;
			nuvoton,vldo = <3000>;
		};
	};

[...]


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
