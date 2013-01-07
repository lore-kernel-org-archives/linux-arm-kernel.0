From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 07 Jan 2013 10:43:38 +0100
Subject: [PATCH v3] mxs: uart: allow setting RTS from software
In-Reply-To: <50CA8E8C.5060906@freescale.com>
References: <1355405263-29625-1-git-send-email-s.trumtrar@pengutronix.de>
 <50CA8E8C.5060906@freescale.com>
Message-ID: <50EA98CA.1060303@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2012 03:27 AM, Huang Shijie wrote:
> ? 2012?12?13? 21:27, Steffen Trumtrar ??:
>> With the patch "serial: mxs-auart: fix the wrong RTS hardware flow control" the
>> mainline mxs-uart driver now sets RTSEN only when hardware flow control is
>> enabled via software. It is not possible any longer to set RTS manually via
>> software. However, the manual modification is a valid operation.
>> Regain the possibility to set RTS via software and only set RTSEN when hardware
>> flow control is explicitly enabled via settermios cflag CRTSCTS.
>>
>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> ---
>>  drivers/tty/serial/mxs-auart.c |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
>> index 6db23b0..9f63f88 100644
>> --- a/drivers/tty/serial/mxs-auart.c
>> +++ b/drivers/tty/serial/mxs-auart.c
>> @@ -412,10 +412,12 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
>>  
>>  	u32 ctrl = readl(u->membase + AUART_CTRL2);
>>  
>> -	ctrl &= ~AUART_CTRL2_RTSEN;
>> +	ctrl &= ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
>>  	if (mctrl & TIOCM_RTS) {
>>  		if (tty_port_cts_enabled(&u->state->port))
>>  			ctrl |= AUART_CTRL2_RTSEN;
>> +		else
>> +			ctrl |= AUART_CTRL2_RTS;
>>  	}
>>  
>>  	s->ctrl = mctrl;
> Reviewed-by: Huang Shijie <b32955@freescale.com>

This patch is not not in today's next. What's the current status? Who
will take it?

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130107/65c0ab15/attachment.sig>
