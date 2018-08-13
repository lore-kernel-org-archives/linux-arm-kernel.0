From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Mon, 13 Aug 2018 18:31:00 +0530
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180813115019.GB28360@redhat.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
 <20180813115019.GB28360@redhat.com>
Message-ID: <fa85d19f-b22c-e09c-b8d2-f68f0c79de15@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleg,

On 08/13/2018 05:20 PM, Oleg Nesterov wrote:
> On 08/13, Ravi Bangoria wrote:
>>
>> On 08/11/2018 01:27 PM, Song Liu wrote:
>>>> +
>>>> +static void delayed_uprobe_delete(struct delayed_uprobe *du)
>>>> +{
>>>> +       if (!du)
>>>> +               return;
>>> Do we really need this check?
>>
>> Not necessary though, but I would still like to keep it for a safety.
> 
> Heh. I tried to ignore all minor problems in this version, but now that Song
> mentioned this unnecessary check...
> 
> Personally I really dislike the checks like this one.
> 
> 	- It can confuse the reader who will try to understand the purpose
> 
> 	- it can hide a bug if delayed_uprobe_delete(du) is actually called
> 	  with du == NULL.
> 
> IMO, you should either remove it and let the kernel crash (to notice the
> problem), or turn it into
> 
> 	if (WARN_ON(!du))
> 		return;
> 
> which is self-documented and reports the problem without kernel crash.

Ok. I'll remove that check.

> 
>>>> +       rc_vma = find_ref_ctr_vma(uprobe, mm);
>>>> +
>>>> +       if (rc_vma) {
>>>> +               rc_vaddr = offset_to_vaddr(rc_vma, uprobe->ref_ctr_offset);
>>>> +               ret = __update_ref_ctr(mm, rc_vaddr, is_register ? 1 : -1);
>>>> +
>>>> +               if (is_register)
>>>> +                       return ret;
>>>> +       }
>>> Mixing __update_ref_ctr() here and delayed_uprobe_add() in the same
>>> function is a little confusing (at least for me). How about we always use
>>> delayed uprobe for uprobe_mmap() and use non-delayed in other case(s)?
>>
>>
>> No. delayed_uprobe_add() is needed for uprobe_register() case to handle race
>> between uprobe_register() and process creation.
> 
> Yes.
> 
> But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
> hook and avoid delayed_uprobe_install() in uprobe_mmap().

I'm sorry. I didn't get this.

> 
> Afaics, the really problematic case is dlopen() which can race with _register()
> too, right?

dlopen() should internally use mmap() right? So what is the problem here? Can
you please elaborate.

Thanks,
Ravi
