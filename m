From: keescook@chromium.org (Kees Cook)
Date: Fri, 23 Jun 2017 13:08:00 -0700
Subject: [PATCH 3/4] powerpc: Reduce ELF_ET_DYN_BASE
In-Reply-To: <87podvp4q1.fsf@concordia.ellerman.id.au>
References: <1498154792-49952-1-git-send-email-keescook@chromium.org>
 <1498154792-49952-4-git-send-email-keescook@chromium.org>
 <87podvp4q1.fsf@concordia.ellerman.id.au>
Message-ID: <CAGXu5jK7aHHRMZyZyrviBF+cLghWcH_D4PX_vMFOycHuF7EdLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 12:01 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> Now that explicitly executed loaders are loaded in the mmap region,
>> position PIE binaries lower in the address space to avoid possible
>> collisions with mmap or stack regions. For 64-bit, align to 4GB to
>> allow runtimes to use the entire 32-bit address space for 32-bit
>> pointers.
>
> The change log and subject are a bit out of whack with the actual patch
> because previously we used 512MB.
>
> How about?
>
>   powerpc: Move ELF_ET_DYN_BASE to 4GB / 4MB
>
>   Now that explicitly executed loaders are loaded in the mmap region,
>   we have more freedom to decide where we position PIE binaries in the
>   address space to avoid possible collisions with mmap or stack regions.
>
>   For 64-bit, align to 4GB to allow runtimes to use the entire 32-bit
>   address space for 32-bit pointers. On 32-bit use 4MB.

Good idea, thanks. I'll resend the series with the commit logs updated.

> Is there any particular reasoning behind the 4MB value on 32-bit?

So, I've dug around a bit on this, and I *think* the rationale is to
avoid mapping a possible 4MB page table entry when it won't be using
at least a portion near the lower end (NULL address area covered
blocked by mmap_min_addr). It seems to be mainly tradition, though.

> I gave this a quick spin and it booted OK on all my test boxes, which
> covers 64-bit/32-bit kernel and userspace. So seems to work!

Awesome, thanks for the testing!

> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> cheers

-Kees

-- 
Kees Cook
Pixel Security
