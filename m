From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Apr 2014 09:57:32 +0100
Subject: do_undefinstr call sem down_read?
In-Reply-To: <5358D051.5050306@linaro.org>
References: <5358D051.5050306@linaro.org>
Message-ID: <20140425085731.GG26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 04:50:25PM +0800, Alex Shi wrote:
> I caught the following issue few times on my panda board on lsk. but I
> track the code path, looks like the upstream kernel has the same problem
> too.
...
> [   30.733612] [<c0008417>] (do_undefinstr+0x10b/0x13c) from [<c050cbe3>] (__und_svc_finish+0x1/0x3e)
> [   30.743103] Exception stack(0xedd5fc50 to 0xedd5fc98)
> [   30.748443] fc40:                                     c13c14e0 80000000 00000080 00000000
> [   30.757141] fc60: c13c14e0 0000000c eac67284 c13c14e0 edc11518 c0df95c0 c0824410 eac67240
> [   30.765808] fc80: 00000000 edd5fcd8 c00171f9 c00cf998 80000133 ffffffff
> [   30.772827] [<c050cbe3>] (__und_svc_finish+0x1/0x3e) from [<c00cf998>] (page_mapping+0x20/0x38)
> [   30.782073] [<c00cf998>] (page_mapping+0x20/0x38) from [<c00171f9>] (flush_dcache_page+0x1d/0x60)

The real question is why is page_mapping triggering an undefined
instruction exception.  That I have no answer for.

This function is a hot path, so I doubt that it really is an undefined
instruction.  I suspect either your CPU has an erratum, or you have
hardware problems.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
