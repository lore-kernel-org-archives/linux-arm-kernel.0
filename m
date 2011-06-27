From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jun 2011 12:02:34 +0100
Subject: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <BANLkTimnuEK_9RedmD1OgcunX3rPvd-O0Q@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
	<BANLkTimnuEK_9RedmD1OgcunX3rPvd-O0Q@mail.gmail.com>
Message-ID: <20110627110234.GC16103@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 01:34:48PM +0300, saeed bishara wrote:
> Russell,
>   I'm curious about the correctness of this patch for systems with
> outer cache. shouldn't the dsb be issued before the outer cache
> maintenance?

Maybe we should do two passes over SG lists then - one for the inner and
another for the outer cache?

In effect we could do three passes:

1. Calculate the total size of the SG list to determine whether full
   cache flush is more efficient.
2. Flush inner cache
   Then dsb()
3. Flush outer cache
   Another dsb()
