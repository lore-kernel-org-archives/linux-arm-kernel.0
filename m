From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 15 Mar 2013 12:58:32 +0000
Subject: [PATCH v3 06/11] ARM: vexpress: use clocksource_of_init for sp804
In-Reply-To: <20130315123408.GJ4977@n2100.arm.linux.org.uk>
References: <1363151142-32162-7-git-send-email-haojian.zhuang@linaro.org>
 <1363173037.3100.22.camel@hornet>
 <CAD6h2NQWB3+1QepQjBE0BZiG44YAQRi7e-9+oZvVYpYV8QycDA@mail.gmail.com>
 <1363175175.3100.37.camel@hornet>
 <CAD6h2NSUyFvhoqMsYqT=rzFZ--MWv+0vHOCtAV9n-5YO+LNTMA@mail.gmail.com>
 <1363186087.3100.72.camel@hornet>
 <CAD6h2NRkS4qk+iqbWhaOpBHmjSYOB=YBbfNkn0X3jzNawzgNEA@mail.gmail.com>
 <1363187979.3100.93.camel@hornet>
 <CAD6h2NTufx2rRwbwsgGHN42t7+_KL418++zk_C++EvFKU+ZwLg@mail.gmail.com>
 <5140AA01.1010007@gmail.com> <20130315123408.GJ4977@n2100.arm.linux.org.uk>
Message-ID: <1363352312.3100.175.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-03-15 at 12:34 +0000, Russell King - ARM Linux wrote:
> However, for SP804 selection, there are cases where it matters, such as
> on Versatile Express where you have to select the right set of SP804 to
> have a working system (because ARM didn't fully document the SP804 setup
> there) and we have no way to switch some of those timers from their
> 32kHz clock source.  But then we could just omit the clock source for
> the "bad" SP804s which would prevent them being used.

Both VE motherboard's SP804s TIMCLKENx inputs are fed by the SP810's
outputs:

v2m_timer01: timer at 11000 {
	compatible = "arm,sp804", "arm,primecell";
	reg = <0x11000 0x1000>;
	interrupts = <2>;
	clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&smbclk>;
	clock-names = "timclken1", "timclken2", "apb_pclk";
};      

v2m_timer23: timer at 12000 {
	compatible = "arm,sp804", "arm,primecell";
	reg = <0x12000 0x1000>;
	interrupts = <3>;
	clocks = <&v2m_sysctl 2>, <&v2m_sysctl 3>, <&smbclk>;
	clock-names = "timclken1", "timclken2", "apb_pclk";
};

TIMCLKs are wired to the SMB_CLK, so the effective rate depends on the
TIMCLKENx only.

The SP810 takes the 32kHz and 1MHz reference clocks:

v2m_sysctl: sysctl at 01000 {
	compatible = "arm,sp810", "arm,primecell";
	reg = <0x01000 0x1000>;
	clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&smbclk>;
	clock-names = "refclk", "timclk", "apb_pclk";
	#clock-cells = <1>;
	clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
};

and the code in drivers/clk/versatile/clk-vexpress.c picks up the faster
one as the parent.

The V2P-CA9 SP804's TIMCLK is wired to one of the main clock generators:

timer at 100e4000 {
	compatible = "arm,sp804", "arm,primecell";
	reg = <0x100e4000 0x1000>;
	interrupts = <0 48 4>,
	             <0 49 4>;
	clocks = <&oscclk2>, <&oscclk2>;
	clock-names = "timclk", "apb_pclk";
};

Both TIMCLKEN0 & 1 are pulled up to 1 so they have no effect on the
timer rates.

Overall, the description of the VE clocking in the Device Tree is rather
complete.

Pawe?
