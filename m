From: claudio@evidence.eu.com (Claudio Scordino)
Date: Fri, 04 Nov 2011 09:19:21 +0100
Subject: [PATCH] RS485: fix inconsistencies in the meaning of some variables
In-Reply-To: <20110822211832.GA8023@kroah.com>
References: <4E492CFF.7040905@pwrnet.de> <20110822211832.GA8023@kroah.com>
Message-ID: <4EB3A009.10502@evidence.eu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan, Hi Greg,

	it seems that the crisv10.c and the atmel_serial.c serial
drivers interpret the fields of the serial_rs485 structure in a different
way.

In particular, it seems that crisv10.c uses SER_RS485_RTS_AFTER_SEND and
SER_RS485_RTS_ON_SEND for the _logic value_ of the RTS pin;
atmel_serial.c, instead, uses these values to know if a _delay_ must be
set before and after sending.

This patch makes the usage of these variables consistent across all
drivers and fixes the Documentation as well.
In particular, SER_RS485_RTS_AFTER_SEND and SER_RS485_RTS_ON_SEND will
be used to set the logic value of the RTS pin (as in the crisv10.c
driver); the delay is understood by looking only at the value of
delay_rts_before_send and delay_rts_after_send.

Best regards,

	Claudio


Subject: RS485: fix inconsistencies in the meaning of some variables
From: Claudio Scordino <claudio@evidence.eu.com>

The crisv10.c and the atmel_serial.c serial drivers interpret the fields
of the serial_rs485 structure in a different way.
In particular, crisv10.c uses SER_RS485_RTS_AFTER_SEND and 
SER_RS485_RTS_ON_SEND for the voltage of the RTS pin; atmel_serial.c, instead,
uses these values to know if a delay must be set before and after sending.
This patch makes the usage of these variables consistent across all drivers and
fixes the Documentation as well.
