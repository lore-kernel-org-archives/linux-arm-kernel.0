From: sgruszka@redhat.com (Stanislaw Gruszka)
Date: Thu, 10 Dec 2015 12:08:02 +0100
Subject: [PATCH] iwlegacy: mark il_adjust_beacon_interval as noinline
In-Reply-To: <36263581.L8412YxJjp@wuerfel>
References: <36263581.L8412YxJjp@wuerfel>
Message-ID: <20151210110801.GA2010@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 05:42:41PM +0100, Arnd Bergmann wrote:
> With the new optimized do_div() code, some versions of gcc
> produce obviously incorrect code that leads to a link error
> in iwlegacy/common.o:
> 
> drivers/built-in.o: In function `il_send_rxon_timing':
> :(.text+0xa6b4d4): undefined reference to `____ilog2_NaN'
> :(.text+0xa6b4f0): undefined reference to `__aeabi_uldivmod'
> 
> In a few thousand randconfig builds, I have seen this problem
> a couple of times in this file, but never anywhere else in the
> kernel, so we can try to work around this in the only file
> that shows the behavior, by marking the il_adjust_beacon_interval
> function as noinline, which convinces gcc to use the unoptimized
> do_div() all the time.

I don't think this is good way to "fix" the issue, but also have
nothing against to this particular change.

Acked-by: Stanislaw Gruszka <sgruszka@redhat.com>
