From: yury.norov@gmail.com (Yury)
Date: Wed, 29 Jul 2015 00:23:18 +0300
Subject: [PATCH] lib: Make _find_next_bit helper function inline
In-Reply-To: <1438110564-19932-1-git-send-email-cburden@codeaurora.org>
References: <1438110564-19932-1-git-send-email-cburden@codeaurora.org>
Message-ID: <55B7F2C6.9010000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.07.2015 22:09, Cassidy Burden wrote:
> I've tested Yury Norov's find_bit reimplementation with the test_find_bit
> module (https://lkml.org/lkml/2015/3/8/141) and measured about 35-40%
> performance degradation on arm64 3.18 run with fixed CPU frequency.
>
> The performance degradation appears to be caused by the
> helper function _find_next_bit. After inlining this function into
> find_next_bit and find_next_zero_bit I get slightly better performance
> than the old implementation:
>
> find_next_zero_bit          find_next_bit
> old      new     inline     old      new     inline
> 26       36      24         24       33      23
> 25       36      24         24       33      23
> 26       36      24         24       33      23
> 25       36      24         24       33      23
> 25       36      24         24       33      23
> 25       37      24         24       33      23
> 25       37      24         24       33      23
> 25       37      24         24       33      23
> 25       36      24         24       33      23
> 25       37      24         24       33      23
>
> Signed-off-by: Cassidy Burden <cburden@codeaurora.org>
> Cc: Alexey Klimov <klimov.linux@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Daniel Borkmann <dborkman@redhat.com>
> Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
> Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Thomas Graf <tgraf@suug.ch>
> Cc: Valentin Rothberg <valentinrothberg@gmail.com>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> ---
>   lib/find_bit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 18072ea..d0e04f9 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -28,7 +28,7 @@
>    * find_next_zero_bit.  The difference is the "invert" argument, which
>    * is XORed with each fetched word before searching it for one bits.
>    */
> -static unsigned long _find_next_bit(const unsigned long *addr,
> +static inline unsigned long _find_next_bit(const unsigned long *addr,
>   		unsigned long nbits, unsigned long start, unsigned long invert)
>   {
>   	unsigned long tmp;

Hi Cassidi,

At first, I'm really surprised that there's no assembler implementation
of find_bit routines for aarch64. Aarch32 has ones...

I was thinking on inlining the helper, but decided not to do this....

1. Test is not too realistic. https://lkml.org/lkml/2015/2/1/224
The typical usage pattern is to look for a single bit or range of bits.
So in practice nobody calls find_next_bit thousand times.

2. Way more important to fit functions into as less cache lines as
possible. https://lkml.org/lkml/2015/2/12/114
In this case, inlining increases cache lines consumption almost twice...

3. Inlining prevents compiler from some other possible optimizations. It's
probable that in real module compiler will inline callers of _find_next_bit,
and final output will be better. I don't like to point out the compiler how
it should do its work.

Nevertheless, if this is your real case, and inlining helps, I'm OK with it.

But I think, before/after for x86 is needed as well.
And why don't you consider '__always_inline__'? Simple inline is only a 
hint and
guarantees nothing.
