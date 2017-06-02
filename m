From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 2 Jun 2017 11:28:08 +0200
Subject: [PATCH 4/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <20170602091528.GJ22219@n2100.armlinux.org.uk>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3P-0004lv-2K@rmk-PC.armlinux.org.uk>
 <e254fcf9-79bc-4ffc-284f-e52c80069fe3@synopsys.com>
 <20170601223054.GH22219@n2100.armlinux.org.uk>
 <b1540ab1-8343-81c6-689f-fa85831680a8@synopsys.com>
 <20170602091528.GJ22219@n2100.armlinux.org.uk>
Message-ID: <2b63fe63-0ffd-34f8-1966-3f3c803d640a@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/17 11:15, Russell King - ARM Linux wrote:
> On Fri, Jun 02, 2017 at 06:02:28AM +0100, Jose Abreu wrote:
>> You should check that CEC is: not in standy, acknowledges
>> broadcast messages, signal free time is 5bit period, and not lost
>> arbitration, which basically means CEC_CTRL must be 0x2 and
>> IH_CEC_STAT0 must not have ARB_LOST set.
> 
> If ARB_LOST is set, that will trigger an interrupt, and the interrupt
> handler will clear the bit.  So all the time that the interrupt handler
> is present, ARB_LOST should be clear whenever we try to send a message.
> 
> When we enable the CEC interface, we zero the CEC_CTRL register, which
> takes the controller out of standby, and initialises the command
> register.
> 
> Bits 2:1 select the signal free time, and there's no requirement
> specified to require them to be set to '01' before writing the
> message - in fact, it's legal for them to be set to other values,
> particularly when retrying, which is something I've missed.
> 
>      2-1             Frame Type bit
>   FRAME_TYP
>                      00    Signal Free Time = 3-bit periods. Previous
> 			   attempt to send frame is unsuccessful.
>                      01    Signal Free Time = 5-bit periods. New initiator
> 			   wants to send a frame.
>                      10    Signal Free Time = 7-bit periods. Present
> 			   initiator wants to send another frame
> 			   immediately after its previous frame. (spec
> 			   CEC 9.1)
>                      11    Illegal value. If software write this value,
> 			   hardware will set the value to the default 2'b01.

The 'signal_free_time' argument of adap_transmit will have the recommended
signal free time. You can test against the CEC_SIGNAL_FREE_TIME_* defines
from media/cec.h. You probably saw this already, but just in case you missed
this...

Regards,

	Hans
