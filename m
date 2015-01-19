From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Mon, 19 Jan 2015 18:05:04 +0900
Subject: [PATCH] kprobes: bugfix: checks kprobes_all_disarmed in
 unoptimized_kprobe().
In-Reply-To: <54BC742E.80006@huawei.com>
References: <54B3B32E.7070709@hitachi.com>
 <1421064563-77831-1-git-send-email-wangnan0@huawei.com>
 <54B3C3A0.6010708@hitachi.com> <54BC742E.80006@huawei.com>
Message-ID: <54BCC8C0.40706@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wang,

I've found a problem on this patch, since kprobes calls unoptioize_kprobe
with kprobes_all_disarmed=true when trying to disable all kprobes, this
cause a serious problem.

Moreover, I couldn't reproduce your reported bug on my 3.19-rc4 kernel.
Could you test it again?

Unless I could reproduce this bug, I'd like to keep this uncommitted.

Thank you,

(2015/01/19 12:04), Wang Nan wrote:
> Hi Masami Hiramatsu,
> 
> I can't find this patch and '[PATCH] kprobes: bugfix: checks kprobes_all_disarmed
> in unoptimized_kprobe().' in current mainline. How do these patches get there?
> Should they be merged into Russell King's tree first?
> 
> Thank you!
> 
> On 2015/1/12 20:52, Masami Hiramatsu wrote:
>> (2015/01/12 21:09), Wang Nan wrote:
>>> Original code failed to disarm the probed instruction after
>>>
>>> echo 0 > /sys/kernel/debug/kprobes/enabled
>>>
>>> if OPTPROBE is enabled.
>>>
>>> This patch checks kprobes_all_disarmed in unoptimized_kprobe().
>>>
>>
>> Looks good :)
>>
>> Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>>
>> Thank you!
>>
>>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>>> ---
>>>  kernel/kprobes.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>>> index 9471710..f16936b 100644
>>> --- a/kernel/kprobes.c
>>> +++ b/kernel/kprobes.c
>>> @@ -630,6 +630,9 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
>>>  {
>>>  	struct optimized_kprobe *op;
>>>  
>>> +	if (kprobes_all_disarmed)
>>> +		return;
>>> +
>>>  	if (!kprobe_aggrprobe(p) || kprobe_disarmed(p))
>>>  		return; /* This is not an optprobe nor optimized */
>>>  
>>>
>>
>>
> 
> 
> 


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
