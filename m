From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue, 28 Aug 2012 11:27:08 -0700
Subject: [PATCH 2/2] tty: serial: imx: don't reinit clock with enabled
 console
In-Reply-To: <503CA183.70704@de.bosch.com>
References: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
 <1346053012-25686-3-git-send-email-dirk.behme@de.bosch.com>
 <503BBA5A.8040609@boundarydevices.com> <503CA183.70704@de.bosch.com>
Message-ID: <503D0D7C.2070509@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/28/2012 3:46 AM, Dirk Behme wrote:
> On 27.08.2012 20:20, Troy Kisky wrote:
>> On 8/27/2012 12:36 AM, Dirk Behme wrote:
>>> From: Xinyu Chen <xinyu.chen@freescale.com>
>>>
>>> Remove the imx_setup_ufcr() call on startup when CONSOLE enabled,
>>> as this will cause clock reinit, and output garbage.
>>>
>>> This patch is a port from Freescale's Android kernel.
>>>
>>> Signed-off-by: Xinyu Chen <xinyu.chen@freescale.com>
>>> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
>>> CC: Shawn Guo <shawn.guo@linaro.org>
>>> CC: Sascha Hauer <s.hauer@pengutronix.de>
>>> ---
>>>   drivers/tty/serial/imx.c |    2 ++
>>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>>> index 908178f..31ce414 100644
>>> --- a/drivers/tty/serial/imx.c
>>> +++ b/drivers/tty/serial/imx.c
>>> @@ -695,7 +695,9 @@ static int imx_startup(struct uart_port *port)
>>>       int retval;
>>>       unsigned long flags, temp;
>>>   +#ifndef CONFIG_SERIAL_CORE_CONSOLE
>>>       imx_setup_ufcr(sport, 0);
>>> +#endif
>>>         /* disable the DREN bit (Data Ready interrupt enable) before
>>>        * requesting IRQs
>>
>>
>> I'd rather do something like this
>>
>> static int imx_setup_ufcr(struct imx_port *sport, unsigned int mode)
>> {
>>          unsigned int val;
>>
>>          /* set receiver / transmitter trigger level. */
>>          val = readl(sport->port.membase + UFCR) & UFCR_RFDIV;
>
> Shouldn't it be
>
> ... & (UFCR_RFDIV | UFCR_DCEDTE);
>
> then? My i.MX6 manual has DCEDTE as bit 6, which we don't want to 
> touch, too? We only want to touch TXTL and RXTL?
>

If you do that, you should also change imx_set_termios
to possibly clear the bit

new_ufcr = (old_ufcr & (~UFCR_RFDIV)) | UFCR_RFDIV_REG(div);

to

new_ufcr = (old_ufcr & (~(UFCR_RFDIV | UFCR_DCEDTE))) | UFCR_RFDIV_REG(div);

>>          val |= TXTL << 10 | RXTL;
>>          writel(val, sport->port.membase + UFCR);
>>          return 0;
>> }
>>
>> There is no need for imx_setup_ufcr to change divisor.
>
> Ok
>
> Thanks
>
> Dirk
>
