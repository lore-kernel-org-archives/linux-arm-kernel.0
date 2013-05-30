From: linux@baker-net.org.uk (Adam Baker)
Date: Fri, 31 May 2013 00:19:01 +0100
Subject: Kirkwood CPU Freq driver
In-Reply-To: <20130528215126.GF7678@lunn.ch>
References: <51A12DD4.9010907@baker-net.org.uk>
 <20130526083614.GB26249@lunn.ch>
 <20130526180513.GF31290@titan.lakedaemon.net>
 <51A5234D.9030100@baker-net.org.uk> <20130528215126.GF7678@lunn.ch>
Message-ID: <51A7DE65.4090108@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/05/13 22:51, Andrew Lunn wrote:
>> I've now tested with the first of these patches applied and the
>> >changes from the second added to my .config
>> >
>> >To get it to work I had to follow the instructions in the
>> >Documentation to add the cpus entry to kirkwood.dtsi so I'll post
>> >that as a patch in a day or two but after doing that I have a
>> >working cpufreq driver.
> Great that you got it working. Something must of changed in the
> generic code, since originally a cpu node was not required.
>
> The clocks are not needed in node, so please don't list them.
>
Andrew, I just tried testing without the clocks line in the .dtsi and I 
get the messages below in dmesg

[   18.554990] ERROR: could not get clock /cpus/cpu at 0:cpu_clk(0)
[   18.560840] kirkwood-cpufreq kirkwood-cpufreq: Unable to get cpuclk
[   18.567154] kirkwood-cpufreq: probe of kirkwood-cpufreq failed with 
error -2

looking at the code in kirkwood_cpufreq_probe() this is what I would 
expect. Unless I've missed something the driver is simply advertising 
that it needs those clocks and as they presumably are not gateable it 
may be safe to not bother reserving them but I don't know the code well 
enough to make that decision.

Having now looked at the range of kirkwood SoCs I see oretthat there is 
a 88F632X family that include 2 processor cores. The cpus definitions 
therefore theoretically ought to live in kirkwood-6281.dtsi and 
kirkwood-6282.dtsi. The only 2 boards I can see that don't include one 
of those two at present are kirkwood-km for which the SoC data isn't 
published and kirkwood-nsa310 which seems to simply be missing pinmux 
information for things like the sata ports.

Would everyone prefer to see the cpus node in the 628x.dtsi files or 
should it go in kirkwood.dtsi until support for the 88F632X family is added?

Regards

Adam
