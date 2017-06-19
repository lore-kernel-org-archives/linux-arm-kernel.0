From: james.morse@arm.com (James Morse)
Date: Mon, 19 Jun 2017 16:58:16 +0100
Subject: [PATCH 05/20] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
In-Reply-To: <20170604120009.342-6-ynorov@caviumnetworks.com>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-6-ynorov@caviumnetworks.com>
Message-ID: <5947F498.2040505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

On 04/06/17 12:59, Yury Norov wrote:
> From: Andrew Pinski <apinski@cavium.com>
> 
> In this patchset  ILP32 ABI support is added. Additionally to AARCH32,
> which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.
> 
> From now, AARCH32_EL0 (former COMPAT) config option means the support of
> AARCH32 userspace, ARM64_ILP32 - support of ILP32 ABI (see next patches),
> and COMPAT indicates that one of them, or both, is enabled.
> 
> Where needed, CONFIG_COMPAT is changed over to use CONFIG_AARCH32_EL0 instead

Nit: You have 'COMPAT' around compat_hwcap_str's definition, but its only user
is wrapped in 'AARCH32_EL0'.


After this patch
arch/arm64/kernel/perf_callchain.c::perf_callchain_user() still has:
>	if (!compat_user_mode(regs)) {
>		/* AARCH64 mode */
...
>	} else {
> #ifdef CONFIG_COMPAT
> 		/* AARCH32 compat mode */
...
> #endif
>	}

I think this one should become CONFIG_AARCH32_EL0. compat to this code means the
fp is 'compat_fp' in x11, and it should read a 32bit call chain from user-space.

This is confusing as 'is_compat_task()' matches one of aarch32 or ilp32, but
compat_user_mode(regs) only matches aarch32 as it checks the saved spsr. I can't
see any problem caused by this today, but its going to bite someone in the
future. Can this be renamed aarch32_user_mode()? (turns out 'a32' is the name of
just one of aarch32's instruction sets[0].)


Thanks,

James

[0] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.faqs/ka16137.html
