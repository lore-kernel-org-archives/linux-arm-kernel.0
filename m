From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jan 2014 15:13:31 +0100
Subject: [PATCH] ARM: iop32x: fix reset handling for the EM7210 board
In-Reply-To: <87txcneyi6.fsf@lebrac.rtp-net.org>
References: <1390999545-31428-1-git-send-email-linus.walleij@linaro.org>
 <87txcneyi6.fsf@lebrac.rtp-net.org>
Message-ID: <CACRpkdaLVNg_ZEju8=+5kQ0CbRj=5X5tQ8OTPeZF2Fp_C3BSwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 1:57 PM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:

> Linus Walleij <linus.walleij@linaro.org> writes:
>
> don't know how to comment about the subjet but it's _not_ about
> resetting the board but about powering it off.

Aha sorry I'll respin with updated text.

>>       register_iop32x_gpio();
>>       platform_device_register(&em7210_serial_device);
>>       platform_device_register(&iop3xx_i2c0_device);
>> @@ -194,7 +202,9 @@ static void __init em7210_init_machine(void)
>>
>>       i2c_register_board_info(0, em7210_i2c_devices,
>>               ARRAY_SIZE(em7210_i2c_devices));
>> -
>> +     ret = gpio_request(EM7210_HARDWARE_RESET, "reset");
>> +     if (ret)
>> +             pr_err("could not request reset GPIO\n");
>
> no chance to work. too early. you'll get a -EPROBE_DEFER.

Yeah that's right, I remember now that I added a separate
device_initcall() on the N2100 for this. Thanks, I'll respin that.

Yours,
Linus Walleij
