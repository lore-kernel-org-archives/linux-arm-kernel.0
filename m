From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 4 Apr 2013 20:08:29 -0300
Subject: [RFC PATCH] CLK: Allow parent clock and rate to be configured in
 DT.
In-Reply-To: <20130325101707.GZ1906@pengutronix.de>
References: <20130319170933.28337.50448.stgit@localhost>
 <20130325101707.GZ1906@pengutronix.de>
Message-ID: <CAOMZO5ASkvquyzPCEGObvB5Xh9bDPTJ2zx26eOUJT_Vb36Bn3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Mar 25, 2013 at 7:17 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

>> +For example:
>> +     clock-configuration {
>> +             compatible = "clock-configuration";
>> +             clko1 {
>> +                     clocks = <&clks 160>; /* cko1_sel */
>> +                     parent = <&clks 114>; /* pll3_sw */
>> +             };
>> +
>> +             esdhca {
>> +                     clocks = <&clks 102>; /* esdhc_a_podf */
>> +                     clock-frequency = <200000000>;
>> +             };
>
> This example shows this. For some reason we adjust the esdhc frequency
> to 200MHz in the code currently, but this is because it matches our
> current usecase. Once you move this into devicetree, we can't change
> this anymore in the kernel, even if we find a much better way to adjust
> the frequency in the future (i.e. smaller values might be good for power
> savings, higher values might increase performance, we even might
> dynamically change this frequency).

What if we use Martin's idea, but without the "clock-frequency" option
and only pass the parent information? This way the driver can find the
better clock as you described. Something like:

     clock-parent {
             compatible = "clock-parent";
             clko1 {
                     clocks = <&clks 160>; /* cko1_sel */
                    parent = <&clks 114>; /* pll3_sw */
             };

This could be useful for removing the imx6q_sabrelite_cko1_setup()
function from arch/arm/mach-imx/mach-imx6q.c.

I would like to add audio support for another board and would like to
avoid to do the same as imx6q_sabrelite_cko1_setup()  for setting up
the CLKO, if possible.

Regards,

Fabio Estevam
