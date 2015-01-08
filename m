From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 8 Jan 2015 11:21:02 -0800
Subject: Linux 3.19-rc3
In-Reply-To: <54AED10C.7090305@redhat.com>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <54AE7D53.2020305@redhat.com>
 <20150108134520.GC14200@e104818-lin.cambridge.arm.com>
 <54AEBE84.6090307@redhat.com>
 <20150108173408.GF17290@e104818-lin.cambridge.arm.com>
 <54AED10C.7090305@redhat.com>
Message-ID: <CA+55aFwpwkjRnTzBe2K0y+2DOH1F=5SpJkYe=P5z8ps5_1PQHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 8, 2015 at 10:48 AM, Mark Langsdorf <mlangsdo@redhat.com> wrote:
>
> With 4K pages, the oom killer doesn't trigger during `make -j 16 -s`
> on a fresh kernel. Thanks for the suggestion. I'm not sure what to do
> about that, though.

I suspect that bisecting remains the best option.

A 64kB allocation will make various memory pressure issues *much*
worse, and quite frankly, I consider 64kB pages completely
unacceptable for any real life situation for that and other reasons,
but if it used to work, we do want to figure out what actually broke.

The only excuse for 64kB pages is "my hardware TLB is complete crap,
and I have very specialized server-only loads".

People who think 64kB pages are a good idea are wrong. It's that
simple. You seem to be trying to compile stuff, which is not a good
load for 64kB pages (notably the page cache becomes 90% unused due to
wasted space at the end of pages).

But while 64kB pages are a completely braindead idea, the actual *bug*
is likely not the fact that 64kB page thing in itself, but some other
issue that gets triggered by it. Maybe we have some piece of code that
"knows" that a page is 4kB and mis-accounts things due to that, or
similar.

                       Linus
