From: klimov.linux@gmail.com (Alexey Klimov)
Date: Wed, 29 Jul 2015 16:30:56 +0300
Subject: [PATCH] lib: Make _find_next_bit helper function inline
In-Reply-To: <20150728144537.67d46b5714c99d25f0bb33fb@linux-foundation.org>
References: <1438110564-19932-1-git-send-email-cburden@codeaurora.org>
 <55B7F2C6.9010000@gmail.com>
 <20150728144537.67d46b5714c99d25f0bb33fb@linux-foundation.org>
Message-ID: <1438176656.18723.8.camel@ceres>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ??., 2015-07-28 at 14:45 -0700, Andrew Morton wrote:
> On Wed, 29 Jul 2015 00:23:18 +0300 Yury <yury.norov@gmail.com> wrote:
> 
> > But I think, before/after for x86 is needed as well.
> 
> That would be nice.
> 
> > And why don't you consider '__always_inline__'? Simple inline is only a 
> > hint and
> > guarantees nothing.
> 
> Yup.  My x86_64 compiler just ignores the "inline".  When I use
> __always_inline, find_bit.o's text goes from 776 bytes to 863. 
> Hopefully we get something in return for that bloat!

On my x86_64 (core-i5 something, with disabled cpufreq) i got following
numbers:
find_next_zero_bit
old	new	__always_inline
20	21	22	
20	21	22
20	22	23
21	21	22
21	21	23
20	21	22
20	21	23
21	22	23
20	22	22
21	21	22

find_next_bit
old	new	__always_inline
19	21	24
19	22	24
19	22	24
19	21	24
20	22	24
19	21	23
19	21	23
20	21	24
19	22	24
19	21	24

I will re-check on another machine. It's really interesting if
__always_inline makes things better for aarch64 and worse for x86_64. It
will be nice if someone will check it on x86_64 too.

Best regards,
Alexey Klimov.

> Also, if _find_next_bit() benefits from this then _find_next_bit_le()
> will presumably also benefit.
> 
> 
