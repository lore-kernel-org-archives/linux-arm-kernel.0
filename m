From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 31 Jan 2014 12:35:51 +0900
Subject: [PATCH 03/03] ARM: shmobile: Lager USB0 cable detection workaround
In-Reply-To: <1682649.H5bjffAvcD@avalon>
References: <20140129230959.22655.55645.sendpatchset@w520>
 <20140129231029.22655.58864.sendpatchset@w520>
 <1682649.H5bjffAvcD@avalon>
Message-ID: <CANqRtoQ6HErKuV01Mg2oV7S8UwTayCcsJAQtxhJGJcy8UeYCNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

[CC Morimoto-san, the author of the USBHS driver]

On Fri, Jan 31, 2014 at 10:14 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Thursday 30 January 2014 08:10:29 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add Lager board code to check the PWEN GPIO signal and refuse to
>> allow probe of the USBHS driver in case of DIP misconfiguration.
>>
>> For correct operation Lager DIP switches SW5 and SW6 shall be
>> configured in 2-3 position to enable USB Function support.
>>
>> If the DIP switch is configured incorrectly then the user can
>> simply adjust the hardware and either reboot or use the bind interface
>> to try to probe again:
>>
>> # echo renesas_usbhs > /sys/bus/platform/drivers/renesas_usbhs/bind
>
> Our of curiosity, and I know you will love the question, have you thought
> about how to implement this on multiplatform kernels without a board file ?
> :-)

Thanks for asking. =)

Actually I've been giving this some thought already. And it happens to
be that the sister board "Koelsch" has similar but slightly improved
hardware.

In the Lager case we can only support USB Function properly and
safely, and to avoid shooting ourselves in the foot we need a check
like this patch implements. So on Lager RCAR_GP_PIN(5, 18) needs to be
high for proper USB Function operation. If not we give up.

In case of Koelsch a MAX3355E chip is hooked up to handle dual
function or OTG. So on that platform we can use either Function or
Host. To figure out which cable is hooked up we can check the ID pin
of the USB connector through the MAX3355E ID_OUT signal.

In general with a USB connector (and the MAX3355E chip) there are
standard signal levels for ID pin detection. The ID signal for the USB
micro-AB connector will be High in case of Function cable (pull-up,
left open), and Low in case of Host (tied to GND).

So, to answer your question about how to support this without
board-specific code written in C, I believe we need to add
abstractions to support the MAX3355E chip and/or external ID pin
somehow. Perhaps there is almost nothing to abstract there?

Regarding how to support Lager then I think we can use the same code
as Koelsch because the ID pin signal is following the same signal
level. So perhaps it is enough to add support for the USBHS driver to
handle the ID pin as GPIO? If so, then we can use the same style for
both Lager and Koelsch, but on Lager we also somehow need to tell the
the USBHS driver that only Function is OK.

> This might be one of the valid cases where we won't be able to do without a
> board file. The callback functions in platform data, however, probably need to
> go.

I think it is possible to get rid of the board file. And especially if
we can reuse the code for multiple boards or SoC then this starts
making sense - even to me! =)

Thanks,

/ magnus
