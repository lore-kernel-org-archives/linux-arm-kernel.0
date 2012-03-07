From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 7 Mar 2012 18:55:46 +0800
Subject: [PATCH v3] MM: CMA: add a simple kernel module as the helper to
 test CMA
In-Reply-To: <op.wasqyyok3l0zgt@mpn-glaptop>
References: <1331090098-25097-1-git-send-email-Barry.Song@csr.com>
 <4F56E0AC.8070501@gmail.com> <op.wasqyyok3l0zgt@mpn-glaptop>
Message-ID: <CAGsJ_4wb3yMwSVW8ppvMoFe-oJXvNYigttg9S_kAVnDkDhDGHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/3/7 Michal Nazarewicz <mina86@mina86.com>:
>> On 03/07/2012 11:14 AM, Barry Song wrote:
>>>
>>> Any write request to /dev/cma_test will let the module to allocate memory
>>> from
>>> CMA, for example:
>>>
>>> 1st time
>>> $ echo 1024> ?/dev/cma_test
>>> will require cma_test to request 1MB(1024KB)
>>> 2nd time
>>> $ echo 2048> ?/dev/cma_test
>>> will require cma_test to request 2MB(2048KB)
>>>
>>> Any read request to /dev/cma_test will let the module to free the 1st
>>> valid
>>> memory from CMA, for example:
>>>
>>> 1st time
>>> $ cat /dev/cma_test
>>> will require cma_test to free the 1MB allocated in the first write
>>> request
>>> 2nd time
>>> $ cat /dev/cma_test
>>> will require cma_test to free the 2MB allocated in the second write
>>> request
>
>
> On Wed, 07 Mar 2012 05:14:36 +0100, Cong Wang <xiyou.wangcong@gmail.com>
> wrote:
>>
>> Any reason why using /dev not /proc or /sys?
>
>
> Because /proc is for processes and /sys is for stable, documented APIs.
>
> If anything, debugfs might make some sense, but since the module needs
> struct
> device anyway, it can just register a misc device, which is simpler and does
> not require debugfs to be compiled.

Michal, thanks for clarification. actually after i sent my mail to
agree Cong's /proc might be ok, then i had more thinking, i came back
to think the original /dev is better since anyway we need to device to
alloc CM.
then we let the device's read/write to handle alloc/free. it is much
more direct for a test module.

>
> --
> Best regards, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? _ ? ? _
> .o. | Liege of Serenely Enlightened Majesty of ? ? ?o' \,=./ `o
> ..o | Computer Science, ?Micha? ?mina86? Nazarewicz ? ?(o o)
> ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
>

-barry
