From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Mar 2018 10:44:21 +0100
Subject: [RFC PATCH] iio: adc: Add Xilinx AMS driver
In-Reply-To: <20180317181936.14468be2@archlinux>
References: <1521124947-18950-1-git-send-email-mnarani@xilinx.com>
 <20180316201925.GA18013@himanshu-Vostro-3559>
 <20180317181936.14468be2@archlinux>
Message-ID: <CAMuHMdULXP1fxKmf9rx0ebxs-e82MOoRRZ9tSHeS4CZn3ZZfCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2018 at 7:19 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Sat, 17 Mar 2018 01:49:25 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
>
>> On Thu, Mar 15, 2018 at 08:12:27PM +0530, Manish Narani wrote:
>> > The AMS includes an ADC as well as on-chip sensors that can be used to
>> > sample external voltages and monitor on-die operating conditions, such as
>> > temperature and supply voltage levels. The AMS has two SYSMON blocks.
>> > PL-SYSMON block is capable of monitoring off chip voltage and temperature.
>> > PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring from
>> > external master. Out of these interface currently only DRP is supported.
>> > Other block PS-SYSMON is memory mapped to PS.
>> >
>> > The AMS can use internal channels to monitor voltage and temperature
>> > as well as one primary and up to 16 auxiliary channels for measuring
>> > external voltages.
>> >
>> > The voltage and temperature monitoring channels also have event
>> > capability which allows to generate an interrupt when their value
>> > falls below or raises above a set threshold.
>> >
>> > Signed-off-by: Manish Narani <mnarani@xilinx.com>
>> > ---
>>
>> [..]
>>
>> > +static const struct of_device_id ams_of_match_table[] = {
>> > +       { .compatible = "xlnx,zynqmp-ams", &ams_pl_apb },
>> > +       { }
>> > +};
>> > +MODULE_DEVICE_TABLE(of, ams_of_match_table);
>>
>> [..]
>>
>> > +static int ams_probe(struct platform_device *pdev)
>> > +{
>> > +       struct iio_dev *indio_dev;
>> > +       struct ams *ams;
>> > +       struct resource *res;
>> > +       const struct of_device_id *id;
>> > +       int ret;
>> > +
>> > +       if (!pdev->dev.of_node)
>> > +               return -ENODEV;
>> > +
>> > +       id = of_match_node(ams_of_match_table, pdev->dev.of_node);
>> > +       if (!id)
>> > +               return -ENODEV;
>>
>> Is the above check required ?
>>
>> Isn't the probe function called if and only if a match is found in
>> ams_of_match_table[] since it is a pure OF driver ?
>>
>> And therefore the above condition would never happen!
> Agreed in principle.  However, from a reviewer point of view, it is sometimes
> easier to have an error check that can never happen than have to check whether
> or not it can.  Hence I'd keep this in place (well actually not because there
> are better ways of doing this block of code, but that is unconnected to your
> comment Himanshu!)

You can avoid the intermediate (and avoid reviewers wondering ;-) by just
writing instead:

    ams->pl_bus = of_device_get_match_data(&pdev->dev);


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
