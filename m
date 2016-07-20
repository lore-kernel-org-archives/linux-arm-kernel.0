From: julien.grall@arm.com (Julien Grall)
Date: Wed, 20 Jul 2016 12:01:47 +0100
Subject: [PATCH v4] xen/arm: Add a clock property
In-Reply-To: <CAMuHMdU9yP2SMYa5ssrQSu1vwSN2gM4mD-EVYSGr2Pqf=jmCgw@mail.gmail.com>
References: <1468309605-19522-1-git-send-email-dirk.behme@de.bosch.com>
 <CAMuHMdU9yP2SMYa5ssrQSu1vwSN2gM4mD-EVYSGr2Pqf=jmCgw@mail.gmail.com>
Message-ID: <cc28ef7e-dce3-fe5f-ab80-b662244bcbd0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/07/16 10:43, Geert Uytterhoeven wrote:
> Hi Dirk,

Hi Geert,

> On Tue, Jul 12, 2016 at 9:46 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> Clocks described by this property are reserved for use by Xen, and the OS
>> must not alter their state any way, such as disabling or gating a clock,
>> or modifying its rate. Ensuring this may impose constraints on parent
>> clocks or other resources used by the clock tree.
>>
>> This property is used to proxy clocks for devices Xen has taken ownership
>> of, such as UARTs, for which the associated clock controller(s) remain
>> under the control of Dom0.
>
> I'm not familiar with using XEN at all, but I'm a bit puzzled...
>
> Can't you just add a clocks property to the (virtual) serial device node in DT?
> Then the (virtual) serial device driver can get and enable the clock?

There is no DT node for the Xen console (hvc). The UART used by Xen will 
be completely removed from the Device tree.

>
> Alternatively, you can add a (virtual) clock controller, and power-domains
> and clock properties to all affected devices (I assume there can be others,
> besides virtual UARTs?), and let it be handled by Runtime PM, without the
> (virtual) device drivers having to care about clocks at all.

I am not sure to understand here. The problem is not because we provide 
virtual device to DOM0 but because the physical devices will be 
completely hidden (i.e remove from the DT) from DOM0.

Those devices will be removed from the Device Tree and may not have a 
corresponding virtual device. So we cannot replicate the clocks property 
in the device.

In a previous mail [1], Stefano suggested to add a new property for the 
clock to mention that the clock should not changed (i.e rate, 
disable...). How would that fit?

Regards,

[1] 
https://lists.xenproject.org/archives/html/xen-devel/2016-07/msg01614.html

-- 
Julien Grall
