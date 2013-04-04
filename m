From: dgilbert@interlog.com (Douglas Gilbert)
Date: Thu, 04 Apr 2013 13:03:04 -0400
Subject: [PATCH v3] ARM: at91: add Acme Systems Aria G25 board
In-Reply-To: <1365090153-1807-1-git-send-email-nicolas.ferre@atmel.com>
References: <20130402184947.GA8015@quad.lixom.net>
 <1365090153-1807-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <515DB248.6070105@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-04-04 11:42 AM, Nicolas Ferre wrote:
> From: Douglas Gilbert <dgilbert@interlog.com>
>
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Hi all,
>
> Here is the third revision of this patch. I plan to include it in a
> pull-request real-soon-now!
>
> v3: - move to "at91-" prefix for .dts[i] files
>      - remove the rtc activation code because of the ongoing discussions
>        about this IP and its DT binding.
>

Nicolas,
It's a pity that the rtc activation code is removed.
At worst:
                         rtc at fffffeb0 {
                                 status = "okay";
                         };

does nothing. Also it is unlikely to be changed by any
movement on the rtc-at91rm9200 front.


The lack of use of uart1 is for my own, private reasons.
I think it would be more generally useful to show uart1's
definition and disable it as shown in the attached patch
fragment.


I also note that my date line was removed. I like dates,
so when I add comments like "the i2c-at91 driver is broken
for the SAM9G20 ** and use the i2c-gpio driver instead" then
this is not taken as an eternal truth. It worked in the
past and hopefully it will work again in the future.

While on the subject of I2C, I'm getting tired of seeing
this oft-copied line:
    i2c-gpio,delay-us = <2>;        /* ~100 kHz */

It is the clock half period in microseconds and for the 100 kHz
(standard) I2C clock speed, it should be 5. Due to rounding
(up) that gives a measured clock speed of around 88 kHz on
my equipment. Crappy I2C devices *** seem to cope better
with 12% below the standard clock frequency than 80% above
it.

Doug Gilbert

** broken in my tests on the FoxG20 with lk 3.9.0-rc5

*** if my experience is anything to go by there are many
     dodgy I2C devices, probably using I2C bit banging
     code borrowed from Wikipedia.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: ariag25_390rc5_dg1.patch
Type: text/x-patch
Size: 1031 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130404/d55f77f4/attachment.bin>
