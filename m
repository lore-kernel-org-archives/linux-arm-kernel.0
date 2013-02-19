From: zonque@gmail.com (Daniel Mack)
Date: Tue, 19 Feb 2013 10:53:18 +0100
Subject: Question about fixed-clock
In-Reply-To: <CAOMZO5BXVX8=QOV4+tN_w27ztSVkHAnOG2ifbS_Jpd=-cPnAdw@mail.gmail.com>
References: <5122BF88.1050007@gmail.com>
 <CAOMZO5BXVX8=QOV4+tN_w27ztSVkHAnOG2ifbS_Jpd=-cPnAdw@mail.gmail.com>
Message-ID: <51234B8E.2000504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,
Hi Afzal,

On 19.02.2013 02:33, Fabio Estevam wrote:
> On Mon, Feb 18, 2013 at 8:55 PM, Daniel Mack <zonque@gmail.com> wrote:
>> Hi,
>>
>> This might be a stupid question, but I'm somehow stuck here. I'm using a
>> driver with the following DTS sub-node:
>>
>>         ref25: ref25M {
>>                 compatible = "fixed-clock";
>>                 #clock-cells = <0>;
>>                 clock-frequency = <25000000>;
>>         };
>>
>>         clock-generator at 0 {
>>                                 /* ... */
>>                                 #clock-cells = <1>;
>>                                 clocks = <&ref25>;
>>         }
>>
>> The device driver for clock-generator uses something like the following
>> call to get its clock:
>>
>>         clk = of_clk_get(np, 0);
>>
>> but the return value is ERR_PTR(-ENOENT) and I also can't find this
>> clock in the clk debugfs tree.
>>
>> This is on a OMAP/AM33xx device with kernel 3.8-rc7 plus the -next tips
>> of arm-soc and omap, but with no other special clock options selected in
>> the config. Is there anything I'm missing to correctly instantiate the
>> dummy clock?
> 
> Have you registered it with clk_register_fixed_rate() ?
> 
> In imx we use imx_clk_fixed, which in turns call  clk_register_fixed_rate().
> 
> Take a look at arch/arm/mach-imx/clk-imx51-imx53.c for a reference.

Hmm no, I didn't do anything else than adding it to the DT in the first
place, hoping that a driver will pick it up and add the clock for me.
But it turns out that of_clk_init() is not called at all on my platform.

I'm doing this now from omap_generic_init() and it works. If that's an
appropriate place to call it, I can provide a patch.


Thanks,
Daniel
