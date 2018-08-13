From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Mon, 13 Aug 2018 13:08:34 +0530
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
Message-ID: <5b693a28-5a0b-1adc-a805-b66dfbe7bdd7@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Song,

On 08/13/2018 11:17 AM, Ravi Bangoria wrote:
>>> +
>>> +static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
>>> +{
>>> +       struct list_head *pos, *q;
>>> +       struct delayed_uprobe *du;
>>> +
>>> +       if (!uprobe && !mm)
>>> +               return;
>> And do we really need this check?
> 
> 
> Yes. delayed_uprobe_remove(uprobe=NULL, mm=NULL) is an invalid case. If I remove
> this check, code below (or more accurately code suggested by Oleg) will remove
> all entries from delayed_uprobe_list. So I will keep this check but put a comment
> above function.
> 

Sorry, my bad. Please ignore above comment. Even though, it saves us
to unnecessary loop over entire delayed_uprobe_list when both uprobe
and mm are NULL, that case is not possible with current code. Also,
I'm not dereferencing any of them. So, IMHO it's fine to remove this
check.

Thanks,
Ravi
