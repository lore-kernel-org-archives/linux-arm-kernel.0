From: keescook@chromium.org (Kees Cook)
Date: Fri, 30 Sep 2016 09:25:45 -0700
Subject: [PATCH 3/3] arm64: dump: Add checking for writable and exectuable
 pages
In-Reply-To: <20160930155814.GA1729@remoulade>
References: <20160929213257.30505-1-labbott@redhat.com>
 <20160929213257.30505-4-labbott@redhat.com>
 <20160930155814.GA1729@remoulade>
Message-ID: <CAGXu5jJHohnRBxQAY-S7_iccgjc6xNUdBGb67b1-cOATyO-q0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2016 at 8:58 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Sep 29, 2016 at 02:32:57PM -0700, Laura Abbott wrote:
>> @@ -219,6 +223,15 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
>>               unsigned long delta;
>>
>>               if (st->current_prot) {
>> +                     if (st->check_wx &&
>> +                     ((st->current_prot & PTE_RDONLY) != PTE_RDONLY) &&
>> +                     ((st->current_prot & PTE_PXN) != PTE_PXN)) {
>> +                             WARN_ONCE(1, "arm64/mm: Found insecure W+X mapping at address %p/%pS\n",
>> +                                      (void *)st->start_address,
>> +                                      (void *)st->start_address);
>> +                             st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
>> +                     }
>> +
>
> Would it be worth verifying that all kernel mappings are UXN, too?
>
> ARMv8 allows execute-only mappings, and a !UXN mapping could result in an info
> leak (e.g. pointers in MOVZ+MOVK sequences), or potential asynchronous issues
> (e.g. user instruction fetches accessing read-destructive device registers).
> All kernel mappings *should* be UXN.

I love this idea, but based on what came up with hardened usercopy,
there are a lot of readers of kernel memory still. I think the
expectations around UXN need to be clarified so we can reason about
things like perf that want to read the kernel text.

-Kees

-- 
Kees Cook
Nexus Security
