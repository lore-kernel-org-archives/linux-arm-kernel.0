From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Sep 2012 23:36:09 -0700
Subject: [PATCH 4/5] ARM: EXYNOS: Add support for Exynos secure firmware
In-Reply-To: <CAH9JG2WQ0ec0ytR1vTo+kFA88YPZYpSpCMBTuyCAX6tFafWY2A@mail.gmail.com>
References: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
 <1347524018-19301-5-git-send-email-t.figa@samsung.com>
 <20120916004455.GD7028@quad.lixom.net>
 <3910462.8Opr7bJoeX@amdc1227>
 <CAOesGMivzmbNxCeScBAhAzv+eOiF-bagLsW3WJzECaZEg5jFPg@mail.gmail.com>
 <CAH9JG2WQ0ec0ytR1vTo+kFA88YPZYpSpCMBTuyCAX6tFafWY2A@mail.gmail.com>
Message-ID: <CAOesGMisdiSvoDh1-ZQTxASRS=rKGuJYLEbiwTfzXkiEtLE3PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 10:57 PM, Kyungmin Park
<kyungmin.park@samsung.com> wrote:
> On 9/22/12, Olof Johansson <olof@lixom.net> wrote:
>> On Wed, Sep 19, 2012 at 3:10 AM, Tomasz Figa <t.figa@samsung.com> wrote:
>>> Hi Olof,
>>>
>>> On Saturday 15 of September 2012 17:44:55 Olof Johansson wrote:
>>>> On Thu, Sep 13, 2012 at 10:13:37AM +0200, Tomasz Figa wrote:
>>>> > +static void __iomem *exynos_cpu_boot_reg(int cpu)
>>>> > +{
>>>> > +   return S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
>>>> > +}
>>>>
>>>> This communication area in sysram should probably be seen as a part of
>>>> the firmware interface. It should thus be defined as part of the binding
>>>> instead, i.e.  through a reg property or similar there. That also would
>>>> make it easy to convert to using ioremap() instead of iodesc tables,
>>>> which always a nice thing.
>>>
>>> The problem with SYSRAM_NS is that it might be also used in other code,
>>> not
>>> related to firmware only. I don't know exactly all the use cases for it.
>>
>> If you don't know the use cases, and the use cases are not in the
>> kernel tree that we care about here (upstream), then there's really
>> nothing to worry about. It's after all just a define that's moved to
>> an ioremap, if there's some out of tree code that needs the old legacy
>> define then it can be added in whatever out-of-tree code that uses it.
>> Right?
> Now this address is used at cpu boot, cpuidle, inform at this time.
> As it touched at several places, it's defined at iodesc. if it changed
> with ioremap, it has to export remaped address and each codes should
> use it.

Won't you have to push down all the references to VA_SYSRAM vs
VA_SYSRAM_NS into the firmware interface anyway, since you will need
to use different addresses for whether you have firmware enabled or
not? I.e. you'll have a "firmware call" at the appropriate level for
the non-trustzone cases that uses the equivalent of VA_SYSRAM, and for
the trustzone firmware op you'll use VA_SYSRAM_NS?


> As I wrote at cover letter, if you want to use ioremap, it can be
> modified. however can you merge firmware codes itself? since ioremap
> is not related with trustzone  or firmware issues and it's exynos
> specific implementation issues. Right?

I'm not quite sure which part you are asking me to merge, if it's the
infrastructure pieces or the exynos-specific pieces.

Either way, one isn't really usable without the other, and it doesn't
make sense to merge code that can't be used. Infrastructure is best
merged together with the first user of it.


-Olof
