From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 30 Aug 2017 18:19:02 +0200
Subject: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
In-Reply-To: <20170829084831.hsdok3ksi7anxzuc@ninjato>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
 <20170828160121.gu4wf7jqu4ditksc@ninjato>
 <CABxcv=kSiqDN1=9fSfLkyW=uuXQZAoW4dhw=fco9RyOdDuPAdA@mail.gmail.com>
 <20170829084831.hsdok3ksi7anxzuc@ninjato>
Message-ID: <CABxcv=nqbNsTs7D57VOt1-Tav_3i9U=XKn=BV=hPr1tG68eE2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On Tue, Aug 29, 2017 at 10:48 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> I don't have a DT based system at hand now, but I'll test it again and
>> let you know probably tomorrow.
>
> I will try again today, too. Thanks!
>

Ok, I had some time to do some tests again. I used an ARM Chromebook
(Exynos Peach Pi) that has an I2C touchpad (Atmel maXTouch).

Tested the following cases:

1) Driver without OF device ID table (only a I2C table with a
"maxtouch" entry) and DTS defining a device node with a
"atmel,maxtouch" compatible string. This is the case without any of
the patches in this series.

$ modinfo drivers/input/touchscreen/atmel_mxt_ts.ko | grep maxtouch
alias:          i2c:maxtouch

$ grep maxtouch /sys/devices/platform/soc/12e00000.i2c/i2c-8/8-004b/uevent
OF_COMPATIBLE_0=atmel,maxtouch
MODALIAS=i2c:maxtouch

2) Driver without OF device ID table (only a I2C table with a
"maxtouch" entry) and DTS defining a device node with a
"atmel,maxtouch", "generic,maxtouch" compatible string. This is the
case when platform maintainers merge the DTS patches without the
driver patch.

$ modinfo drivers/input/touchscreen/atmel_mxt_ts.ko | grep maxtouch
alias:          i2c:maxtouch

$ grep maxtouch /sys/devices/platform/soc/12e00000.i2c/i2c-8/8-004b/uevent
OF_COMPATIBLE_0=atmel,maxtouch
OF_COMPATIBLE_1=generic,maxtouch
MODALIAS=i2c:maxtouch

3) Driver with an OF device ID table (with a "generic,maxtouch" entry)
and DTS defining a device node with a "atmel,maxtouch" compatible
string. This is the case when the driver patch is merged without the
DTS patches.

$ modinfo drivers/input/touchscreen/atmel_mxt_ts.ko | grep maxtouch
alias:          of:N*T*Cgeneric,maxtouchC*
alias:          of:N*T*Cgeneric,maxtouch
alias:          i2c:maxtouch

$ grep maxtouch /sys/devices/platform/soc/12e00000.i2c/i2c-8/8-004b/uevent
OF_COMPATIBLE_0=atmel,maxtouch
MODALIAS=i2c:maxtouch

4) Driver with an OF device ID table (with a "generic,maxtouch" entry)
and DTS defining a device node with a "atmel,maxtouch",
"generic,maxtouch" compatible string. This is the case when both the
DTS and driver patches are merged.

$ modinfo drivers/input/touchscreen/atmel_mxt_ts.ko | grep maxtouch
alias:          of:N*T*Cgeneric,maxtouchC*
alias:          of:N*T*Cgeneric,maxtouch
alias:          i2c:maxtouch

$ grep maxtouch /sys/devices/platform/soc/12e00000.i2c/i2c-8/8-004b/uevent
OF_COMPATIBLE_0=atmel,maxtouch
OF_COMPATIBLE_1=generic,maxtouch
MODALIAS=i2c:maxtouch

For all cases module autoload, driver probe and evtest worked for me.

You said that (3) doesn't work but I don't understand why is failing
for you. Probably I'm missing something.

Best regards,
Javier
