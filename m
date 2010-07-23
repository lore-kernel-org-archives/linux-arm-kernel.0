From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Jul 2010 17:42:18 +0100
Subject: [PATCH RFC] arm: msm: Add QSD8x60 System MMU support.
In-Reply-To: <1279833694-1214-1-git-send-email-stepanm@codeaurora.org>
References: <1279833694-1214-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <20100723164218.GC750@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 02:21:34PM -0700, Stepan Moskovchenko wrote:
> Add support for the System MMUs found on the 8x60 and 8x72
> families of Qualcomm MSMs. These SMMUs allow virtualization
> of the address space used by most of the multimedia cores
> on these chips.

There's lots of "return -1;" statements in this patch - it's obscene
that this is used to indicate "some error occurred" in kernel space
rather than a real errno value - even when an existing function
(eg, request_irq) gave you an error code already.

The problem comes when someone - or you - uses your code, assuming that
you do return errno values, just like the rest of the kernel.  I've seen
cases where this happened all the way through to userspace.  When "-1"
is interpreted as an errno value, it means "Operation not permitted"
which almost is never what you meant - and as kernel functions return
negative errno values, this is exactly how it gets interpreted.

Please note this for the future - and please review patches on this
point internally first.

Thanks.
