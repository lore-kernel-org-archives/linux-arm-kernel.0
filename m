From: szabolcs.nagy@arm.com (Szabolcs Nagy)
Date: Fri, 23 Oct 2015 11:23:22 +0100
Subject: arm64:, Re: [RFC] Kernel livepatching support in GCC
In-Reply-To: <5629F9A7.3040808@linaro.org>
References: <844CBBAF-DA0E-4164-9E35-34075A26F665@linaro.org>
 <5628A738.5000305@huawei.com> <5628B704.8070608@linaro.org>
 <5628B9D4.9020701@arm.com> <5629F9A7.3040808@linaro.org>
Message-ID: <562A0A9A.6090102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/10/15 10:11, AKASHI Takahiro wrote:
> On 10/22/2015 07:26 PM, Szabolcs Nagy wrote:
>> On 22/10/15 11:14, AKASHI Takahiro wrote:
>>>
>>> I also have my own version of livepatch support for arm64 using yet-coming "-fprolog-add=N" option :)
>>> As we discussed before, the main difference will be how we should preserve LR register when invoking
>>> a ftrace hook (ftrace_regs_caller).
>>> But again, this is a topic to discuss mainly in linux-arm-kernel.
>>> (I have no intention of excluding gcc ml from the discussions.)
>>
>> is -fprolog-add=N enough from gcc?
>
> Yes, as far as I correctly understand this option.
>
>> i assume it solves the live patching, but i thought -mfentry
>> might be still necessary when live patching is not used.
>
> No.
> - Livepatch depends on ftrace's DYNAMIC_FTRACE_WITH_REGS feature
> - DYNAMIC_FTRACE_WITH_REGS can be implemented either with -fprolog-add=N or -mfentry
> - x86 is the only architecture that supports -mfentry AFAIK
> - and it is used in the kernel solely to implement this ftrace feature AFAIK
> - So once a generic option, fprolog-add=N, is supported, we have no reason to add arch-specific -mfentry.
>
>> or is the kernel fine with the current mcount abi for that?
>> (note that changes the code generation in leaf functions
>
> Can you please elaborate your comments in more details?
> I didn't get your point here.
>

ok, i may be confused.

i thought there is a static ftrace (functions are
instrumented with mcount using -pg) and a dynamic one
where the code is modified at runtime.

then i thought adding -fprolog-pad=N would be good for the
dynamic case, but not for the static case.

the static case may need improvements too because the
current way (using regular c call abi for mcount) affects
code generation more significantly than the proposed
-mfentry solution would (e.g. leaf functions turn into
non-leaf ones).

hence the question: is the kernel satisfied with -pg mcount
for the static ftrace or does it want -mfentry behaviour
instead?
