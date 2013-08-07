From: christophe.leroy@c-s.fr (leroy christophe)
Date: Wed, 07 Aug 2013 17:20:18 +0200
Subject: MAX7301 GPIO: Do not force SPI speed when using OF Platform
In-Reply-To: <5202418B.5090203@antcom.de>
References: <51EFAA19.4020905@antcom.de> <52022FFF.3060507@c-s.fr>
 <52023AE2.3020007@antcom.de> <52023EF9.3050301@c-s.fr>
 <5202418B.5090203@antcom.de>
Message-ID: <520265B2.3080403@c-s.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 07/08/2013 14:46, Roland Stigge a ?crit :
> Hi,
>
> On 08/07/2013 02:35 PM, leroy christophe wrote:
>>>> spi-bits = <16>;
>>> I tried this, both in the device's and in the controller's node. But it
>>> didn't work. However, as described, I didn't expect it to work, because
>>> there is no code present to handle "spi-bits". At least not in 3.10.
>>>
>>> Am I missing something? Otherwise, maybe something of the tree that you
>>> are talking about is missing from mainline still?
>>>
>>>
>> Strange. I'm using 3.8.13
>> I have it handled in drivers/spi/spi.c in function
>> of_register_spi_devices()
> 3.8.13's (as well as newer ones') drivers/spi/spi.c doesn't handle
> "spi-bits", see also
>
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/drivers/spi/spi.c?h=linux-3.8.y
>
> Maybe you have additional patches that are not in mainline, yet?
>
> Thanks,
>
> Roland
>
Yes you are right, I have the attached patch in addition which have been 
in our code for long time and which has never been submitted for 
inclusion in the mainline kernel.
Sorry about that, I will submit it.

Regards
Christophe
-------------- next part --------------
--- linux-3.8.13/drivers/spi/spi.c	2013-05-11 22:57:46.000000000 +0200
+++ linux/drivers/spi/spi.c	2013-08-06 18:15:34.000000000 +0200
@@ -870,6 +870,11 @@
 		if (of_find_property(nc, "spi-3wire", NULL))
 			spi->mode |= SPI_3WIRE;
 
+		/* Bits per word */
+		prop = of_get_property(nc, "spi-bits", &len);
+		if (prop && len >= sizeof(*prop)) {
+			spi->bits_per_word = prop[0];
+		}
 		/* Device speed */
 		prop = of_get_property(nc, "spi-max-frequency", &len);
 		if (!prop || len < sizeof(*prop)) {
