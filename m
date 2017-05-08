From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Mon, 8 May 2017 21:48:58 +0100
Subject: [PATCH v9 1/4] syscalls: Verify address limit before returning
 to user-mode
In-Reply-To: <CAG48ez0Hz=CimkPwuq903tgJkGj8gXUtiQJJb-P2zUes6bd6Hw@mail.gmail.com>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <CAGXu5jKZRESgGhZ6GEoO784Q1G8V0DPcwM1T2PpyTqvEAsrUdg@mail.gmail.com>
 <20170508140230.23kxf2kfeazeo4zr@gmail.com>
 <CAG48ez0Hz=CimkPwuq903tgJkGj8gXUtiQJJb-P2zUes6bd6Hw@mail.gmail.com>
Message-ID: <20170508204858.GT29622@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 08, 2017 at 04:06:35PM +0200, Jann Horn wrote:

> I think Kees might be talking about
> https://bugs.chromium.org/p/project-zero/issues/detail?id=822, fixed in
> commit e6978e4bf181fb3b5f8cb6f71b4fe30fbf1b655c. The issue was that
> perf code that can run in pretty much any context called access_ok().

And that commit has *NOT* solved the problem.  perf_callchain_user()
can be called synchronously, without passing through that code.
Tracepoint shite...

That set_fs() should be done in get_perf_callchain(), just around the call of
perf_callchain_user().  Along with pagefault_disable(), actually.

BTW, that's a nice example demonstrating why doing that on the kernel
boundary is wrong.  Wider (in theory) area being "protected" => easier
to miss the ways not crossing its border.
