From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 23 Feb 2017 16:09:40 -0600
Subject: [RFC/PATCH] of: Mark property::value as const
In-Reply-To: <58AF4D03.7020908@gmail.com>
References: <20170214025040.23955-1-stephen.boyd@linaro.org>
 <58AF3E06.4030701@gmail.com> <58AF4D03.7020908@gmail.com>
Message-ID: <CAL_Jsq+OQgmqvHQ_AWXOqnK0Yh8T3EVyxyiTFk1+0AwNHCf+Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 2:58 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> On 02/23/17 11:54, Frank Rowand wrote:
>> On 02/13/17 18:50, Stephen Boyd wrote:
>>> The 'blob' we pass into populate_properties() is marked as const,
>>> but we cast that const away when we assign the result of
>>> fdt_getprop_by_offset() to pp->value. Let's mark value as const
>>> instead, so that code can't mistakenly write to the value of the
>>> property that we've so far advertised as const.
>>>
>>> Unfortunately, this exposes a problem with the fdt resolver code,
>>> where we overwrite the value member of properties of phandles to
>>> update them with their final value. Add a comment for now to
>>> indicate where we're potentially writing over const data.
>>
>> The resolver should not be over writing anything in the FDT.  I'll
>> look at what is going on there.
>>
>> The FDT we expose to user space should be the FDT we booted with,
>> not something later modified.
>
> It seems that /sys/firmware/fdt is not documented.  I'll look into
> fixing that.

That's because the "official" interface is /proc/device-tree/ which is
now a symlink. IIRC, it is documented to use /proc/device-tree, not
the sysfs path.

Rob
