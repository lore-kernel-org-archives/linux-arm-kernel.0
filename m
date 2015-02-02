From: peter@hurleysoftware.com (Peter Hurley)
Date: Sun, 01 Feb 2015 22:27:14 -0500
Subject: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support noinit
 option
In-Reply-To: <1422845104.5512.18.camel@mtksdaap41>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>	
 <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>	
 <54CE53F3.5040709@hurleysoftware.com> <1422845104.5512.18.camel@mtksdaap41>
Message-ID: <54CEEE92.70407@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2015 09:45 PM, Eddie Huang wrote:
> Hi Peter,
> 
> On Sun, 2015-02-01 at 11:27 -0500, Peter Hurley wrote:
>> Hi Eddie,
>>
>> On 01/12/2015 08:08 AM, Eddie Huang wrote:
>>> Add earlycon support not only baudrate option, but also add noinit option.
>>> If use noinit option, 8250 earlycon will not init serial hardware and use
>>> loader setting.
>>
>> I see this went into Greg's tty-testing branch.
>>
>> The only point of this is to not program the divisor, right?
> In this case, yes.
> 
>> I ask because early_serial8250_setup() could already handle this without
>> extra options by simply not doing divisor programming if no baud option is
>> present.
> MTK support high speed UART, which means baudrate can be more than
> 115200. You can reference mtk8250_set_termios() function in 8250_mtk.c.
> Unfortunately, the early_serial8250_setup() can not handle high speed
> case. This is why I add noinit parameter.

Thanks, that's what I thought; I just wanted to verify.

> Besides, I think "no baud option" is a little tricky, and maybe someday
> someone not only care about divisor, but also flow. Legacy earlyprintk
> and other uart drivers like msm_serial.c also don't init uart hardware.

My point is the 8250 earlycon should only be doing hardware initialization
if there is an option string (of the form <baud><parity><bits>), because
if there's no baud option, programming the divisor is pointless.

And to specify any other line control option the baud must be specified.
So to program any other setting would require the proper option string.

Regards,
Peter Hurley
