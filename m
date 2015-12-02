From: slash.tmp@free.fr (Mason)
Date: Wed, 2 Dec 2015 23:14:29 +0100
Subject: Preprocessor arithmetic in dtsi files (base + offset)
In-Reply-To: <CAMuHMdX9JRRURMxmNFcKOkzeO1B5Nmnk+XnOpgcLsPbiG4CfSA@mail.gmail.com>
References: <56570620.3070106@free.fr>
 <20151126135957.GC8644@n2100.arm.linux.org.uk> <56571ACC.9080306@free.fr>
 <CAMuHMdX9JRRURMxmNFcKOkzeO1B5Nmnk+XnOpgcLsPbiG4CfSA@mail.gmail.com>
Message-ID: <565F6D45.6070201@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/11/2015 17:23, Geert Uytterhoeven wrote:

> I guess this would work, too?
> 
> scu_container at 20000000 {
>         compatible = "simple-bus";
> 
>         ranges = <0x0 0x20000000 0x10000>;
>         #address-cells = <1>;
>         #size-cells = <1>;
> 
>         scu: scu at 0 {
>                 compatible = "arm,cortex-a9-scu";
>                 reg = <0x0000 0x100>;
> 
>         gic: interrupt-controller at 1000 {
>                 compatible = "arm,cortex-a9-gic";
>                 reg = <0x1000 0x1000>, <0x0100 0x0100>;
> 
>         twd-timer at 0600 {
>                 compatible = "arm,cortex-a9-twd-timer";
>                 reg = <0x0600 0x10>;
> };
> 
> No more explicit arithmetic needed, just substitute "20000000".

I like it! Only one address to change in the next chip.
Minimizes the risk of missing something.

(I see that armada did something similar, but they also grouped
unrelated stuff. And bcm5301x did exactly what you suggested.)

Wondering if there are macro definitions for the intra-SCU offsets?
So I could have symbolic names, such as

  twd-timer at 0600 {
    reg = <TWD_OFFSET 0x10>

Didn't see anything appropriate in include and arch/arm.
Should I include my own definitions at the top of the dtsi?

Regards.
