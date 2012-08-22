From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Aug 2012 17:18:16 -0600
Subject: Can one  set GPIO direction in pinmux definition?
In-Reply-To: <503558B8.4010603@grid-net.com>
References: <5034FCB2.5040709@grid-net.com> <5035388D.2060909@wwwdotorg.org>
 <503558B8.4010603@grid-net.com>
Message-ID: <503568B8.4080501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2012 04:10 PM, Subodh Nijsure wrote:
> On 08/22/2012 12:52 PM, Stephen Warren wrote:
>> On 08/22/2012 09:37 AM, Subodh Nijsure wrote:
>>> For a MX28 based hardware I am working with I need to use AUART4
>>>
>>> I need to configure this AUART4 as uart only when necessary and at all
>>> other times pins associated with AUART4 need to be configured as inputs.
>> Out of curiosity, why?
>
> Our hardware is connected to external equipment, electric meter via this
> UART.
> This electricity meter can also be read externally by an optical reader.
> Since this is a shared bus, we can't be sitting on that bus with our
> interface configured as UART as it prevents optical reader from talking
> to the meter. There are ways we can tell is optical meter is connected,
> if we detect that its connected we configure these pins as input else
> configure them for UART functionality.

OK, I guess it was something like that. Can the optical be
plugged/unplugged at run-time, or is it a one-off thing? pinctrl would
be appropriate for runtime. Maybe not so much for one-off detection at
boot-time.

I wonder whether making the UART driver do the switching is the right
thing though. I assume that:

* The UART driver can be used on systems (boards) that never have this
HW configuration, and don't care about this at all.

* The detection of optical meter presence is entirely unrelated to the UART.

So probably, the muxing can be seen as completely external and unrelated
to the UART HW module itself. Would it be better represented as a
completely standalone and custom "RS232 bus mux" node/device instead of
tacking this into the UART driver?
