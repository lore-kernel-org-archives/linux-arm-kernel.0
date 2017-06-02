From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Jun 2017 10:15:28 +0100
Subject: [PATCH 4/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <b1540ab1-8343-81c6-689f-fa85831680a8@synopsys.com>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3P-0004lv-2K@rmk-PC.armlinux.org.uk>
 <e254fcf9-79bc-4ffc-284f-e52c80069fe3@synopsys.com>
 <20170601223054.GH22219@n2100.armlinux.org.uk>
 <b1540ab1-8343-81c6-689f-fa85831680a8@synopsys.com>
Message-ID: <20170602091528.GJ22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 06:02:28AM +0100, Jose Abreu wrote:
> You should check that CEC is: not in standy, acknowledges
> broadcast messages, signal free time is 5bit period, and not lost
> arbitration, which basically means CEC_CTRL must be 0x2 and
> IH_CEC_STAT0 must not have ARB_LOST set.

If ARB_LOST is set, that will trigger an interrupt, and the interrupt
handler will clear the bit.  So all the time that the interrupt handler
is present, ARB_LOST should be clear whenever we try to send a message.

When we enable the CEC interface, we zero the CEC_CTRL register, which
takes the controller out of standby, and initialises the command
register.

Bits 2:1 select the signal free time, and there's no requirement
specified to require them to be set to '01' before writing the
message - in fact, it's legal for them to be set to other values,
particularly when retrying, which is something I've missed.

     2-1             Frame Type bit
  FRAME_TYP
                     00    Signal Free Time = 3-bit periods. Previous
			   attempt to send frame is unsuccessful.
                     01    Signal Free Time = 5-bit periods. New initiator
			   wants to send a frame.
                     10    Signal Free Time = 7-bit periods. Present
			   initiator wants to send another frame
			   immediately after its previous frame. (spec
			   CEC 9.1)
                     11    Illegal value. If software write this value,
			   hardware will set the value to the default 2'b01.

Clearly from that, there are times when we want to transmit a message
without a 5-bit signal free time period, particularly when we're
retrying or wanting to send another frame, so I don't believe that
there's a requirement for the control register to always be set to
0x02.  I suspect that where that value is coming from is an application
note describing how to send a brand new message each time, and not
covering the other cases.

It could be that we need to set the frame type before loading the
message - that I'll buy, but not that it must always be set to 0x02.

Provided that the standby and BC_NACK bits are both cleared should
be sufficient.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
