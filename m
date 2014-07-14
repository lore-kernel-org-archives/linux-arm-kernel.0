From: benoit.thebaudeau.dev@gmail.com (=?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Mon, 14 Jul 2014 14:56:06 +0200
Subject: gpio-mxc gpio get always returns 0 for outputs for IMX6
In-Reply-To: <20140714070341.GC2197@dragon>
References: <CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com>
 <20140714070341.GC2197@dragon>
Message-ID: <CA+sos7_quvZo6j9rFPvgCdYsEx6RoUNPUyvxE74K4vaNWDkGyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

On Mon, Jul 14, 2014 at 9:04 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> Copy more i.MX people ...
>
> On Fri, Jul 11, 2014 at 08:34:19AM -0700, Tim Harvey wrote:
>> Shawn,
>>
>> I've noticed that for IMX6 the gpio-mxc gpio driver always returns 0
>> for gpio's configured as outputs regardless of if they are outputing
>> high or low.
>>
>> Digging into gpio-mxc.c I see that the basic memory-mapped generic
>> gpio controller is used, but its configured to use GPIO_PSR to obtain
>> the gpio value. For the IMX6 (I can't speak for the other MXC/IMX
>> users of this driver) the reference manual indicates that GPIO_PSR is
>> appropriate only if the GPIO is an input and that GPIO_DR will read
>> the proper state if its configured as an output or an input.
>
>
> The following note can be found in i.MX Reference Manual.
>
>                         NOTE
> While the GPIO direction is set to input (GPIO_GDIR = 0), a
> read access to GPIO_DR does not return GPIO_DR data.
> Instead, it returns the GPIO_PSR data, which is the
> corresponding input signal value.
>
> That said for an input GPIO, reading GPIO_DR functionally equals to
> reading GPIO_PSR.  So reading either GPIO_DR or GPIO_PSR returns what we
> want to get.
>
> The remain question is what we want to get from an output GPIO, the
> value that register GPIO_DR holds or the one driven on pad.  I *think*
> both should be identical (but not so sure).  If that's the case, reading
> GPIO_DR should just work.  But otherwise, we should read GPIO_PSR with
> SION bit set to get what is actually driven on pad.
>
>>
>> Even before the driver was converted to use the basic memory-mapped
>> generic gpio controller this was the case (GPIO_PSR used for get). Is
>> there a reason for this, or is it simply a bug that has been around
>> since the driver's original creation as I suspect?
>>
>> The following patch resolves the issue and causes gpio get to always
>> return the proper setting when configured for an input or output:
>>
>> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
>> index 7176743..25b97db 100644
>> --- a/drivers/gpio/gpio-mxc.c
>> +++ b/drivers/gpio/gpio-mxc.c
>> @@ -458,8 +458,8 @@ static int mxc_gpio_probe(struct platform_device *pdev)
>>         }
>>
>>         err = bgpio_init(&port->bgc, &pdev->dev, 4,
>> -                        port->base + GPIO_PSR,
>> -                        port->base + GPIO_DR, NULL,
>> +                        port->base + GPIO_DR,
>> +                        NULL, NULL,
>>                          port->base + GPIO_GDIR, NULL, 0);
>>         if (err)
>>                 goto out_iounmap;
>>
>> If this looks right to you for all IMX users let me know and I'll post
>> a properly formatted patch with commit message.
>
> So the question comes down to, for an output GPIO, whether the value in
> GPIO_DR register is always identical to what we see on the pad.  If yes,
> your patch makes sense to me.  Otherwise, we have to set SION bit to
> read the value of an output GPIO from GPIO_PSR.

Both are not always the same. They should be the same only for sane
hardware. GPIO_DR indicates the level that the output pad tries to
drive, while GPIO_PSR indicates the level sensed on the pad. Thus,
they may differ if there is an external level conflict on the pin.
This difference may be useful in order to test if the board is
behaving as expected or if there is anything going wrong, which is
typically useful for board prototyping.

The software "knows" what it has set on the output pad, so having a
get accessor for GPIO_PSR is more useful than for GPIO_DR, and it
better fits the actual meaning of this function. GPIO_DR would
correspond to the non-existing gpio_get_set_value() function.

Best regards,
Beno?t
