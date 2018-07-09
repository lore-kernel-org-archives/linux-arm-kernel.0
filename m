From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Mon, 9 Jul 2018 14:19:19 -0400 (EDT)
Subject: [PATCH for 4.18 2/6] rseq: use get_user/put_user rather than
 __get_user/__put_user
In-Reply-To: <CA+55aFzpjA3r9HdfCU5LrEhSt6S=+RfKuJ2GVc8Wv5Hz-_Me8Q@mail.gmail.com>
References: <20180708210330.27324-1-mathieu.desnoyers@efficios.com>
 <20180708210330.27324-3-mathieu.desnoyers@efficios.com>
 <854203778.2272.1531157327328.JavaMail.zimbra@efficios.com>
 <CA+55aFzpjA3r9HdfCU5LrEhSt6S=+RfKuJ2GVc8Wv5Hz-_Me8Q@mail.gmail.com>
Message-ID: <1519037424.2393.1531160359475.JavaMail.zimbra@efficios.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- On Jul 9, 2018, at 2:04 PM, Linus Torvalds torvalds at linux-foundation.org wrote:

> On Mon, Jul 9, 2018 at 10:28 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> So, another twist to this story: ppc32 does not implement u64 get_user().
> 
> I was going to say that "that's not possible", since we actually have
> 64-bit arguments at least in the form of "loff_t __user *".
> 
> But when I started looking, it turns out that yeah, we do
> "copy_from_user()" on them, and instead made the x86 copy_from_user()
> have special cases for constant sizes.
> 
> So a 8-byte copy_from_user() is fine. It ends up being a "get_user()"
> on x86 anyway.

Given that this memory area has already been checked with access_ok()
on rseq registration, are you fine with leaving
__get_user/__put_user/__copy_{from,to}_user in place so we do the
minimal change at this stage of rc, or should I go ahead and replace
the lot with get_user/put_user/copy_{from,to}_user ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
