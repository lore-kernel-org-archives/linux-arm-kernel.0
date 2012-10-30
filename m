From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 30 Oct 2012 18:05:41 +0100
Subject: [PATCH] spi/pl022: Activate resourses before deactivate them in
 suspend
In-Reply-To: <Pine.LNX.4.44L0.1210281659520.9245-100000@netrider.rowland.org>
References: <CAPDyKFoOJz6608b4z2PoW8ODvTJVZRq-yB0itfXnuoXdR1SpGQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1210281659520.9245-100000@netrider.rowland.org>
Message-ID: <CAPDyKFofQntK28i23JtZnEbnDfPoFvLC0yBhDR04=qfg=A+WKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 October 2012 22:09, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sun, 28 Oct 2012, Ulf Hansson wrote:
>
>> On 28 October 2012 20:52, Linus Walleij <linus.walleij@linaro.org> wrote:
>> > On Sat, Oct 27, 2012 at 11:46 PM, Mark Brown
>> > <broonie@opensource.wolfsonmicro.com> wrote:
>> >> On Fri, Oct 05, 2012 at 09:43:32AM +0200, Ulf Hansson wrote:
>> >>
>> >>> To be able to deactivate resourses in suspend, the resourses must
>> >>> first be surely active. This is done with a pm_runtime_get_sync.
>> >>> Once the resourses are restored to active state again in resume,
>> >>> the runtime pm usage count can be decreased with a pm_runtime_put.
>> >>
>> >> The PM core will ensure devices are runtime resumed before we enter
>> >> suspend precisely due to this sort of issue.
>> >
>> > I asked the very same question to Ulf (in speech, sorry
>> > so you couldn't see it...)
>> >
>> > So I guess we are talking about drivers/base/main.c
>> >
>> > in device_prepare()
>> > pm_runtime_get_noresume() is called
>>
>> This will increase the "usage_counter" for the device. It will not
>> "runtime_resume" the device, though it will prevent it from being
>> "runtime_suspended".
>
> Indeed.  The PM core does _not_ insure that devices are runtime resumed
> before going into system suspend.  Some subsystems may do this (the PCI
> subsystem does, for example -- see
> drivers/pci/pci-driver.c:pci_pm_prepare()), but the PM core doesn't.
>
> Alan Stern
>

Thanks for clarifying this Alan. Although, I am having second thoughts
around this patch even if it does what I expect it to do.

I think that the pm_runtime_get_sync (and the corrsponding "put")
should maybe be done in the suspend|resume functions of the amba bus
(drivers/amba/bus.c) instead.
The reason is because the amba bus is responsible for the apb_pclk -
clk, which also should be handled during suspend and this is not the
case right now. Unless we think each amba device driver should handle
this clock during suspend|resume...

Kind regards
Ulf Hansson
