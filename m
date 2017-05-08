From: jannh@google.com (Jann Horn)
Date: Mon, 8 May 2017 16:06:35 +0200
Subject: [PATCH v9 1/4] syscalls: Verify address limit before returning to
 user-mode
In-Reply-To: <20170508140230.23kxf2kfeazeo4zr@gmail.com>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <CAGXu5jKZRESgGhZ6GEoO784Q1G8V0DPcwM1T2PpyTqvEAsrUdg@mail.gmail.com>
 <20170508140230.23kxf2kfeazeo4zr@gmail.com>
Message-ID: <CAG48ez0Hz=CimkPwuq903tgJkGj8gXUtiQJJb-P2zUes6bd6Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 8, 2017 at 4:02 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> > And yes, I realize that there were other such bugs and that such bugs might
>> > occur in the future - but why not push the overhead of the security check to
>> > the kernel build phase? I.e. I'm wondering how well we could do static
>> > analysis during kernel build - would a limited mode of Sparse be good enough
>> > for that? Or we could add a new static checker to tools/, built from first
>> > principles and used primarily for extended syntactical checking.
>>
>> Static analysis is just not going to cover all cases. We've had vulnerabilities
>> where interrupt handlers left KERNEL_DS set, for example. [...]
>
> Got any commit ID of that bug - was it because a function executed by the
> interrupt handler leaked KERNEL_DS?

I think Kees might be talking about
https://bugs.chromium.org/p/project-zero/issues/detail?id=822, fixed in
commit e6978e4bf181fb3b5f8cb6f71b4fe30fbf1b655c. The issue was that
perf code that can run in pretty much any context called access_ok().
