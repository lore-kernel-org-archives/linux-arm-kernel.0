From: guohanjun@huawei.com (Hanjun Guo)
Date: Mon, 29 Jan 2018 19:36:34 +0800
Subject: [PATCH v3 0/6] 32bit ARM branch predictor hardening
In-Reply-To: <20180125152139.32431-1-marc.zyngier@arm.com>
References: <20180125152139.32431-1-marc.zyngier@arm.com>
Message-ID: <d95c2261-febe-bb56-da37-5edc1a593cbb@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 2018/1/25 23:21, Marc Zyngier wrote:
> This small series implements some basic BP hardening by invalidating
> the BTB on 32bit ARM CPUs that are known to be susceptible to aliasing
> attacks (Spectre variant 2). It doesn't help non-ARM 32bit CPUs, nor
> 32bit kernels that run on 64bit capable CPUs. This series doesn't
> mitigate Spectre variant 1 either.
> 
> These patches are closely modelled against what we do on arm64,
> although simpler as we can rely on an architected instruction to
> perform the invalidation. The notable exception is Cortex-A15, where
> BTB invalidation behaves like a NOP, and the only way to shoot the
> predictor down is to invalidate the icache *and* to have ACTLR[0] set
> to 1 (which is a secure-only operation).
> 
> The first patch reuses the Cortex-A8 BTB invalidation in switch_mm and
> generalises it to be used on all affected CPUs. The second perform the
> same invalidation on prefetch abort outside of the userspace
> range. The third one nukes it on guest exit, and results in some major
> surgery as we cannot take a branch from the vectors (that, and Thumb2
> being a massive pain).
> 
> Patches 4 to 6 are doing a similar thing for Cortex-A15, which the
> aforementioned ICIALLU.

I have tested this patch set on A9 and A15 based machines, but with
no kvm support, it booted ok, and passed our test framework which
has thousands of test cases (not related to performance :) ), so
with patch 1,2,4,5 in this patch set,

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

By the way, this patch set just enable branch predictor hardening
on arm32 unconditionally, but some of machines (such as wireless
network base station) will not be exposed to user to take advantage
of variant 2, and those machines will be pretty sensitive for
performance, so can we introduce Kconfig or boot option to disable
branch predictor hardening as an option?

Thanks
Hanjun
