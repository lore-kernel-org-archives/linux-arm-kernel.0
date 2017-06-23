From: james.morse@arm.com (James Morse)
Date: Fri, 23 Jun 2017 18:03:37 +0100
Subject: [PATCH 18/20] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
In-Reply-To: <20170604120009.342-19-ynorov@caviumnetworks.com>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-19-ynorov@caviumnetworks.com>
Message-ID: <594D49E9.7090900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

On 04/06/17 13:00, Yury Norov wrote:
> ILP32 has context-related structures different from both aarch32 and
> aarch64/lp64. In this patch compat_arch_ptrace() renamed to
> compat_a32_ptrace(), and compat_arch_ptrace() only makes choice between
> compat_a32_ptrace() and new compat_ilp32_ptrace() handler.
> 
> compat_ilp32_ptrace() calls generic compat_ptrace_request() for all
> requests except PTRACE_GETSIGMASK and PTRACE_SETSIGMASK, which need
> special handling.

Can you elaborate on this special handling?

How come we don't need to wrap PTRACE_{G,S}ETSIGMASK for aarch32 compat?
>From kernel/signal32.c that uses compat_sigset_t too.

It looks like aarch64, ilp32 and aarch32 all use the same size sigset_t,
so doesn't compat_ptrace_request() already do everything we need?

...

Is this fixing an endian problem? If so, can we document it as such. Do we
already have the same bug for aarch32 compat?


Thanks,

James
