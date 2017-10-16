From: jwerner@chromium.org (Julius Werner)
Date: Mon, 16 Oct 2017 13:49:11 -0700
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <446301756.220218.1494678481761@email.1und1.de>
References: <172093673.40121.1492427140661@email.1und1.de>
 <CAD=FV=WJBTUcMPw8OgQT_jhz0H8AsH=YqWMR7LtudUKrF5-XOA@mail.gmail.com>
 <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
 <186569458.91967.1492547106553@email.1und1.de>
 <CAD=FV=VHkJFrsJDmMytbUw=WjKQaGZ-8Ewfy5bPCA82AWS4O2Q@mail.gmail.com>
 <212870399.174480.1492633502649@email.1und1.de>
 <87mvbaykn1.fsf@eliezer.anholt.net>
 <1998517910.54108.1492894253010@email.1und1.de>
 <2127594073.298820.1493143869792@email.1und1.de>
 <316369012.317772.1494274928708@email.1und1.de>
 <20170510163150.GK30445@localhost>
 <CAD=FV=VUaqtR2t04wodRJ33bqHo5DPke7zsvqBMYqZ5imX5+=A@mail.gmail.com>
 <446301756.220218.1494678481761@email.1und1.de>
Message-ID: <CAODwPW8qtw0qVxUGJUNt2H8TTCOEvn6G9qbUBi6_MKWgeAwcaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> d9a14b00 339317035 C Ii:1:004:1 -32:1 0
> d9a14b00 339317049 S Ii:1:004:1 -115:1 10 <
> d9a14b00 339318040 C Ii:1:004:1 -32:1 0
> d9a14b00 339318057 S Ii:1:004:1 -115:1 10 <
> d9a14b00 339319042 C Ii:1:004:1 -32:1 0
> d9a14b00 339319056 S Ii:1:004:1 -115:1 10 <
> d9a14b00 339329551 C Ii:1:004:1 -32:1 0
> d9a14b00 339329571 S Ii:1:004:1 -115:1 10 <
> d9a14b00 339330586 C Ii:1:004:1 -32:1 0
> d9a14b00 339330601 S Ii:1:004:1 -115:1 10 <
> d9a14b00 339331035 C Ii:1:004:1 -32:1 0

Sorry for necromancing an old thread, but I just happened to read
through this and thought someone might care:

If I read that right, the usbmon output shows that the interrupt
endpoint is stalled (keeps returning -EPIPE). A STALL is a special
device-side USB condition that tells the host something is wrong and
will persist until cleared manually. It seems that the driver isn't
prepared for this (see
drivers/usb/serial/pl2303.c#pl2303_read_int_callback) and just keeps
resubmitting the URB, so it will stall again as fast as the endpoint
allows it to. This may be the reason why you get so many transfers
that it overwhelms the CPU.

A fix would be to catch -EPIPE in that function and handle it
explicitly (with either a CLEAR_STALL to the endpoint or a full USB
reset... would have to look at the documentation for PL2303 to see
what the stall actually means and how you're supposed to treat it).
