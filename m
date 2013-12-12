From: olof@lixom.net (Olof Johansson)
Date: Thu, 12 Dec 2013 00:53:00 -0800
Subject: [PATCH] net: eth: 8390: remove section warning in etherh.c
In-Reply-To: <CAP8WD_aJEmBYbM0BmQodGJsOPqZ+vqk9B15n297q_+aCorR=VQ@mail.gmail.com>
References: <1386837577-15130-1-git-send-email-olof@lixom.net>
 <CAP8WD_aJEmBYbM0BmQodGJsOPqZ+vqk9B15n297q_+aCorR=VQ@mail.gmail.com>
Message-ID: <CAOesGMj_0m-Y8TvrZF=zgT33RuDtismjY=k6pbfm+MFmp2p=_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 12:46 AM, tedheadster <tedheadster@gmail.com> wrote:
> On Thu, Dec 12, 2013 at 3:39 AM, Olof Johansson <olof@lixom.net> wrote:
>>
>> Commit c45f812f0280 ('8390 : Replace ei_debug with msg_enable/NETIF_MSG_*
>> feature') ended up moving the printout of version[] from something that
>> will be compiled out due to defines, to something that is now evaluated
>> at runtime.
>>
>> That means that what always used to be an access to an __initdata string
>> from non-__init code started showing up as a section mismatch when it
>> didn't before.
>>
>> All other 8390 versions skip __initdata on the version string, and
>> starting to annotate the whole chain of callers with __init seems like
>> more churn than it's worth on this driver, so remove it from etherh.c as
>> well.
>>
>
> Olof,
>   should you also remove the __init tag from etherh_banner() since it is
> called from etherh_probe(), which does not have an __init tag?

Hmm.

The section warning functionality is clever enough to not trigger when
a function is named _probe() and references __initdata, and discarding
etherh_banner() should be just fine so I don't see a need to remove
it.


-Olof
