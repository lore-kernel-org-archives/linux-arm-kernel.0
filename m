From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Feb 2014 16:27:16 +0100
Subject: [PATCH v2] pwm: add CSR SiRFSoC PWM driver
In-Reply-To: <CAGsJ_4xmtt2Pg_mHJmvt9uc3Y4gN7KUT1UOJhbr6FQYdiAH3qw@mail.gmail.com>
References: <1391061145-2078-1-git-send-email-21cnbao@gmail.com>
 <201401311623.56902.arnd@arndb.de>
 <CAGsJ_4xmtt2Pg_mHJmvt9uc3Y4gN7KUT1UOJhbr6FQYdiAH3qw@mail.gmail.com>
Message-ID: <201402061627.17086.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 February 2014, Barry Song wrote:
> > How about modeling  that other source as a fixed-rate clock in DT
> > then?
> 
> sirfsoc clock drivers have a clock node for OSC whose index is "1".
> do you think the following is the right way to handle?
> 
> in dts, put both pwm controller clock and OSC
> 672                         pwm: pwm at b0130000 {
> 673                                 compatible = "sirf,prima2-pwm";
> 674                                 #pwm-cells = <2>;
> 675                                 reg = <0xb0130000 0x10000>;
> 676                                 clocks = <&clks 21>,  <&clks 1>;
> 677                                 clock-names = "pwmc", "osc";
> 678                         };
> 
> and in pwm-sirf.c driver, use
> clk = clk_get(dev, "osc");
> clk_get_rate(clk);
> 
> to get the rate in probe()?

Ah, if that's the right clock, it sounds great, yes.

Just make sure that the clock-names values make sense from the
point of view of the pwm node, rather than referring to the
name given in the clock provider.

	Arnd
