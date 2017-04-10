From: keescook@chromium.org (Kees Cook)
Date: Mon, 10 Apr 2017 13:13:06 -0700
Subject: [kernel-hardening] Re: [RFC v2][PATCH 04/11] x86: Implement
 __arch_rare_write_begin/unmap()
In-Reply-To: <58EA988F.29293.6C80F08B@pageexec.freemail.hu>
References: <1490811363-93944-1-git-send-email-keescook@chromium.org>
 <CA+DvKQKc8uq=1O5d41GRU6u=GkOvuCJzkbPPBcp2ohHLU7A25g@mail.gmail.com>
 <CALCETrUk7k3SFKiu2kykwPM=AQ9q2rczetL4j5XyoOxX_gjCGw@mail.gmail.com>
 <58EA988F.29293.6C80F08B@pageexec.freemail.hu>
Message-ID: <CAGXu5jJa=7_KyvNxYuEYvx9EjbMwXN5QDyNGuc_zuYFP56Ga8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 9, 2017 at 1:24 PM, PaX Team <pageexec@freemail.hu> wrote:
> On 7 Apr 2017 at 22:07, Andy Lutomirski wrote:
>> No one has explained how CR0.WP is weaker or slower than my proposal.
>
> you misunderstood, Daniel was talking about your use_mm approach.
>
>> Here's what I'm proposing:
>>
>> At boot, choose a random address A.
>
> what is the threat that a random address defends against?
>
>>  Create an mm_struct that has a
>> single VMA starting at A that represents the kernel's rarely-written
>> section.  Compute O = (A - VA of rarely-written section).  To do a
>> rare write, use_mm() the mm, write to (VA + O), then unuse_mm().
>
> the problem is that the amount of __read_only data extends beyond vmlinux,
> i.e., this approach won't scale. another problem is that it can't be used
> inside use_mm and switch_mm themselves (no read-only task structs or percpu
> pgd for you ;) and probably several other contexts.

These are the limitations that concern me: what will we NOT be able to
make read-only as a result of the use_mm() design choice? My RFC
series included a simple case and a constify case, but I did not
include things like making page tables read-only, etc.

I cant accept not using cr0, since we need to design something that
works on arm64 too, which doesn't have anything like this (AFAIK), but
I'd like to make sure we don't paint ourselves into a corner.

-Kees

-- 
Kees Cook
Pixel Security
