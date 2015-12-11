From: vbabka@suse.cz (Vlastimil Babka)
Date: Fri, 11 Dec 2015 08:12:38 +0100
Subject: next-20151210 build: 4 failures 43 warnings (next-20151210)
In-Reply-To: <20151210144708.65b7111eb795ddabbfad1ed3@linux-foundation.org>
References: <E1a6wEp-0000hU-7o@optimist> <20151210165513.GO5727@sirena.org.uk>
 <20151210144708.65b7111eb795ddabbfad1ed3@linux-foundation.org>
Message-ID: <566A7766.7060704@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.12.2015 23:47, Andrew Morton wrote:
> On Thu, 10 Dec 2015 16:55:13 +0000 Mark Brown <broonie@kernel.org> wrote:
> 
>> Today's -next fails to build most arm64 configs with some rather
>> spectacular errors below introduced by 02598e94ed5a78 (mm, printk:
>> introduce new format string for flags) from Andrew's tree.  These in
>> turn stem from the fact that we introduce an inclusion of
>> linux/tracepoint.h into linux/mmdebug.h which through a chain of nested
>> inclusions means that we end up attempting to use definitions from
>> headers before they have finished including.
> 
> Thanks.
> 
> Further complexicating the include tree is something we don't need. 
> I'll try moving the offending declarations into mm/internal.h, see how
> that goes.

Yeah that works too, thanks.

> Including ../mm/internal.h into lib/vsprintf.c is a bit grubby, but I
> guess it makes sense - vsprintf is poking about in mm internals, so it
> gets to include mm's internal.h.

OK.

> Vlastimil, the patch is rather bloaty - it adds 1.2k for something
> which few people will use.  I wonder if it should be conditioned by
> CONFIG_DEBUG_VM.

Hmm, but one of the benefits is that we get e.g. the gfp flags translated
in oom and alloc failure reports that users submit, and CONFIG_DEBUG_VM
is not enabled by default. So the conditioning should be based on some
option that people explicitly enable to make their kernels smaller knowing
it's a tradeoff for functionality/convenience.
