From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 20 Sep 2014 20:43:14 +0200
Subject: [PATCH 4/7] clk: add clk-asm9260 driver
In-Reply-To: <541DC21D.7050303@rempel-privat.de>
References: <1410646408-28901-1-git-send-email-linux@rempel-privat.de>
 <1410646408-28901-5-git-send-email-linux@rempel-privat.de>
 <20140917135440.GG27054@piout.net>
 <541A7FE1.8060202@rempel-privat.de>
 <20140918075650.GB29620@piout.net>
 <541DC21D.7050303@rempel-privat.de>
Message-ID: <20140920184313.GH29620@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/09/2014 at 20:06:21 +0200, Oleksij Rempel wrote :
> Am 18.09.2014 um 09:56 schrieb Alexandre Belloni:
> > You can have a look at how it has been done for the berlin SoCs to see
> > how you can easily reuse code between drivers.
> 
> What is the correct way to handle/define i2s MCLK input? I have I2S mux
> clock with choice of 3 sources: Xtal, PLL and MCLK. One of pins can be
> configured as MCLK src. Should i define fixedrate-clk?
> 

It depends on where is your mux, if it is in the I2S controller adress
range, I would simply give 3 parent clocks to your I2S controller, like:

i2s at 8fffffff {
 compatible = "...";
 reg = <0x8fffffff 0x100>;
 clocks = <&xtal, &clkc CLKID_MCK, &clkc CLKID_PLL>;
}

If it is part of your clock generator, then simply register a clock mux
with 3 parents as part of your clock controller binding. And use
something like:
 clocks = <&clck CLKID_I2S>;

Have a look at how this is done for berlin2, search for
clk_register_mux()

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
