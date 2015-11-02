From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 2 Nov 2015 18:11:33 +0100
Subject: [PATCH v8 1/2] arm-soc: Import initial tango4 device tree
In-Reply-To: <yw1xk2q09yrj.fsf@unicorn.mansr.com>
References: <56377E76.2080209@sigmadesigns.com>
 <56377ED5.4070203@sigmadesigns.com> <yw1xk2q09yrj.fsf@unicorn.mansr.com>
Message-ID: <56379945.6020407@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2015 17:01, M?ns Rullg?rd wrote:

> There are about a dozen more clocks that will be needed eventually.  Do
> you have a plan for how to add them?  (My driver already has support for
> most of them.)

Can you tell me which clocks (for which device) you've needed on the smp8759?

>> +	periphclk: periphclk {
> 
> Why is this not in the clocks block above?

It was something the clk maintainer said that made me move it, but I can't
find it anymore. I can move it back if that's the consensus.

>> +		compatible = "fixed-factor-clock";
>> +		clocks = <&clkgen 0>;
>> +		clock-mult = <1>;
>> +		clock-div  = <2>;
> 
> Some Sigma source code I found on the Internet uses a divisor of 3.
> Which is correct?

I was told 2.

>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
> 
> Put interrupt-parent = <&irq0> here and save repeating it for each device.

Each device can have either irq0, irq1, or irq2 as the parent, right?
The old code tried to do IRQ load-balancing "by hand". I had the vague
idea that I would set some devices to irq0, others to irq1, and have
irq_i interrupt CPU_i. Does that make no sense?

>> +		tick-counter at 10048 {
>> +			compatible = "sigma,tick-counter";
> 
> This compatible name is too vague.  What if the next Sigma chip has a
> completely different counter?

When this happens, I could switch to the generic method you've proposed.

>> +		eth0: ethernet at 26000 {
>> +			reg = <0x26000 0x800>;
>> +			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-parent = <&irq0>;
>> +			clocks = <&clkgen 1>;
>> +		};
> 
> Missing compatible string.

It's not missing, it's elsewhere.
(But maybe I did it wrong.)

>> +		intc: interrupt-controller at 6e000 {
>> +			reg = <0x6e000 0x400>;
>> +			ranges = <0 0x6e000 0x400>;
>> +			interrupt-parent = <&gic>;
>> +			interrupt-controller;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
> 
> Missing compatible string.
> 
>> +			irq0: irq0 at 6e000 {
> 
> The node name should be interrupt-controller at 000, similarly below.

<confused> I changed that a long time ago, and Arnd didn't flag it.
I'll put whatever the arm-soc maintainers say.

>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		enable-method = "sigma,tango4-smp";
> 
> This enable-method is too vague.  The next chip might be different.

What string do you propose?
What if I don't expect any other tango4 chip?

> The device tree should mention the SCU.

I left it out because I thought it was the firmware's responsibility.
I will double-check with the firmware author.

>> +&eth0 {
>> +	compatible = "sigma,smp8758-ethernet", "sigma,smp8734-ethernet", "sigma,smp8642-ethernet", "aurora,nb8800";
> 
> It's odd to specify the compatible string here.  It certainly won't
> change between different boards using the same chip.  Also, in the
> latest version of my driver, tango3 and tango4 are unfortunately not
> compatible.  The incompatibility only showed up once I enabled the L2
> cache.  I don't know quite what's going on.

IIUC, I should move the compatible string to the SoC-specific DTS?
And I should remove "sigma,smp8642-ethernet"?

>> +	phy-connection-type = "rgmii";
>> +	max-speed = <1000>;
> 
> You should have a node for the PHY here.

I'm using your old ethernet driver for the time being. I just compile the
appropriate PHY driver, and everything works as expected. What will the
PHY node in DT bring?

>> +&intc {
>> +	compatible = "sigma,smp8758-intc", "sigma,smp8642-intc";
> 
> Wrong place for the compatible string.

IIUC, I should move the compatible string to the SoC-specific DTS?

Regards.
