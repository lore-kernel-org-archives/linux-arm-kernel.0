From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 31 Jan 2014 20:05:49 +0800
Subject: [PATCH v2] pwm: add CSR SiRFSoC PWM driver
In-Reply-To: <201401302049.27521.arnd@arndb.de>
References: <1391061145-2078-1-git-send-email-21cnbao@gmail.com>
 <201401302049.27521.arnd@arndb.de>
Message-ID: <CAGsJ_4xFKytv=Mj9eVwGY7RjyUy2W=iSXvnULKyBETYVzMVbOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-01-31 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 30 January 2014, Barry Song wrote:
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 7acab93..0a252f8 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -166,6 +166,15 @@ config PWM_SAMSUNG
>>         To compile this driver as a module, choose M here: the module
>>         will be called pwm-samsung.
>>
>> +config PWM_SIRF
>> +     tristate "SiRF PWM support"
>> +     depends on ARCH_SIRF
>> +     help
>
> please make this "depends on ARCH_SIRF || COMPILE_TEST" if you can, so we
> can build it on other platforms for test purposes. If you do this, you
> have to list the full set of dependencies, so probably another
> "depends on HAVE_CLK".

sounds good. it seems we can have this for other PWM drivers as well?

>
>> +
>> +#define to_sirf_chip(chip)   container_of(chip, struct sirf_pwm, chip)
>> +
>> +static unsigned int sirf_pwm_ns_to_cycles(struct pwm_chip *chip, unsigned int time_ns)
>> +{
>> +     u64 dividend;
>> +     unsigned int cycle;
>> +     /*
>> +      * on SiRFSoC, OSC input is const, we use it as the source to generate
>> +      * PWM wave
>> +      */
>> +#define SRC_OSC_RATE 26000000ULL
>> +     dividend = SRC_OSC_RATE * time_ns + NSEC_PER_SEC / 2;
>> +     do_div(dividend, NSEC_PER_SEC);
>> +
>> +     cycle = dividend & 0xFFFFFFFFUL;
>> +
>> +     return cycle > 1 ? cycle : 1;
>> +}
>> +
>
> Is SRC_OSC_RATE the rate of spwm->clk? If so, it would be nice to just call
> clk_get_rate() here, in case you ever have a chip with a different rate.
>

SRC_OSC_RATE is the fixed frequency of crystal oscillator, but
spwm->clk comes from the IO bus. the design is a little strange, pwm
channels don't use the clock of PWM controller to generate
period/duty, but use other sources.

> This is a very nice driver otherwise!
>
>         Arnd

-barry
