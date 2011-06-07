From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Jun 2011 09:28:53 +0200
Subject: [PATCH V2 1/3] drivers/pwm st_pwm: Add support for ST's Pulse
	Width Modulator
In-Reply-To: <4DEDA12D.6080406@st.com>
References: <cover.1306831238.git.viresh.kumar@st.com>
	<20110606173339.268b9f9c.akpm@linux-foundation.org>
	<4DEDA12D.6080406@st.com>
Message-ID: <201106070928.53761.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 June 2011 05:55:25 viresh kumar wrote:
> >> +static int __devinit st_pwm_probe(struct platform_device *pdev)
> > 
> > And here things get rather odd.
> > 
> > Most of this file is a generic, non-device specific PWM layer, exported
> > to other modules.  But then we get into driver bits which are specific
> > to one paritular type of device.  Confused - this is like putting the
> > e100 driver inside net/ipv4/tcp.c?
> > 
> 
> Sorry but i couldn't get this one completely. :(
> Driver is specific to pwm peripheral by ST. This driver can be used for
> SPEAr or may be other SoC or Devices, and is not at all dependent on SPEAr.


It was my suggestion to start drivers/pwm/ with this driver. We currently
have a number of pwm drivers spread over the entire tree, all using slight
the same interface header. They all look like this one, and are each used
on one SOC, so you have to choose at compile-time which one to use.

There are two problems with this of course:
1. the drivers that export the same interface should be in one directory
2. there should be a common abstraction layer to avoid duplicate code and
   enable building a kernel with multiple PWM drivers builtin.

Moving this driver to drivers/pwm is the first step to address the
problem 1, we will move the other drivers in the 3.1 or 3.2 timeframe.

There is independent by Sascha Hauer to work on the abstraction layer
for all the drivers. Once that is in, we will change the individual drivers
in drivers/pwm accordingly.

	Arnd
