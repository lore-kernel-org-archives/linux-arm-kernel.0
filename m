From: padma.kvr@gmail.com (Padma Venkat)
Date: Wed, 28 Nov 2012 11:21:31 +0530
Subject: [GIT PULL] ASoC: Samsung: Updates for v3.8
In-Reply-To: <001601cdcd28$ce5204c0$6af60e40$@com>
References: <001601cdcd28$ce5204c0$6af60e40$@com>
Message-ID: <CAAgF-Bfv46Xt0hFdPmviCdZbpje1M4MBnmCsHGgdOjcq4SnuJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Nov 28, 2012 at 10:55 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:
>> > There's some problems with this binding.  The main one is the gpios
>> > property the format of which isn't specified at all.
>
>> All of above gpio property is i2s.
>> That is,
>> +     gpios = <&gpz 0 2 0 0>, -> SCLK
>> +             <&gpz 1 2 0 0>,   ->  CDCLK
>> +             <&gpz 2 2 0 0>,   -> LRCK
>> +             <&gpz 3 2 0 0>,   -> SDI
>> +             <&gpz 4 2 0 0>,   -> SDO[0]
>> +             <&gpz 5 2 0 0>,   -> SDO[1]
>> +             <&gpz 6 2 0 0>;   -> SDO[2]
>
>> Do you want like a below one?
>> +sclk-gpios = <&gpz 0 2 0 0>,
>> +cdclk-gpios = <&gpz 1 2 0 0>, ...
>
> That would be nice but what I was really looking for was some indiciation in the binding document as
> to what all this stuff means - it should really say what gpz is (though I can figure that out) and
> it definitely needs to say what the four numbers are.
>
>> > The requirement for an alias is also very odd, where does that come from?
>
>> I don't know that Which one is odd. Please let me know.
>
> Having them at all is odd - it's not something other DT bindings have needed and there was nothing
> saying what it was for.

What is the exact requirement here? Should I remove the alias ids or
I2S1 and I2S2 nodes as they are in disabled state? This is done same
way as SPI and I2C. Please explain me.

>
>> > Some of the code also looks very peculiar, like the fact that it's
>> > generating a clock name i2s_opclk%d rather than hard coding the
>> > clock, the physical clock would normally be resolved based on the
>> > struct device.
>
>> This is to handle all of Samsung SOCs i2c clock mux.
>> Please look at below clk_lookup table
>
>> In case of 6410, clk_lookup
>> +     CLKDEV_INIT("samsung-i2s.0", "i2s_opclk0", &clk_i2s0),
>> +     CLKDEV_INIT("samsung-i2s.0", "i2s_opclk1", &clk_audio_bus0.clk),
>> +     CLKDEV_INIT("samsung-i2s.1", "i2s_opclk0", &clk_i2s1),
>> +     CLKDEV_INIT("samsung-i2s.1", "i2s_opclk1", &clk_audio_bus1.clk),
>> +#ifdef CONFIG_CPU_S3C6410
>> +     CLKDEV_INIT("samsung-i2s.2", "i2s_opclk0", &clk_i2s2),
>> +     CLKDEV_INIT("samsung-i2s.2", "i2s_opclk1", &clk_audio_bus2.clk),
>
>> In case of exynos5, clk_lookup
>> +     CLKDEV_INIT("samsung-i2s.0", "i2s_opclk0", &exynos5_clk_sclk_i2s.clk),
>> +     CLKDEV_INIT("samsung-i2s.0", "i2s_opclk1",
>> +&exynos5_clk_i2s_bus.clk),
>
>> We try to handle clock source of i2s by only i2s_opclk0 and i2s_opclk1.
>> Each SOCs have different clock source.
>> Is this wrong approach?
>
> That makes sense but why is the driver not just requesting by name rather than having code to
> generate the names, and why is this mixed in with the patch adding DT support?
>

Thanks
Padma
