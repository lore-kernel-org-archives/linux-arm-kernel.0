From: linux@rempel-privat.de (Oleksij Rempel)
Date: Thu, 15 Jan 2015 10:45:32 +0100
Subject: [PATCH] ARM: clk: add clk-asm9260 driver
In-Reply-To: <20150114230217.22722.88458@quantum>
References: <1417187120-23659-1-git-send-email-linux@rempel-privat.de>
 <1420707567-22760-1-git-send-email-linux@rempel-privat.de>
 <1420707567-22760-2-git-send-email-linux@rempel-privat.de>
 <20150114230217.22722.88458@quantum>
Message-ID: <54B78C3C.1080109@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.01.2015 um 00:02 schrieb Mike Turquette:
> Quoting Oleksij Rempel (2015-01-08 00:59:27)
>> diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
>> new file mode 100644
>> index 0000000..6b1c220
>> --- /dev/null
>> +++ b/drivers/clk/clk-asm9260.c
> 
> <snip>
> 
>> +static const char *clk_names[] = {
>> +       [REFCLK]        = "oscillator",
>> +       [SYSPLL]        = "pll",
>> +       [I2S0_MCLK]     = "i2s0_mclk",
>> +       [I2S1_MCLK]     = "i2s1_mclk",
>> +       [RTC_OSC]       = "rtc_osc",
>> +       [USB_PLL]       = "usb_pll",
>> +};
> 
> Why keep this list of names? Only clk_names[REFCLK] is used below and it
> is overwritten by the name supplied by DT.

Ok.

> <snip>
> 
>> +static void __init asm9260_acc_init(struct device_node *np)
>> +{
>> +       struct clk *clk;
>> +       u32 rate;
>> +       int n;
>> +       u32 accuracy = 0;
>> +
>> +       base = of_io_request_and_map(np, 0, np->name);
>> +       if (!base)
>> +               panic("%s: unable to map resource", np->name);
>> +
>> +       /* register pll */
>> +       rate = (ioread32(base + HW_SYSPLLCTRL) & 0xffff) * 1000000;
>> +
>> +       clk_names[REFCLK] = of_clk_get_parent_name(np, 0);
>> +       accuracy = clk_get_accuracy(__clk_lookup(clk_names[REFCLK]));
>> +       clk = clk_register_fixed_rate_with_accuracy(NULL, clk_names[SYSPLL],
>> +                       clk_names[REFCLK], 0, rate, accuracy);
> 
> This is different. Why do the PLLs inherit REFCLKs accuracy? Please see
> __clk_recalc_accuracies in drivers/clk/clk.c if you haven't already. We
> propagate accuracy through the clock tree already.

clk_register_fixed_rate overwrite accuracy to 0. If i use
clk_register_fixed_rate, then half of my clocks has accuracy = 0.

>> +
>> +       if (IS_ERR(clk))
>> +               panic("%s: can't register REFCLK. Check DT!", np->name);
>> +

<snip>

>> +
>> +       /* register clk-provider */
>> +       clk_data.clks = clks;
>> +       clk_data.clk_num = MAX_CLKS;
>> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>> +       return;
>> +fail:
>> +       iounmap(base);
>> +}
>> +CLK_OF_DECLARE(asm9260_acc, "alphascale,asm9260-clock-controller",
>> +               asm9260_acc_init);
> 
> Where is the DT binding definition for this clock provider?
> 
> Thanks,
> Mike
> 

do you mean this patch?
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/293147.html
(probably not last version)
Should i resend it to you?

-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/922f2d38/attachment.sig>
