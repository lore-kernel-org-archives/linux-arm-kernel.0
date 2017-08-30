From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 30 Aug 2017 19:42:28 +0200
Subject: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
In-Reply-To: <CABxcv=nqbNsTs7D57VOt1-Tav_3i9U=XKn=BV=hPr1tG68eE2g@mail.gmail.com>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
 <20170828160121.gu4wf7jqu4ditksc@ninjato>
 <CABxcv=kSiqDN1=9fSfLkyW=uuXQZAoW4dhw=fco9RyOdDuPAdA@mail.gmail.com>
 <20170829084831.hsdok3ksi7anxzuc@ninjato>
 <CABxcv=nqbNsTs7D57VOt1-Tav_3i9U=XKn=BV=hPr1tG68eE2g@mail.gmail.com>
Message-ID: <20170830174228.sx5jgtxxy56zq47t@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 06:19:02PM +0200, Javier Martinez Canillas wrote:
> Hello Wolfram,
> 
> On Tue, Aug 29, 2017 at 10:48 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> >> I don't have a DT based system at hand now, but I'll test it again and
> >> let you know probably tomorrow.
> >
> > I will try again today, too. Thanks!
> >
> 
> Ok, I had some time to do some tests again. I used an ARM Chromebook
> (Exynos Peach Pi) that has an I2C touchpad (Atmel maXTouch).

I tried again as well and it still fails for me.

> Tested the following cases:

I think we should talk about the same case: Let me repeat what I did:

1) I added your patch "eeprom: at24: Add OF device ID table"
2) I added an EEPROM node to an I2C

+       eeprom at 50 {
+               compatible = "renesas,24c01";
+               reg = <0x50>;
+       };

-> no at24 binding to the device

3) I revert your patch

-> at24 binding to the device

I think you should be able to test this DTS snipplet even without a real
eeprom. Especially after applying this to the at24 driver.

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 79c5c39be29cac..f9f547680c53db 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -805,11 +805,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	 * Perform a one-byte test read to verify that the
 	 * chip is functional.
 	 */
-	err = at24_read(at24, 0, &test_byte, 1);
-	if (err) {
-		err = -ENODEV;
-		goto err_clients;
-	}
 
 	at24->nvmem_config.name = dev_name(&client->dev);
 	at24->nvmem_config.dev = &client->dev;


Can you check this?

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170830/ff0f0039/attachment.sig>
