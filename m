From: gianlucarenzi@eurekelettronica.it (gianluca)
Date: Fri, 20 Feb 2015 16:53:32 +0100
Subject: [PATCH 7/7] serial: imx: add support for half duplex rs485
In-Reply-To: <20150220153411.GP19388@pengutronix.de>
References: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424292068-28197-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAFeThoCahCMGniG59k4Le3E-4P+TEi_7dxUagKWzc20WAvkMuA@mail.gmail.com>
 <20150219093752.GO19388@pengutronix.de>
 <CAFeThoC2+SGc1ZgQhbBx-pxxzpRJ-61n_fs8BZo8ChFcti3Vqw@mail.gmail.com>
 <20150220153411.GP19388@pengutronix.de>
Message-ID: <54E7587C.3060508@eurekelettronica.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
speaking of serial patch for rs485, I wrote a device driver for mxs 
(iMX28): (it is half-duplex too)

It rely on device tree node as:

>> 				rs485_tx_en: rx485-tx-en {
>> 					fsl,pinmux-ids = <
>> 						0x2133 /* MX28_PAD_SSP2_SS0__GPIO_2_19 UART2_DIR */
>> 					>;
>> 					fsl,drive-strength = <0>;
>> 					fsl,pull-up = <1>;
>> 				};


and this:

>> 			auart2: serial at 8006e000 {
>> 				compatible = "fsl,imx28-ekuart";
>> 				pinctrl-names = "default";
>> 				pinctrl-0 = <&auart2_2pins_a
>> 					&rs485_tx_en>;
>> 				rs485-rts-active-low;
>> 				rts-gpio = <&gpio2 19 1>;
>> 				linux,rs485-enabled-at-boot-time;
>> 				rs485-rts-delay = <0 0>;
>> 				status = "okay";
>> 			};

And in attachment the driver. The hr_timer implementation is working 
correctly even with a big load and 3/4 serials at the time.

Give it a look if you want.

On 02/20/2015 04:34 PM, Uwe Kleine-K?nig wrote:
> On Thu, Feb 19, 2015 at 10:45:47AM +0100, aur?lien bouin wrote:
>> I hope this link will be ok :
>> http://marc.info/?l=linux-kernel&m=142366865609389&q=raw
> Good heavens, this patch is broken. It depends on user space to get the
> reference counting for the gpio right if at all. It uses a reserved part
> of the struct serial_rs485 while being driver specific. It ignores
> gpio_request returning an error (well, it does a dev_err in this case,
> but continues to use the gpio). It does change how frame error are
> handled even if rs485 is off without mentioning in the changelog.
>
> Are you aware what happens if a user issues the rs485 callback without
> being aware that padding[0] has this meaning?
>
> I'm sorry, I like my patch better.
>
> Best regards
> Uwe
>


-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mxs_ekuart.c
Type: text/x-csrc
Size: 40090 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150220/549c4bd2/attachment-0001.bin>
