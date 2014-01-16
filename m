From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Thu, 16 Jan 2014 12:06:36 -0500
Subject: [PATCH] ARM: imx: clk-imx6sl: Suppress duplicate const sparse
 warning
In-Reply-To: <20140115065851.GC1914@S2101-09.ap.freescale.net> (Shawn Guo's
 message of "Wed, 15 Jan 2014 14:58:54 +0800")
References: <1389766774-16661-1-git-send-email-Ying.Liu@freescale.com>
 <20140115065851.GC1914@S2101-09.ap.freescale.net>
Message-ID: <87fvon6elf.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Wed, Jan 15, 2014 at 02:19:34PM +0800, Liu Ying wrote:
>> There should be no duplicate const specifiers for those static
>> constant character string arrays defined for clock mux options.
>> Also, the arrays are only taken as the 5th argument for the
>> imx_clk_mux() function, which is in the type of 'const char
>> **parents'.  So, let's remove the 2nd const specifier right
>> after 'char'.
>>
>> This patch fixes these sparse warnings:
>> arch/arm/mach-imx/clk-imx6sl.c:21:25: warning: duplicate const

[snip]

>> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>> ---
>> arch/arm/mach-imx/clk-imx6sl.c | 42 ++++++++++++++++++++--------------------
>> 1 file changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
>> index c0c4ef5..9fad29a9 100644
>> --- a/arch/arm/mach-imx/clk-imx6sl.c
>> +++ b/arch/arm/mach-imx/clk-imx6sl.c
>>>> -18,27 +18,27 @@
>> #include "clk.h"
>> #include "common.h"
>>
>> -static const char const *step_sels[] = { "osc", "pll2_pfd2", };
> ...
>> +static const char *step_sels[] = { "osc", "pll2_pfd2", };

On 15 Jan 2014, shawn.guo at linaro.org wrote:

> So now we're getting the following checkpatch warning:
>
> WARNING: static const char * array should probably be static const char *
> 	const
>
> It was added into checkpatch.pl by commit cb710ec (scripts/checkpatch.pl:
> add warnings for static char that could be static const char).  I'm not
> sure which warning we should ignore, the sparse or the checkpatch one.

I think both scripts/programs are right.  There is a difference.

 static const char const * step_sels[] = { "osc", "pll2_pfd2", }; /* dup */
 static const char * const step_sels[] = { "osc", "pll2_pfd2", }; /* ok */
 static char const * const step_sels[] = { "osc", "pll2_pfd2", }; /* ok */

I think that 'type const * const' is a const pointer to const data, but
'const type const *' is just a const pointer (with duplicate).  The
patches have made the data non-const?

Fwiw,
Bill Pringlemeir.
