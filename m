From: pieter@gmx.com (pieterg)
Date: Thu, 9 Aug 2012 11:30:55 +0200
Subject: [Openpxa-users] pxa3x0 smart panel interface
In-Reply-To: <CAN1soZyf5m+n7F+=jiKhqCjEuxdzESq9Cft8oDUhD3t4UN75sA@mail.gmail.com>
References: <20120806152551.4ec2cad0@laptoppieter>
 <201208082157.22064.marek.vasut@gmail.com>
 <CAN1soZyf5m+n7F+=jiKhqCjEuxdzESq9Cft8oDUhD3t4UN75sA@mail.gmail.com>
Message-ID: <20120809113055.210f35e4@laptoppieter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Aug 2012 15:10:40 +0800
Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> >> Does any of you have experience with interfacing smart lcd panels,
> >> with a pxa3x0?
> >>
> 
> We didn't try to connect smart lcd panel with pxa300 or pxa310.
> 
> >> I'm interfacing an ILI9327DS smart panel controller, all commands
> >> are handled correctly, however the SMART_CMD_WRITE_FRAME command
> >> (which sends out all frame data) seems to produce an invalid
> >> number of output bytes every now and then.
> >> This results in a shifted display, every 10-100 updates
> >> (immediately corrected by the next update)
> 
> Do you mean that you observe this behavior on oscilloscope? Are you
> using LCD interface
> or SMEM interface?

I'm using the LCD interface (pxafb.c with CONFIG_FB_PXA_SMARTPANEL).

It is hard to check the exact length of the data block on an
oscilloscope (400 * 240 * 3 bytes of data is a bit too much). There is
no noticable difference in transfer length, when the display shifts.
I do not have the equipment to check the exact number of bytes being
transferred.
But when I configure the controller to wrap the write pointer around at
the end of the visible area, and update using just the
SMART_CMD_WRITE_FRAME command (no start command for the controller to
reset the write pointer to the beginning of the frame), I can see the
display image almost constantly shifting. A few columns forward, a few
columns back. Therefore my conclusion that the number of data bytes
sent (or received by the controller) must be fluctuating.
And this effect is at the end (or the beginning) of the frame, never
in the middle. Because the display image, though being shifted, is never
distorted.

> >> The strange thing is that this does not occur with a pxa300, but it
> >> occurs with the pxa310 and pxa320.
> >> However running the 310/320 with the same ACCR as I'm running the
> >> 300 does not 'fix' it.
> 
> Do you change frequency while you are testing this smart panel?

No, I'm keeping the frequencies constant, during the test.
(and the smart panel timings are not yet recalculated after a frequency
switch, so that would need some work)

> >> And I'm not sure it is even timing related, I've tried to configure
> >> huge smart timing delay parameters, but the results remain the
> >> same. (in fact I can even lower the parameters to way under the
> >> controller specs, and the issue does not get worse).
> >> I've also played with the drive strength of the LCD lines, which
> >> also does not have an effect on the issue.
> >>
> >> I do not think this is a controller bug, because before this
> >> ILI9327DS controller, we had a display with a different controller
> >> chip, with which I experienced the same thing, however at that
> >> time even with the pxa300.
> >> We switched to the ILI9327DS (for a different reason), and I was
> >> glad to find that it worked fine with the pxa300.
> >> Till I discovered it had the same issues, but then only with a
> >> pxa310/320.
> LCD controller between pxa300 and pxa310 is nearly same.
