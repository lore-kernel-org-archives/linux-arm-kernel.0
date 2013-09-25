From: robherring2@gmail.com (Rob Herring)
Date: Wed, 25 Sep 2013 14:20:58 -0500
Subject: [PATCH v4] dt: update PSCI binding documentation for v0.2
In-Reply-To: <CAOesGMid5pgcVD+oCjUr_75tv+C5QtVZt=Vt9kdiT_QPFOrzrg@mail.gmail.com>
References: <1379625868-5395-1-git-send-email-robherring2@gmail.com>
 <CAOesGMjNhYTfPOr5NPEC9GWym-nuFE0hX_6+LW9bTv_E3iXbcQ@mail.gmail.com>
 <20130920102015.GH17453@e106331-lin.cambridge.arm.com>
 <CAOesGMid5pgcVD+oCjUr_75tv+C5QtVZt=Vt9kdiT_QPFOrzrg@mail.gmail.com>
Message-ID: <CAL_JsqK1LE9rptajTOfvzNd1NQEihJzwm0YtJMzpUz-BhwJg5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 12:15 PM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Sep 20, 2013 at 3:20 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Fri, Sep 20, 2013 at 05:36:51AM +0100, Olof Johansson wrote:
>>> Hi,
>>
>> Hi Olof,
>>
>>>
>>> Just a quick drive-by. Sorry, I don't know the history of previous
>>> review cycles.
>>>
>>>
>>> On Thu, Sep 19, 2013 at 2:24 PM, Rob Herring <robherring2@gmail.com> wrote:
>>>
>>> >  Main node optional properties:
>>> >
>>> > - - cpu_suspend   : Function ID for CPU_SUSPEND operation
>>> > + - cpu_suspend[-<32|64]   : Function ID for CPU_SUSPEND operation
>>> > +
>>> > + - cpu_off                : Function ID for CPU_OFF operation
>>> > +
>>> > + - cpu_on[-<32|64]        : Function ID for CPU_ON operation
>>> > +
>>> > + - affinity_info[-<32|64] : Function ID for AFFINITY_INFO operation
>>> >
>>> > - - cpu_off       : Function ID for CPU_OFF operation
>>> > + - migrate[-<32|64]       : Function ID for MIGRATE operation
>>> >
>>> > - - cpu_on        : Function ID for CPU_ON operation
>>> > + - migrate_info_type      : Function ID for MIGRATE_INFO_TYPE operation
>>> >
>>> > - - migrate       : Function ID for MIGRATE operation
>>> > + - migrate_info_up_cpu[-<32|64] : Function ID for MIGRATE_INFO_UP_CPU operation
>>> >
>>> > + - system_reset           : Function ID for SYSTEM_RESET operation
>>> > +
>>> > + - system_off             : Function ID for SYSTEM_OFF operation
>>>
>>> All of these should use dashes instead of underscores.
>>
>> I also don't like the underscores, but they're an unfortunate historical
>> artifact that we can't get rid of (at least for cpu_on, cpu_off, and
>> cpu_suspend).
>
> We need to keep those three old ones supported in the driver, but the
> newer binding can use dashes instead, as long as the kernel also
> handles the old binding.
>
>> Both Xen and kvmtool are already passing DTs to guests which have
>> underscores in the property names, so it's both a boot ABI and a
>> userspace ABI.
>
> Again, as mentioned on IRC: We've said that bindings are not yet
> stable until we lock them down, so we will need to adjust accordingly.
> Once we lock them down, they are stable and part of ABI. But we really
> don't want to deal with the bad bindings that people came up with
> without much review, and that's what the whole idea behind cleaning up
> and then locking them down is all about.

For some of us, bindings are already in production. Until we have some
way to document stable vs. unstable, it is not up to anyone but the
users of a binding to define the stability. If the users of a binding
can tolerate the change, then it is unstable and can change.
Otherwise, it has to be treated as stable especially when there are
objections to changing it. One way or another, I need to support
system_reset and system_off because that is what is in firmware. Yes,
it should have all been documented here first, but it is not like I'm
just making shit up and documenting after the fact. The binding is
documented to some extent in the PSCI document itself.

All this boils down to using '_' vs. '-', right? Come on. I'm all for
consistency, but let's be practical. There are plenty of documented
examples that use '_' starting with device_type.

Rob
