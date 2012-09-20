From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Sep 2012 08:43:46 +0200
Subject: [PATCH] spi: pl022: Add clk_{un}prepare() support in runtime PM
In-Reply-To: <CAOh2x=kH2pmF0oh+Rfna+0JmM+X433vB_TyhPJUhQg9B5r1evA@mail.gmail.com>
References: <1f784b72399e0e96414f00866b209e2e218065af.1347877746.git.vipulkumar.samar@st.com>
 <CACRpkdbHegZAw+9XXzOb5UPPqJvzoNfPJ5aPDhuwWWhWunuv8w@mail.gmail.com>
 <CAOh2x==GY6xvyWmLJtpR68x1kiFWO8F85RwS6VfHjJA8YdhgvA@mail.gmail.com>
 <CACRpkdYnW=VbR1ieF1oicdPF79jV2raX9xkccE_ndrxQQjkUqw@mail.gmail.com>
 <CAOh2x=kH2pmF0oh+Rfna+0JmM+X433vB_TyhPJUhQg9B5r1evA@mail.gmail.com>
Message-ID: <CACRpkdYREZs6ydw0mKN5c3ePVLzaLmnbKWcYEi=uYDE=OOUAHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 5:31 AM, viresh kumar <viresh.kumar@linaro.org> wrote:
> On Tue, Sep 18, 2012 at 5:20 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Sep 18, 2012 at 6:09 AM, viresh kumar <viresh.kumar@linaro.org> wrote:
>
>>> The amba layer is taking care of interface clock only and not
>>> functional clock. So
>>> i believe that's not the magic code. :)
>>
>> This clock is the one for the external bus. In some designs these two
>> clocks are one and the same, and these won't currently get into any clock
>> disabled states, sadly. (We need to fix that some day.)
>
> I went through the code and found following in amba/bus.c:
>
>
> static int amba_pm_runtime_suspend(struct device *dev)
> {
>         struct amba_device *pcdev = to_amba_device(dev);
>         int ret = pm_generic_runtime_suspend(dev);
>
>         if (ret == 0 && dev->driver)
>                 clk_disable(pcdev->pclk);
>
>         return ret;
> }
>
> static int amba_pm_runtime_resume(struct device *dev)
> {
>         struct amba_device *pcdev = to_amba_device(dev);
>         int ret;
>
>         if (dev->driver) {
>                 ret = clk_enable(pcdev->pclk);
>                 /* Failure is probably fatal to the system, but... */
>                 if (ret)
>                         return ret;
>         }
>
>         return pm_generic_runtime_resume(dev);
> }
>
> If i am not wrong, these routines also get called with runtiime suspend/resume
> of pl022?

Maybe. And that is part of the problem. Check this in
drivers/base/power/runtime.c, rpm_suspend():

        if (dev->pm_domain)
                callback = dev->pm_domain->ops.runtime_suspend;
        else if (dev->type && dev->type->pm)
                callback = dev->type->pm->runtime_suspend;
        else if (dev->class && dev->class->pm)
                callback = dev->class->pm->runtime_suspend;
        else if (dev->bus && dev->bus->pm)
                callback = dev->bus->pm->runtime_suspend;
        else
                callback = NULL;

So as you see the AMBA bus-level runtime PM callbacks will be
called UNLESS there is a class and UNLESS there is a type
and UNLESS there is a voltage domain for this device.

In Ux500 we solved this by calling the AMBA bus-level code
from the voltage domain so it's not completely overridden,
but the semantics are complex here. :-/

(And then we have yet to bring common suspend/resume
into the picture ... which makes is ever more complex.)

If the SPEAr is not using any voltage domains for example,
it'll be unaffected and work fine.

> If that is the case, the even the interface clock of pl022 is getting
> disabled when not in used.

Yes, hopefully...

> And so for Architectures like SPEAr (where functional and interface
> clock are controlled
> by a single bit), we don't need anything else for power saving, with
> respect to clocks.
> Isn't it so?

If you have no power domains I hope the ref goes down to
zero and gates off the clock, so yes!

Yours,
Linus Walleij
