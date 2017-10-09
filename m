From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 9 Oct 2017 07:53:59 -0700
Subject: iMX6 PCIE IRQ not working with ath9k based Wifi
In-Reply-To: <1507551698.2745.1.camel@pengutronix.de>
References: <348346fa-1d70-1d08-9a32-18b660328e4f@tubby.org>
 <CAK8P3a0bF7=bbWBS9+7uBYp+yGpDUfS_QCX6K4i3WJv9mbgvEA@mail.gmail.com>
 <d20644ba-0e1b-0fb4-41ba-d1d604800382@tubby.org>
 <1507551698.2745.1.camel@pengutronix.de>
Message-ID: <CAJ+vNU0=+H9ED7TXwJv4VjymFD7ArnUq9NhMQVJdPtSdAe=xKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 9, 2017 at 5:21 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hi Mike,
>
> Am Montag, den 09.10.2017, 12:56 +0100 schrieb Mike Tubby:
>
> [...]
>
>> If I understand correctly the ath9k driver in kernel 4.1.15 we're
>> using
>> doesn't enable MSI - so I assume that there is some backwards
>> compatibility mode that then is not working because MSI is enabled
>> at
>> the CPU end, and hence the patch you referred to is used to turn this
>> off.
>>
>> At the same time on the mailing list:
>>
>> https://www.mail-archive.com/ath9k-devel at lists.ath9k.org/msg14332.htm
>> l
>>
>> which is part of:
>>
>>      https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
>>
>> there is talk of a patch to the ath9k driver to properly implement
>> MSI
>> in the updated driver in kernel 4.6
>>
>> So, for us the question is which way to head:
>>
>>      a) disable MSI at the CPU and try to use legacy; or
>>
>>      b) update the ath9k driver to try and enable MSI ?
>>
>>
>> We will also check the DTS/DTB in case something is mis-assigned.
>
> Due to a design flaw of the DWC host controller, legacy IRQs (like the
> ones used by ath9k) won't work if any MSIs are enabled on the
> controller.
>
> You can take a look at my series "[PATCH 0/3] DWC host without MSI
> controller", which works around this, but still needs some rework for
> mainline.
>
> Regards,
> Lucas

Mike,

Yes, this is exactly the scenario I keep pointing out. The ath9k
card/drivers requires legacy interrupts which won't work when MSI is
used on the DWC host controller used on the IMX6. I don't know what
other cards/drivers require legacy interrupts... perhaps they are not
that popular as this issue has lingered for a while.

The patch series Lucas created disables MSI via the device-tree for
IMX6 and is what you need: https://patchwork.ozlabs.org/cover/806603/.
The patch series is not accepted yet and will be tweaked a bit (to do
the same for the other SoC's that use the DWC controller, not just
IMX6) but for IMX6 it works fine on top of a 4.13 kernel.

I see from your original post you are using a 4.1 kernel. For Linux
4.6 and prior you can disable MSI at kernel build time but from 4.7
onward it takes a bit more hacking.

Tim
