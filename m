From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 8 Oct 2013 20:09:54 +0530
Subject: [PATCH V3] clk: palmas: add clock driver for palmas
In-Reply-To: <525408B3.1000107@ti.com>
References: <1381238480-18852-1-git-send-email-ldewangan@nvidia.com>
 <525408B3.1000107@ti.com>
Message-ID: <5254193A.70104@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Nishanth for review.

On Tuesday 08 October 2013 06:59 PM, Nishanth Menon wrote:
> On 10/08/2013 08:21 AM, Laxman Dewangan wrote:
>> Palmas devices has two clock output CLK32K_KG and CLK32K_KG_AUDIO
> not all palmas devices have 2 clocks - example: tps659038

This is for generic palmas and I have seen it for TPS65913, TPS65914, 
TPS80036. If the generic one is not compatible then it need to add  
device specific and at that time, it is require to update the binding 
document accordingly.

>           |    7 +
>   drivers/clk/Makefile                               |    1 +
>   drivers/clk/clk-palmas.c                           |  340 ++++++++++++++++++++
>
> http://www.spinics.net/lists/devicetree/msg04855.html
> Do we do 2 patches now? one seperate for binding and implementation?
> What is our current preference now a days?

Currently it is implementation + binding doc in one patch.

>
>>   Palmas device has two clock output pins for 32KHz, KG and KG_AUDIO.
>> +
>> +This binding uses the common clock binding ./clock-bindings.txt.
> proper link would be to provide
> Documentation/devicetree/bindings/clock/clock-bindings.txt ?

Hmm, other patch I got feedback from DT maintainers to do not use the 
absolute path as document directory may change

>> +
>> +Clock 32KHz KG is output 0 of the driver and clock 32KHz is output 1.
>> +
>> +Required properties:
>> +- compatible : shall be "ti,palmas-clk".
> To handle variants of Palmas chips in production, you'd want to be
> specific here clk32k_kg and clk32k_kg_audio.

The compatible is the device sub module level, not the clock level. Same 
thing we are following on regulators.


>
>> +
>> +     Optional subnode properties:
>> +     ti,clock-boot-enable: Enable clock at the time of booting.
> Dumb question: Why is this needed? should'nt relevant drivers do a
> clk_get to enable the relevant clocks?

If some board needs this clock to be always available for rest of system 
to work without any specific driver then this flag is useful.


>
>> +     ti,external-sleep-control: The clock is enable/disabled by state
>> +             of external enable input pins ENABLE, ENABLE2 and NSLEEP.
>> +             The valid value for the external pins are:
>> +                     1 for ENABLE1
>> +                     2 for ENABLE2
>> +                     3 for NSLEEP.
> could we not have macros for readability?

I am thinking of adding the palmas for dt-binding and then change on 
multiple places. I will post patches for this.
the patch will go on dt tree as include/dt-bindings and then on 
documents file and then on actually DTS. I will work towards this but 
scoping out of this patch.


>
>> +
>> +
>> +enum PALMAS_CLOCK32K {
>> +     PALMAS_CLOCK32KG,
>> +     PALMAS_CLOCK32KG_AUDIO,
>> +
>> +     /* Last entry */
>> +     PALMAS_CLOCK32K_NR,
>> +};
> you should be able to get rid of this entirely

Probably yes but it is easy to read (atleast for me).


>
> +             cinfo->clk = clk;
> +             palmas_clks->clk_data.clks[i] = clk;
> +             palmas_clks->clk_data.clk_num++;
> +             palmas_clks_init_configure(cinfo);
> we dont handle error here?

Intentionally I ignore error, just print and continue the registration.


>
>> +
>> +MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
>> +MODULE_LICENSE("GPL v2");
>>
> I wonder if we can simplify this with CLK_OF_DECLARE - I suppose it
> wont work if of_clk_init(NULL); was invoked previously.

This driver has dependency over the mfd driver and hence until mfd 
driver invoked and get registered, this driver should not be called. The 
platform driver registration is done in mfd.
As per my understanding and referring the other code, CLK_OF_DECLARE is 
useful if there is no such dependency. Please correct me if this is not 
true.
