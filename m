From: marex@denx.de (Marek Vasut)
Date: Mon, 6 Feb 2017 20:24:11 +0100
Subject: [PATCH] serial: imx: Only enable UART DMA on i.MX6Q and i.MX53
In-Reply-To: <20170205175132.GA2182@archie.localdomain>
References: <20170204213931.3566-1-marex@denx.de>
 <DB6PR0402MB2743C709F162BDE52429DF49E3410@DB6PR0402MB2743.eurprd04.prod.outlook.com>
 <CAOMZO5D8_vE+t=V6wHMKt590jZqJJRzeJ+_MLgqbLp=6gwsmyQ@mail.gmail.com>
 <20170205175132.GA2182@archie.localdomain>
Message-ID: <8c31d0ca-2893-b50c-5a8d-09ab5a6575fa@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2017 06:51 PM, Clemens Gruber wrote:
> On Sun, Feb 05, 2017 at 02:36:10PM -0200, Fabio Estevam wrote:
>> On Sun, Feb 5, 2017 at 12:56 PM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
>>> [Sorry, for the top-posting]
>>>
>>>
>>> imx6sx uart should be of a IMX6Q_UART instead.
>>>
>>>
>>> Does this patch fix the issue?
>>
>> It seems this dts change will not fix the problem.
>>
>>> From: Kai Ruhnau <kai.ruhnau@target-sg.com>
>>>
>>> In 1c06bde6 with the introduction of DMA support for the i.MX53 platform,
>>> DMA was enabled for all platforms instead. On an i.MX6SX (which is a
>>> IMX21_UART), this breaks gpsd talking to an UART module with
>>>
>>>  imx-uart 21f4000.serial: DMA transaction error.
>>>
>>> This patch makes sure, UART DMA is only activated for i.MX53 and i.MX6Q.
>>>
>>> Signed-off-by: Kai Ruhnau <kai.ruhnau@target-sg.com>
>>> Reviewed-by: Marek Vasut <marex@denx.de>
>>> Fixes: 1c06bde643d0 ("Allowing UART DMA to be configured on i.MX53")
>>> Cc: <stable@vger.kernel.org> # 4.9+
>>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>>> Cc: Martyn Welch <martyn.welch@collabora.co.uk>
>>> Cc: Shawn Guo <shawnguo@kernel.org>
>>> ---
>>>  drivers/tty/serial/imx.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>>> index a70356d..8e2b5f2 100644
>>> --- a/drivers/tty/serial/imx.c
>>> +++ b/drivers/tty/serial/imx.c
>>> @@ -1269,7 +1269,8 @@ static int imx_startup(struct uart_port *port)
>>>          writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
>>>
>>>          /* Can we enable the DMA support? */
>>> -       if (!uart_console(port) && !sport->dma_is_inited)
>>> +       if ((is_imx6q_uart(sport)  || is_imx53_uart(sport)) &&
>>> +           !uart_console(port) && !sport->dma_is_inited)
>>>                  imx_uart_dma_init(sport);
>>
>> Looks like imx serial DMA is broken in 4.9.
> 
> There are probably two separate problems:
> 
> A)
> I also observed the DMA transaction error message when I used the ROM
> SDMA scripts. Seems to affect single- and multi-core systems and is
> fixed by: github.com/Freescale/linux-fslc/commit/a2ec8df37f5d (?)
> This is also not RS-485 specific, but affects RS-232 too.

OK, thanks for the hint, but this is unrelated, since DMA should not be
enabled on MX6SX in 4.9 (but it is , due to the error in 1c06bde643d0 )
and newer.

If you want to enable/fix DMA on MX6SX , that should be a separate patch
which is a feature addition IMO.

> B)
> The RS-485 DMA problem I reported, which only affects multi-core
> systems.
> RS-232 DMA is not affected.

This has nothing to do with RS485/232 , the problem this patch fixes is
that the DMA is errornously enabled on MX6SX and it should not be .

[...]

-- 
Best regards,
Marek Vasut
