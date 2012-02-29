From: hs@denx.de (Heiko Schocher)
Date: Wed, 29 Feb 2012 07:42:51 +0100
Subject: [PATCH v2 1/7] ARM: davinci,
 intc: Add OF support for TI interrupt controller
In-Reply-To: <4F44DE24.30606@mvista.com>
References: <1329893410-24413-1-git-send-email-hs@denx.de>
 <1329893410-24413-2-git-send-email-hs@denx.de> <4F44DE24.30606@mvista.com>
Message-ID: <4F4DC8EB.7010201@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sergei,

Sergei Shtylyov wrote:
> On 22-02-2012 10:50, Heiko Schocher wrote:
> 
>> Add a function to initialize the davinci interrupt controller (INTC)
>> using a device tree node.
> 
>    cp_intc is not DaVinci interrupt controller, it's only used in
> OMAP-L1x SoCs. cp_intc stands for Common Platform Interrupt Controller.

Ah, Ok! Thanks for the explanation.

> I don't see where you are initializiing the DaVinci interrupt controller
> itself. You should understand that there are two disctinct types of
> interrupt controllers used in the SoCs supported by arch/arm/mach-davinci/.

board code:

MACHINE_START(ENBW_CMC, "EnBW CMC")
[...]
        .init_irq       = davinci_init_irq,

and in arch/arm/mach-davinci/cp_intc.c

for the of case:

void __init davinci_init_irq(void)
{
        of_irq_init(irq_match);
}

in drivers/of/irq.c:

/**
 * of_irq_init - Scan and init matching interrupt controllers in DT
 * @matches: 0 terminated array of nodes to match and init function to call
 *
 * This function scans the device tree for matching interrupt controller nodes,
 * and calls their initialization functions in order with parents first.
 */
void __init of_irq_init(const struct of_device_id *matches)

Ok, the name of davinci_init_irq() is missleading ...

Should I name it "cp_intc_of_init" ?

>> Signed-off-by: Heiko Schocher<hs@denx.de>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Sekhar Nori<nsekhar@ti.com>
>> Cc: Wolfgang Denk<wd@denx.de>
> 
> [...]
> 
>> diff --git a/Documentation/devicetree/bindings/arm/davinci/intc.txt
>> b/Documentation/devicetree/bindings/arm/davinci/intc.txt
>> new file mode 100644
>> index 0000000..dac2f69
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/davinci/intc.txt
>> @@ -0,0 +1,26 @@
>> +* TI Davinci Interrupt Controller
>> +
>> +davinci are using a TI interrupt controller that can support several
>> +configurable number of interrupts.
>> +
>> +Main node required properties:
>> +
>> +- compatible : should be:
>> +    "ti,davinci-intc"
> 
>    The right "compatible" prop would be "ti,cp_intc" in this case.

Ok, change this.

Thanks for the review!

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
