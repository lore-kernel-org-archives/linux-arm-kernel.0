From: jan.kiszka@web.de (Jan Kiszka)
Date: Mon, 10 Jul 2017 19:31:24 +0200
Subject: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
In-Reply-To: <20170710120913.g35ftcbs7pngrtsm@sirena.org.uk>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ@mail.gmail.com>
 <20170710120913.g35ftcbs7pngrtsm@sirena.org.uk>
Message-ID: <cb21c69b-6f22-4c06-b308-16bd6895f1a9@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-07-10 14:09, Mark Brown wrote:
> On Sun, Jul 09, 2017 at 12:48:10AM +0300, Andy Shevchenko wrote:
>> On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka@web.de> wrote:
> 
>>> Tested on the IOT2000 where the second SPI bus is connected to an
>>> Arduino-compatible connector and multiplexed between SPI, GPIO and PWM
>>> usage.
> 
>> Can we first switch the driver to use GPIO descriptors instead of
>> plain integers?
> 
> Only if you also convert the SPI core to use descriptors, Chris Packham
> was looking at that but he needed update the ep93xx drivers among others
> and getting reviewers was hard.
> 

IIUC, we can't convert completely due to some legacy boards providing
their CS lines as integers. But even then, a few more API usages can be
converted.

While looking into this, I noticed that this patch violated the formal
rule to never release a GPIO with the old API when it was requested with
the new one. That's at least stated in the docs, even though gpio_free
is equivalent to gpiod_put. Fixed that already, but I need to find some
time to retest.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170710/ba806053/attachment.sig>
