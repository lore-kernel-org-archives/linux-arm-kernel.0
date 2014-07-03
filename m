From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 04 Jul 2014 00:28:44 +0200
Subject: [PATCH 1/4] clk: add pxa27x clock drivers
In-Reply-To: <CAN1soZzoiGAz3OicdKbg5Dv2tW3yeinsu2i=M7KX+j1HuMs3Kg@mail.gmail.com>
 (Haojian Zhuang's message of "Thu, 3 Jul 2014 14:12:11 +0800")
References: <1404066744-13416-1-git-send-email-robert.jarzmik@free.fr>
 <1404066744-13416-2-git-send-email-robert.jarzmik@free.fr>
 <CAN1soZzoiGAz3OicdKbg5Dv2tW3yeinsu2i=M7KX+j1HuMs3Kg@mail.gmail.com>
Message-ID: <87ha2ynkkj.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@gmail.com> writes:

> On Mon, Jun 30, 2014 at 2:32 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> +static struct pxa27x_clocks_var_rate pxa27x_var_rate_clocks[] __initdata = {
>> +       PXA2_VAR_RATE("pxa2xx-fb", true, LCD, &clk_pxa27x_lcd_ops),
>> +       PXA2_VAR_RATE("pxa27x-camera.0", true, CAMERA, &clk_pxa27x_lcd_ops),
>> +       PXA2_VAR_RATE("pxa2xx-pcmcia", false, MEMC, &clk_pxa27x_mem_ops),
>> +};
>> +
>
> It's not good to define a VAR table any more.
>
> Now we have the common clock framework. Since these three clocks are
> used as clock
> gate. And their clock frequency is controlled by other bits in
> peripheral controller registers.
I understand the clock hierarchy part.

> We can define parent & child clocks in clock tables. I think that you
> can get a lot of
> reference in clock drivers, such as exynos, hisilicon, ...
>
> Same comment on PXA_FIXED_RATE table.
That's a bit of work which will be thrown away anyway.
The goal is :
 - keep same level of clock functionnality in non-DT builds
 - have the full clock framework power for DT builds
 - have non-DT builds removed once everything is ported to device-tree

Therefore, I don't want to redefine the full clock hierarchy in non-DT
builds. That's a lot of work for nothing. This patchset doesn't aim at a full
clock rework part, it aims at enabling porting all PXA platforms to DT without
breaking the non-DT part.

For DT, we already have this type of clock tree :
\u@\h:\w\$ cat /sys/kernel/debug/clk/clk_summary 
   clock                         enable_cnt  prepare_cnt        rate   accuracy
--------------------------------------------------------------------------------
 clk_dummy                                1            1           0          0
    im                                    0            0           0          0
 osc32_768khz                             1            1       32768          0
    keypad                                1            1       32768          0
 osc13mhz                                 3            3    13000000          0
    lcd                                   0            0    52000000          0
       camera                             0            0    52000000          0
    memory                                0            0   104000000          0
    system bus                            0            0   104000000          0
    cpu core                              0            0   104000000          0
    halt-turbo mode                       0            0    52000000          0
    turbo mode                            0            0   104000000          0
    run mode                              0            0   104000000          0
    clk_ostimer                           1            1     3250000          0
       nssp,ostimer                       1            1     3250000          0
    clk_13mhz                             2            2    13000000          0
       ssp1                               0            0    13000000          0
       pwri2c                             1            1    13000000          0
       ssp3,hwuart                        0            0    13000000          0
       ssp2                               0            0    13000000          0
       pwm 1,3                            0            0    13000000          0
       pwm 0,2                            1            1    13000000          0
    pll_312mhz                            3            3   312000000          0
       clk_14_682mhz                      0            0    12235294          0
          i2s                             0            0    12235294          0
       clk_14_857mhz                      1            3    14857142          0
          btuart                          1            2    14857142          0
          ffuart                          0            1    14857142          0
          stuart                          0            1    14857142          0
       clk_19_5mhz                        0            0    19500000          0
          memstk                          0            0    19500000          0
          mmc                             0            0    19500000          0
       clk_32_842mhz                      1            1    32842105          0
          i2c                             1            1    32842105          0
       clk_48mhz                          1            1    48000000          0
          usim                            0            0    48000000          0
          msl                             0            0    48000000          0
          ficp                            0            0    48000000          0
          usb udc                         1            1    48000000          0
          usb host,assp                   0            0    48000000          0

Cheers.

-- 
Robert
