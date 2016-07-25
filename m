From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Jul 2016 10:51:23 +0200
Subject: [PATCH 06/14] ARM: dts: sun8i: Add cpu0 label to sun8i-h3.dtsi
In-Reply-To: <e57eb018-ef31-408e-84b2-b329510352d0@googlegroups.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-7-megous@megous.com>
 <CAGb2v66eskVAxdz8VtjBJBCO7VV9WL4bdFDVrPWrSmxk4RASCw@mail.gmail.com>
 <adaf7f61-af80-cc02-8c47-af721b86f81e@megous.com>
 <CAGb2v665O75vQEfo5WdWtWJSbKEbLi6MBAHbgZC7pyrOCOu+6g@mail.gmail.com>
 <20160625070208.GA4000@lukather>
 <49ce09ae-052a-bb2b-ce66-f0aa0d0024e3@megous.com>
 <e57eb018-ef31-408e-84b2-b329510352d0@googlegroups.com>
Message-ID: <20160725085123.GH7419@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 07:10:54AM -0700, Thomas Kaiser wrote:
> Hi,
> 
> Ond?ej Jirman wrote:
> >
> > We have boards that have 1.1/1.3V switching, only 1.3V, fine tuned 
> > voltage regulation and every such board will need it's own set of 
> > operating points. 
> >
> 
> Yes, and Allwinner's current BSP kernel code might encourage board makers 
> to implement a forth variant: switching between 4 different voltages 
> through GPIOs.
> 
> Currently we have 4 boards that rely on the simple '2 voltage regulation' 
> all using 1.1V/1.3V: Orange Pi One and Lite and NanoPi M1 and NEO. Then 
> there are 2 devices with (legacy) Linux support existing that use no 
> voltage regulation at all: Banana Pi M2+ (according to schematic using 1.2V 
> but in reality it's 1.3V VDD_CPUX) and Beelink X2. And according to Tsvetan 
> if/when Olimex will release their 2 H3 boards we have two more with fixed 
> but yet unknown VDD_CPUX voltage (since olimex fears overheating maybe they 
> use 1.1V or 1.2V limiting max cpufreq to 816 or 1008 MHz). And all the 
> bigger H3 based Orange Pi use the SY8106A voltage regulator being able to 
> adjust VDD_CPUX in steps of 20mV allowing VDD_CPUX to exceed 1200 MHz (a 
> reasonable value seems to be 1296 MHz since above throttling will be an 
> issue without active cooling)

Ok, good to know. I'm not sure overclocking is ever a reasonable
solution, but that's a separate topic.

> Things get even worse since Xunlong uses copper layers inside the PCB to 
> spread the heat away from H3 so Orange Pi One/Lite do not overheat that 
> much like eg. NanoPi M1 (and maybe NEO -- can tell next week when I get dev 
> samples to play with). So while eg. Orange Pi One and NanoPi M1 switch 
> between the same voltages in the same way we (Armbian) found that we have 
> to allow M1 to downclock to even 240 MHz since when testing with legacy 
> kernel really heavy workloads led to throttling that low (even CPU cores 
> were killed at this low clockspeed -- same applies to BPi M2+ and Beelink 
> X2)

And that's what I really want to avoid. Even though that board
absolutely requires the 240MHz OPP to run properly, nothing prevents
from using that OPP on other boards as well, that will also benefit
from it. Thermal throttling is something that needs to be handled, but
power management is also something we should consider, and I see no
reason why not to have a consistent set of operating frequencies, even
though the voltage might differ depending on the regulator
capabilities.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/b2875ab5/attachment.sig>
