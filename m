From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 25 Nov 2016 01:56:59 +0100
Subject: [PATCH] SCPI (pre-v1.0): fix reading sensor value
In-Reply-To: <CAFBinCDP4PwXnUux=Wd9XJkNJef7qN3EOZm0Q8sg-B4gXqsjcA@mail.gmail.com>
References: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
 <f3d6f39e-ec45-7c62-22d4-fd7b0952b499@arm.com>
 <CAFBinCDP4PwXnUux=Wd9XJkNJef7qN3EOZm0Q8sg-B4gXqsjcA@mail.gmail.com>
Message-ID: <CAFBinCD3EE0z+Omboo-pUugs1He7ce9bT5Lo4wgvZUJKbctSKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 12:15 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> On Thu, Nov 24, 2016 at 11:47 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 24/11/16 00:18, Martin Blumenstingl wrote:
>>>
>>> I observed the following "strange" value when trying to read the SCPI
>>> temperature sensor on my Amlogic GXM S912 device:
>>> $ cat /sys/class/hwmon/hwmon0/temp1_input
>>> 6875990994467160116
>>>
>>> The value reported by the original kernel (Amlogic vendor kernel, after
>>> a reboot obviously) was 53C.
>>> The Amlogic SCPI driver only uses a single 32bit value to read the
>>> sensor value, instead of two. After stripping the upper 32bits from
>>> above value gives "52" as result, which is basically identical to
>>> what the vendor kernel reports.
>>
>>
>> Can you check why the upper 32-bit is not set to 0 ?
>>
>> In scpi_process_cmd, we memset extra rx_buf length by 0 and that should
>> take care. Neil had mentioned that works but now I doubt if firmware
>> returns 8 instead of 4 in the size which is wrong as it supports only
>> 32-bit.
> according to the code "RX Length is not replied by the legacy
> Firmware", so for legacy firmwares the "if (match->rx_len > len)"
> condition will never be true (because both values are always equal).
> in the sensor case we then go and copy 8 byte from mem->payload to
> match->rx_buf, but SCPI firmware only wrote 4 bytes to mem->payload.
> This means we are simply reading 4 byte (hi_val) of uninitialized
> memory - which may be all zeroes if we're lucky - but in my case I got
> "garbage" (I guess it's the second byte from the *previous* command
> which are leaking here).
>
> while writing this I see a second (more generic) approach which might
> work as well:
> scpi_chan does not hold any information about rx_payload/tx_payload
> sizes (these are calculated in scpi_probe but not stored anywhere).
> (for now, let's assume we had the rx_payload_size available)
> we could then go ahead and memset(rx_payload, 0, rx_payload_size) in
> scpi_tx_prepare or scpi_send_message.
> However, I am not sure if that would have any side-effects (for
> example on newer SCPI implementations).
I simply tried implementing this solution and I find it better than
the old one. However, I am still not sure if there are any
side-effects. maybe you can simply review v2 of this series which
implements the described approach (the result is the same as with v1:
temp1_input contains the correct value).


Regards,
Martin
