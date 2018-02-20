From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Feb 2018 11:49:41 +0100
Subject: [PATCH 3/9] serial: imx: Fix out-of-bounds access through DT alias
In-Reply-To: <20180220103134.xfh2zl2vgonb2ywb@pengutronix.de>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-4-git-send-email-geert+renesas@glider.be>
 <20180220103134.xfh2zl2vgonb2ywb@pengutronix.de>
Message-ID: <CAMuHMdVMoEuOOffRNHDa0JwaLH1auByOQfNW8DgkXGaq5GFnsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, Feb 20, 2018 at 11:31 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Feb 20, 2018 at 10:40:18AM +0100, Geert Uytterhoeven wrote:
>> The imx_ports[] array is indexed using a value derived from the
>> "serialN" alias in DT, which may lead to an out-of-bounds access.
>>
>> Fix this by adding a range check.
>>
>> Fixes: 9206ab8a0350c3da ("serial: imx: Fix out-of-bounds access through DT alias")
>
> huh, this patch fixes itself?

Oops

    Fixes: ff05967a07225ab6 ("serial/imx: add of_alias_get_id() reference back")

>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/tty/serial/imx.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 1d7ca382bc12b238..e89e90ad87d8245c 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -2041,6 +2041,11 @@ static int serial_imx_probe(struct platform_device *pdev)
>>               serial_imx_probe_pdata(sport, pdev);
>>       else if (ret < 0)
>>               return ret;
>
> I'd prefer an empty line here.

OK

>> +     if (sport->port.line >= UART_NR) {
>
> I would have used:
>
>         if (sport->port.line >= ARRAY_SIZE(imx_ports))
>
> which IMHO is better understandable

OK.

>> +             dev_err(&pdev->dev, "serial%d out of range\n",
>> +                     sport->port.line);
>
> Note that the same overflow can happen when a device is probed using
> platform data (and your commit fixes that, too). Maybe worth to point
> out in the commit log?

That's correct. But board code is tied more intimate to the kernel.
Will update.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
