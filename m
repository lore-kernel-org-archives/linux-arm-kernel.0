From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 29 Jul 2014 18:40:46 +0200
Subject: [PATCH  0/4] ARM: perf: Support i.MX53
In-Reply-To: <20140729125231.GM9245@arm.com>
References: <20140729123256.13347.79778.stgit@localhost>
 <20140729125231.GM9245@arm.com>
Message-ID: <53D7CE8E.70103@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will ,

thanks for your reply.

On 29/07/14 14:52, Will Deacon wrote:
> Hi Martin,
>
> On Tue, Jul 29, 2014 at 01:32:56PM +0100, Martin Fuzzey wrote:
>> This series enables hardware performance counters on the i.MX53 SoC
>>
>> This requires setting registers at both the ARM V7 core level
>> and the i.MX53 SoC level.
>  From a quick look at the patches, it sounds like you're booting in secure
> mode and are trying to use perf there. Whilst I understand that you may want
> to do this, I don't think the code you currently have is quite right:
Yes that's what I'm doing (I'm not doing any security stuff at all so 
the SoC is coming up in secure mode)
>   - It accesses the SDER unconditionally, which is undefined for non-secure
>     modes.
Ah yes I see what you mean that is a problem...

>   - It adds yet more callbacks to arm_pmu_platdata
>
> Instead, how about we add a new property on the PMU node that says it
> requires secure access, then we use that to configuer SDER in the perf code.

Ok but how would the new property be used?
Do you just mean making the code that sets the SUNIDEN bit conditional 
on this property?

So a DT for a board booting in secure mode would have the property set 
and one booting in non secure mode would not?

But is it the DT's business to know how the kernel has been booted?

What happens in non secure mode?
I presume the kernel won't touch SDER in that case (so avoiding an 
exception) but the counters will only work if code outside the kernel 
(bootloader, secure monitor?)  has already set things up correctly?

Wouldn't it be possible to detect if the kernel is in secure mode and 
use that instead of a DT property?
Does the kernel have that information?

> Then you can do your SoC-specific magic as part of the runtime PM hooks we
> already have (it looks like enabled/disabling a clock really).
This is orthogonal to the above right?

Indeed, I've tried that and it works without any extra hooks.

But what happens if we don't have CONFIG_PM_RUNTIME ?

Is "we don't care, enable it if you want perf to work" an acceptable answer?


Regards,

Martin
