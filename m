From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Nov 2017 12:22:35 +0000
Subject: [RFC PATCH 1/2] arm64: write __range_ok() in C
In-Reply-To: <20171116152818.GM9361@arm.com>
References: <20171026090942.7041-1-mark.rutland@arm.com>
 <20171026090942.7041-2-mark.rutland@arm.com>
 <20171116152818.GM9361@arm.com>
Message-ID: <20171120122235.ku6whdnpgatib6in@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 03:28:19PM +0000, Will Deacon wrote:
> On Thu, Oct 26, 2017 at 10:09:41AM +0100, Mark Rutland wrote:
> > +static bool __range_ok_c(unsigned long addr, unsigned long size)
> > +{
> > +	unsigned long result;
> > +
> > +	if (__builtin_uaddl_overflow(addr, size, &result))
> 
> I'm not sure if you're planning to revisit this series, but thought I'd
> give you a heads up that apparently GCC 4.x doesn't have support for this
> builtin, so we'll need to carry the asm at least for that toolchain.

Thanks for the heads-up. I see my Linaro 14.09 GCC 4.9 generates an
out-of-line call to a __builtin_uaddl_overflow helper.

We can avoid the builtin, and write the test in C instead, e.g.

static inline bool __range_ok_c(unsigned long addr, unsigned long size)
{
        unsigned long end = addr + size;

        if (end < addr)
                return false;

        return end <= current_thread_info()->addr_limit;
}

... in my standalone test-case, that generates code that's almost
identical to the builtin, except that the compiler chooses to look at a
different flag.

Thanks,
Mark.
