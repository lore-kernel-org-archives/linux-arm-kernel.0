From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 16 Feb 2016 16:28:46 -0800
Subject: [PATCH v2] arm64: add alignment fault hanling
In-Reply-To: <CA+55aFz+ttJoEG_WkpkwV=+Wunzxpj9NoHobq-8oFZS0HEEyeA@mail.gmail.com>
References: <329817481.954581455597874663.JavaMail.weblogic@epmlwas08c>
 <20160216103104.GC14509@arm.com> <56C300AD.8070505@arm.com>
 <20160216122153.GD19413@e104818-lin.cambridge.arm.com>
 <20160216160055.GH14509@arm.com> <20160216170408.GL14509@arm.com>
 <CA+55aFw-86k4gY46Et=e02HQQSxjUK2Jfz0SJz8tWtk5P8YZFA@mail.gmail.com>
 <56C39538.6090009@linux.intel.com>
 <CA+55aFz+ttJoEG_WkpkwV=+Wunzxpj9NoHobq-8oFZS0HEEyeA@mail.gmail.com>
Message-ID: <CA+55aFyr56yHSzWA77-+P4hm2nzUgx0cea7Zk8YD0YqJv1W43w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 1:42 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Feb 16, 2016 1:31 PM, "Arjan van de Ven" <arjan@linux.intel.com> wrote:
>>
>> but what happens to the read if the page isn't present?
>> or is execute-only or .. or ..
>
> If we actually get a fault and handle the exception (not handling the
> exception was the problem on arm), the exception code will just cut off the
> pathname at the page boundary.
>
> So it will see the accessible part, and get zeroes for the inaccessible one.

Actually, looking closer, we only do that for the kernel case (where
pagealloc-debug can cause the unaligned path component in *kernel*
space to trap).

I misremembered because I considered doing it for user accesses too,
but as Catalin correctly says, there we don't actually end up being
that clever, and we just fall back to byte-at-a-time. Which means that
we do get the exact EFAULT behavior even though I'm not 100% convinced
we need to.

See the use of "load_unaligned_zeropad()"  (in the dcache handling) vs
just "get_user()" (in strncpy_from_user()).

The fault case doesn't actually ever happen in practice.

The IS_UNALIGNED() case (on architectures with inefficient unaligned
handling), which also falls back to the byte-at-a-time model, is
likely a much bigger problem. They probably need their own strncpy if
they care about performance. But the common architectures all happily
do efficient unaligneds these days.

             Linus
