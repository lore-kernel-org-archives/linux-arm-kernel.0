From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 17 Jul 2014 11:17:03 -0700
Subject: [PATCH v4 2/3] soc: qcom-rpm: Driver for the Qualcomm RPM
In-Reply-To: <CAMf-jSnPpo39cXLbM9cefUr37J=hnEHqfJSetORxMnjsdoANdw@mail.gmail.com>
References: <1405465241-28684-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1405465241-28684-3-git-send-email-bjorn.andersson@sonymobile.com>
 <CAMf-jSnPpo39cXLbM9cefUr37J=hnEHqfJSetORxMnjsdoANdw@mail.gmail.com>
Message-ID: <CAJAp7OjPPoZYk4QyT4CzB5ncpzYos_f0ZNFk4kWEKBGvzVvOmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 10:33 AM, pramod gurav
<pramod.gurav.etc@gmail.com> wrote:
> Hi Bjorn,
>
> On Wed, Jul 16, 2014 at 4:30 AM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
>> Driver for the Resource Power Manager (RPM) found in Qualcomm 8660, 8960
>> and 8064 based devices. The driver exposes resources that child drivers
>> can operate on; to implementing regulator, clock and bus frequency
>> drivers.
>>
>
> [snip]
>
>> +       }
>> +
>> +       ret = irq_set_irq_wake(irq_ack, 1);
>
> This calls fails and throws error on my ifc6410 with 3.16-rc5.
> Does this driver depend on pincntrl. Looks like the DT support for
> pincntrl driver is missing in apq8064 dts in mainline.
> Is that right?
>

This is a gic interrupt, to it's unrelated to pinctrl.

What happens is that you end up in gic_set_wake() checking for the
architecture specific implementation of irq_set_wake; on modern
Qualcomm platforms waking the system up from sleep seems to be handled
in it's entirety by the "Modem Power Manager" (or "MSM Power Manager")
- in short MPM.

So once we introduce a driver for the mpm hardware this should
register these functions with the gic and we should get those marked
as wakeup sources.

It can be argued that this should be an error instead of just a
"warning", but for systems where this fails; i.e. systems without the
mpm driver we will not be able to go to sleep anyways, so if this call
fails we shouldn't expect to ever be woken up again.


So please ignore this warning for now; we will get there at some point.

Regards,
Bjorn
