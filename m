From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 2 Aug 2016 17:02:54 +0530
Subject: [PATCH] net: thunderx: correct bound check in nic_config_loopback
In-Reply-To: <6b86fd8a-e97a-8b71-1786-50aa9e667873@verizon.com>
References: <1469933384-16827-1-git-send-email-alexander.levin@verizon.com>
 <CA+sq2Cc-MTtoncAcL6MS-YVdeVVK=aqEmZakzkX6_CwsXvpRCQ@mail.gmail.com>
 <6b86fd8a-e97a-8b71-1786-50aa9e667873@verizon.com>
Message-ID: <CA+sq2Cd39o2S7qm65gVb=TmYydNPES-TYO4CdhgKuVRC6fgozg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yes, it's incorrect at other places as well.
That went in the very early stages of development and didn't change it because
that out of bounds issue will never happen as no of logical interfaces
will never be
morethan  MAX_LMAC i.e 8, so max vf_id will be 7.

But with addition of support for newer platforms with different set HW
capabilities we
are slowly getting rid of most of the macros i.e static info.
Attached is the patch which will get rid of MAX_LMAC and also allows
support for 16LMACs (supported on newer platforms) or more.

I hope currently you are not facing any issue with below check.
>>> if (lbk->vf_id > MAX_LMAC)

I will submit the attached patch along with other patches when net-next is open.
https://lkml.org/lkml/2016/7/15/362

Thanks,
Sunil.

On Mon, Aug 1, 2016 at 9:27 PM, Levin, Alexander
<alexander.levin@verizon.com> wrote:
> On 07/31/2016 12:41 PM, Sunil Kovvuri wrote:
>> Thanks for finding.
>> A much better fix would be,
>>
>> -       if (lbk->vf_id > MAX_LMAC)
>> +       if (lbk->vf_id >= nic->num_vf_en)
>>                 return -1;
>>
>> where 'num_vf_en' reflects the exact number of physical interfaces or
>> LMACs on the system.
>
> Right. I see quite a few more places that compare to MAX_LMAC vs
> num_vf_en. What was the reasoning behind it then?
>
>
> Thanks,
> Sasha
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-net-thunderx-Add-support-for-16-LMACs-of-83xx.patch
Type: text/x-patch
Size: 5390 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160802/405d6f9f/attachment-0001.bin>
