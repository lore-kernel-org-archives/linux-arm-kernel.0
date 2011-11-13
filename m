From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 13 Nov 2011 22:53:18 +0100
Subject: [PATCH] RS485: fix inconsistencies in the meaning of some
 variables
In-Reply-To: <4EBA9385.7010806@evidence.eu.com>
References: <4E492CFF.7040905@pwrnet.de> <20110822211832.GA8023@kroah.com>
 <4EB3A009.10502@evidence.eu.com> <4EB8F6B9.6010008@atmel.com>
 <4EB90902.4030200@evidence.eu.com>
 <20111108134804.07095c5d@lxorguk.ukuu.org.uk>
 <20111108142432.GA11293@kroah.com>
 <4EBA9385.7010806@evidence.eu.com>
Message-ID: <20111113215318.GA2966@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have been working on a patch series which adds hardware RS485 to the 8250
according to the latest developments. The series will be posted tomorrow after
some more tests. However, there is one thing I wondered about:

> From now on, SER_RS485_RTS_AFTER_SEND and SER_RS485_RTS_ON_SEND will be used to
> set the voltage of the RTS pin (as in the crisv10.c driver); the delay will be
> understood by looking only at the value of delay_rts_before_send and 
> delay_rts_after_send.

Do I overlook something or is SER_RS485_RTS_AFTER_SEND always the inverted
signal of SER_RS485_RTS_ON_SEND. So why do we need both? (BTW
SER_RS485_RTS_ON_SEND is a non-obvious name, I think. But changing it will
probably break even more users?)

> diff --git a/include/linux/serial.h b/include/linux/serial.h
> index 97ff8e2..3d86517 100644
> --- a/include/linux/serial.h
> +++ b/include/linux/serial.h
> @@ -207,13 +207,15 @@ struct serial_icounter_struct {
>  
>  struct serial_rs485 {
>  	__u32	flags;			/* RS485 feature flags */
> -#define SER_RS485_ENABLED		(1 << 0)
> -#define SER_RS485_RTS_ON_SEND		(1 << 1)
> -#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
> -#define SER_RS485_RTS_BEFORE_SEND	(1 << 3)
> +#define SER_RS485_ENABLED		(1 << 0)	/* If enabled */
> +#define SER_RS485_RTS_ON_SEND		(1 << 1)	/* Logical level for
> +							   RTS pin when
> +							   sending */
> +#define SER_RS485_RTS_AFTER_SEND	(1 << 2)	/* Logical level for
> +							   RTS pin after sent*/

Nit: 80 char should be broken here, because that is not readable. Or put the
comment above the define.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111113/76fe5548/attachment.sig>
