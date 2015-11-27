From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 27 Nov 2015 08:42:59 +0100
Subject: [PATCH 1/2] drivers: amba: properly handle devices with power
 domains
In-Reply-To: <CANLsYkynahvfiiEqgbQ34iRBf+_ZCXH2WjkugmZaAc4ExDFH6g@mail.gmail.com>
References: <1448456127-31842-1-git-send-email-m.szyprowski@samsung.com>
 <1448456289-31960-1-git-send-email-m.szyprowski@samsung.com>
 <20151125132458.GL8644@n2100.arm.linux.org.uk> <5655B8F6.1070104@samsung.com>
 <CAPDyKFqTqPijF+Lbq0+a-Gv8CyaAr13JvZPjUN1-GNL5i3-mAw@mail.gmail.com>
 <20151125180953.GN8644@n2100.arm.linux.org.uk> <5656C527.8040804@samsung.com>
 <CAPDyKFqQ_BuvtVnrsEdZCpXVKcDW9rAxteK1DOvHNqN7TN4sLw@mail.gmail.com>
 <CANLsYkynahvfiiEqgbQ34iRBf+_ZCXH2WjkugmZaAc4ExDFH6g@mail.gmail.com>
Message-ID: <56580983.9050503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-11-26 16:04, Mathieu Poirier wrote:
> On 26 November 2015 at 03:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 26 November 2015 at 09:39, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>> On 2015-11-25 19:09, Russell King - ARM Linux wrote:
>>>> On Wed, Nov 25, 2015 at 02:56:10PM +0100, Ulf Hansson wrote:
>>>>> On 25 November 2015 at 14:34, Marek Szyprowski <m.szyprowski@samsung.com>
>>>>> wrote:
>>>>>> Is ignoring dev_pm_domain_attach() return value a solution for you?
>>>>> That's probably better than nothing, but I wonder if it in practice
>>>>> will have any effect?
>>>> If the PM domain is down, then trying to tread the ID is likely to oops
>>>> the kernel.
>>> In my case kernel simply hangs (no single message, even when earlyprintk is
>>> enabled)
>>> instead of oopsing, that's why I've submitted this patch.
>>>
>> Okay.
>>
>> I suggest we go ahead and try that approach (ignoring the return
>> value). It's "quick fix", but the easiest way forward to solve the
>> problem.
>>
>> My only concern is if such change impacts the boot time. We should do
>> some tests to see if the change is negligible, if not we should
>> probably think of something else (like keeping the PM domain powered
>> until late_init).
>>
>> Russell, what do you think?
> That's the approach I took for coresight on Juno - simply initialise
> the power domain very early on and keep it on for things like amba
> probing to be successful.  When the boot process is done unused genPDs
> are switched off automatically.  That way we don't need to add extra
> code to amba.

Frankly I don't get the point that 'you don't need to add extra code to 
amba'.
Turning power domains on very early on boot is rationale, but then 
gen_pd core
often turns them off and on, depending on the sequence of the registered 
devices
and their runtime pm status. Amba bus should support proper registration of
devices in both cases, when power domain for the registered device is 
turn on
and off.

In my opinion it should be a gen_pd core responsibility to keep power domain
turned on until late init. Right now it turns it off when all devices, which
have been registered so far, have been turned off. Usually a moment later
another device get registered to the given domain and this requires the 
domain
to get enabled again. This problem can be observed only when there are more
than on device in a power domain.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
