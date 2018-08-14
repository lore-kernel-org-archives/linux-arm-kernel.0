From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 14 Aug 2018 10:07:29 +0530
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <CAPhsuW4KT=6vR_0ogTy_+Fwcz7cZ0Rac8sYohLngQmEBCd0HLw@mail.gmail.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
 <20180813115019.GB28360@redhat.com>
 <fa85d19f-b22c-e09c-b8d2-f68f0c79de15@linux.ibm.com>
 <20180813131723.GC28360@redhat.com>
 <CAPhsuW4KT=6vR_0ogTy_+Fwcz7cZ0Rac8sYohLngQmEBCd0HLw@mail.gmail.com>
Message-ID: <58d21bac-5a31-85df-4b9f-05815b64f465@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Song,

On 08/13/2018 10:42 PM, Song Liu wrote:
> On Mon, Aug 13, 2018 at 6:17 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> On 08/13, Ravi Bangoria wrote:
>>>
>>>> But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
>>>> hook and avoid delayed_uprobe_install() in uprobe_mmap().
>>>
>>> I'm sorry. I didn't get this.
>>
>> Sorry for confusion...
>>
>> I meant, if only exec*( could race with _register(), we could add another uprobe
>> hook which updates all (delayed) counters before return to user-mode.
>>
>>>> Afaics, the really problematic case is dlopen() which can race with _register()
>>>> too, right?
>>>
>>> dlopen() should internally use mmap() right? So what is the problem here? Can
>>> you please elaborate.
>>
>> What I tried to say is that we can't avoid uprobe_mmap()->delayed_uprobe_install()
>> because dlopen() can race with _register() too, just like exec.
>>
>> Oleg.
>>
> 
> How about we do delayed_uprobe_install() per file? Say we keep a list
> of delayed_uprobe
> in load_elf_binary(). Then we can install delayed_uprobe after loading
> all sections of the
> file.

I'm not sure if I totally understood the idea. But how this approach can
solve dlopen() race with _register()?

Rather, making delayed_uprobe_list an mm field seems simple and effective
idea to me. The only overhead will be list_empty(mm->delayed_list) check.

Please let me know if I misunderstood you.

Thanks,
Ravi
