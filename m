From: tixy@yxit.co.uk (Tixy)
Date: Wed, 10 Aug 2011 12:31:37 +0100
Subject: [RFC PATCH 0/5] Fix Thumb-2 undef handling for mixed-arch kernels
In-Reply-To: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
References: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1312975897.7800.20.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-10 at 11:13 +0100, Dave Martin wrote:
> As a side-effect, this also changes cpu_architecture from a
> function into a global variable initialised at boot-time, which is
> probably a sensible idea anyway.

One possible pitfall of this is if the variable didn't get set up before
it's first use. I have looked at all the uses and this doesn't seem to
be a problem though.

An alternative to defend against this is to make cpu_architecture() an
inline function returning the value of the global variable like:

inline int cpu_architecture(void)
{
	BUG_ON(the_cpu_architecture == CPU_ARCH_UNKNOWN);
	return the_cpu_architecture;
}

This has the bonus of not needing to change users of the the function.

-- 
Tixy
