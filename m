From: johan@kernel.org (Johan Hovold)
Date: Tue, 17 Oct 2017 10:52:10 +0200
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <CAODwPW8qtw0qVxUGJUNt2H8TTCOEvn6G9qbUBi6_MKWgeAwcaQ@mail.gmail.com>
References: <CAD=FV=VHkJFrsJDmMytbUw=WjKQaGZ-8Ewfy5bPCA82AWS4O2Q@mail.gmail.com>
 <212870399.174480.1492633502649@email.1und1.de>
 <87mvbaykn1.fsf@eliezer.anholt.net>
 <1998517910.54108.1492894253010@email.1und1.de>
 <2127594073.298820.1493143869792@email.1und1.de>
 <316369012.317772.1494274928708@email.1und1.de>
 <20170510163150.GK30445@localhost>
 <CAD=FV=VUaqtR2t04wodRJ33bqHo5DPke7zsvqBMYqZ5imX5+=A@mail.gmail.com>
 <446301756.220218.1494678481761@email.1und1.de>
 <CAODwPW8qtw0qVxUGJUNt2H8TTCOEvn6G9qbUBi6_MKWgeAwcaQ@mail.gmail.com>
Message-ID: <20171017085210.GB5638@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 01:49:11PM -0700, Julius Werner wrote:
> > d9a14b00 339317035 C Ii:1:004:1 -32:1 0
> > d9a14b00 339317049 S Ii:1:004:1 -115:1 10 <
> > d9a14b00 339318040 C Ii:1:004:1 -32:1 0
> > d9a14b00 339318057 S Ii:1:004:1 -115:1 10 <
> > d9a14b00 339319042 C Ii:1:004:1 -32:1 0
> > d9a14b00 339319056 S Ii:1:004:1 -115:1 10 <
> > d9a14b00 339329551 C Ii:1:004:1 -32:1 0
> > d9a14b00 339329571 S Ii:1:004:1 -115:1 10 <
> > d9a14b00 339330586 C Ii:1:004:1 -32:1 0
> > d9a14b00 339330601 S Ii:1:004:1 -115:1 10 <
> > d9a14b00 339331035 C Ii:1:004:1 -32:1 0
> 
> Sorry for necromancing an old thread, but I just happened to read
> through this and thought someone might care:
> 
> If I read that right, the usbmon output shows that the interrupt
> endpoint is stalled (keeps returning -EPIPE). A STALL is a special
> device-side USB condition that tells the host something is wrong and
> will persist until cleared manually. It seems that the driver isn't
> prepared for this (see
> drivers/usb/serial/pl2303.c#pl2303_read_int_callback) and just keeps
> resubmitting the URB, so it will stall again as fast as the endpoint
> allows it to. This may be the reason why you get so many transfers
> that it overwhelms the CPU.

That's a bug in the driver, we should not resubmit (without further
action) on -EPIPE.

> A fix would be to catch -EPIPE in that function and handle it
> explicitly (with either a CLEAR_STALL to the endpoint or a full USB
> reset... would have to look at the documentation for PL2303 to see
> what the stall actually means and how you're supposed to treat it).

Yes, but we can't just clear the halt from the completion handler, so
you'd typically have to schedule a work struct and call usb_clear_halt
from there. Only then could we try resubmitting the URBs, but chances
are we'd just hit that stall again (with the hardware setup in
question). Note that no usb-serial drivers currently implement any such
stall recovery, and just stop resubmitting the URB on -EPIPE.

Or at least so I thought. The generic implementation (which most drivers
rely on) and a few others get this right, but we have a number of legacy
drivers with custom implementations that do resubmit on -EPIPE
(including the pl2303 one).

I'll go fix up that up.

Thanks,
Johan
