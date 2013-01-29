From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 10:15:49 +0000
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <20130128142510.68092e10.akpm@linux-foundation.org>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
 <20130128142510.68092e10.akpm@linux-foundation.org>
Message-ID: <20130129101549.GP23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 02:25:10PM -0800, Andrew Morton wrote:
> What's this "with enabled unaligned memory access" thing?  You mean "if
> the arch supports CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS"?  If so,
> that's only x86, which isn't really in the target market for this
> patch, yes?
> 
> It's a lot of code for a 50ms boot-time improvement.  Does anyone have
> any opinions on whether or not the benefits are worth the cost?

Well... when I saw this my immediate reaction was "oh no, yet another
decompressor for the kernel".  We have five of these things already.
Do we really need a sixth?

My feeling is that we should have:
- one decompressor which is the fastest
- one decompressor for the highest compression ratio
- one popular decompressor (eg conventional gzip)

And if we have a replacement one for one of these, then it should do
exactly that: replace it.  I realise that various architectures will
behave differently, so we should really be looking at numbers across
several arches.

Otherwise, where do we stop adding new ones?  After we have 6 of these
(which is after this one).  After 12?  After the 20th?
