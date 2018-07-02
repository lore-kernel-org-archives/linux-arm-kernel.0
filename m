From: eugenis@google.com (Evgenii Stepanov)
Date: Mon, 2 Jul 2018 16:39:51 -0700
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <20180702203321.GA8371@bombadil.infradead.org>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com>
 <20180702203321.GA8371@bombadil.infradead.org>
Message-ID: <CAFKCwrg=3J-ARaOJgc73oRE7hQxs1VV7YiZEPS7Dt8Gfn6cWQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 1:33 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Jun 27, 2018 at 05:04:28PM -0700, Kostya Serebryany wrote:
>> The problem is more significant on mobile devices than on desktop/server.
>> I'd love to have [K]HWASAN on x86_64 as well, but it's less trivial since x86_64
>> doesn't have an analog of aarch64's top-byte-ignore hardware feature.
>
> Well, can we emulate it in software?
>
> We've got 48 bits of virtual address space on x86.  If we need all 8
> bits, then that takes us down to 40 bits (39 bits for user and 39 bits
> for kernel).  My laptop only has 34 bits of physical memory, so could
> we come up with a memory layout which works for me?

Yes, probably.

We've tried this in userspace by mapping a file multiple times, but
that's very slow, likely because of the extra TLB pressure.
It should be possible to achieve better performance in the kernel with
some page table tricks (i.e. if we take top 8 bits out of 48, then
there would be only two second-level tables, and the top-level table
will look like [p1, p2, p1, p2, ...]). I'm not 100% sure if that would
work.

I don't think this should be part of this patchset, but it's good to
keep this in mind.
