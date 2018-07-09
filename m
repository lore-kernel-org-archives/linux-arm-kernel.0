From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 9 Jul 2018 11:04:28 -0700
Subject: [PATCH for 4.18 2/6] rseq: use get_user/put_user rather than
 __get_user/__put_user
In-Reply-To: <854203778.2272.1531157327328.JavaMail.zimbra@efficios.com>
References: <20180708210330.27324-1-mathieu.desnoyers@efficios.com>
 <20180708210330.27324-3-mathieu.desnoyers@efficios.com>
 <854203778.2272.1531157327328.JavaMail.zimbra@efficios.com>
Message-ID: <CA+55aFzpjA3r9HdfCU5LrEhSt6S=+RfKuJ2GVc8Wv5Hz-_Me8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2018 at 10:28 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> So, another twist to this story: ppc32 does not implement u64 get_user().

I was going to say that "that's not possible", since we actually have
64-bit arguments at least in the form of "loff_t __user *".

But when I started looking, it turns out that yeah, we do
"copy_from_user()" on them, and instead made the x86 copy_from_user()
have special cases for constant sizes.

So a 8-byte copy_from_user() is fine. It ends up being a "get_user()"
on x86 anyway.

                Linus
