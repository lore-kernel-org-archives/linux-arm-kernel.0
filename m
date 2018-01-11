From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 11 Jan 2018 07:45:08 -0600
Subject: [PATCH V6 Resend 00/13] drivers: Boot Constraint core
In-Reply-To: <CAGb2v66xUJn3KoOZW5d7zcU4BY+ZYJqpyJP1bxC_oir-V2+G=w@mail.gmail.com>
References: <cover.1515554879.git.viresh.kumar@linaro.org>
 <CAL_Jsq+CtWCKENTQmiveoubxU4cDi9QBcpgvYZVfxPNsT-VX+g@mail.gmail.com>
 <CAGb2v66xUJn3KoOZW5d7zcU4BY+ZYJqpyJP1bxC_oir-V2+G=w@mail.gmail.com>
Message-ID: <CAL_JsqLqARcRp7zdZvMZsit4be7vJ66iaMM3bFvGJVQCm2bBpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 8:07 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Thu, Jan 11, 2018 at 7:13 AM, Rob Herring <robh+dt@kernel.org> wrote:
>> On Tue, Jan 9, 2018 at 9:47 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> Hi Greg,
>>>
>>> I am re-sending V6 as you suggested. There is no change from the patches
>>> sent on 14/15th of December, apart from rebasing on driver-core-next.
>>>
>>> I have tested the Hisilicon patches (again) on hikey 9660 board, IMX
>>> stuff was earlier tested by Sascha (Pengutronix) on i.MX6 and Qualcomm
>>> stuff was earlier tested by Rajendra (Qualcomm) on Dragonboard 410C
>>> (This required some more patches related to display driver which
>>> Rajendra should be sending separately later on).
>>>
>>>
>>> Problem statement:
>>>
>>> Some devices are powered ON by the bootloader before the bootloader
>>> handovers control to Linux. It maybe important for those devices to keep
>>> working until the time a Linux device driver probes the device and
>>> reconfigure its resources.
>>
>> Some devices are powered on by a bootloader, but only a small few have
>> to be maintained thru booting. Most you can just re-initialized.
>>
>>> A typical example of that can be the LCD controller, which is used by
>>> the bootloaders to show image(s) while the platform is booting into
>>> Linux.  The LCD controller can be using some resources, like clk,
>>> regulators, etc, that are shared between several devices. These shared
>>> resources should be configured to satisfy need of all the users.  If
>>> another device's (X) driver gets probed before the LCD controller driver
>>> in this case, then it may end up disabling or reconfiguring these
>>> resources to ranges satisfying the current users (only device X) and
>>> that can make the LCD screen unstable.
>>
>> We already have simple fb and a binding for it. It only handles clocks
>> I think, but could be extended to other things. I rather not extend
>> it, but it is there already and we don't need different solutions for
>> this.
>
> simplefb also handles regulators. This was added quite a while ago to
> keep LCD displays powered on Allwinner tablets. However in general it
> only grabs references to these resources and enables them so the kernel
> frameworks don't think they are unused and turn them off. It doesn't
> do clock rate or voltage constraints which Viresh wants. It should be
> easy to do for regulators, and AFAIK there is a clock rate protection
> mechanism for the clk framework in the works.

Why do we need constraints beyond taking a reference? The constraint
is don't change things. If it is more complex than that, then you need
something to parse the "real" DT nodes for the h/w blocks.

Rob
