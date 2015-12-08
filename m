From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 07 Dec 2015 19:22:33 -0800
Subject: [PATCH v4 0/4] ARM SMC Calling Convention interface
In-Reply-To: <1449049626-13991-1-git-send-email-jens.wiklander@linaro.org>
 (Jens Wiklander's message of "Wed, 2 Dec 2015 10:47:02 +0100")
References: <1449049626-13991-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <7hegexmxom.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

Jens Wiklander <jens.wiklander@linaro.org> writes:

> This patch set is based on the Generic TEE subsystem v6 patchset
> (https://lwn.net/Articles/662495/) sent out a few weeks ago. By isolating
> the ARM SMC Calling Convention patches that are useful for other purposes
> than to support the Generic TEE subsystem some complexity is removed from
> that patch set.
>
> This patch set adds a common interface to do an SMC or HVC following ARM
> SMC Calling Convention. The interface is implemented for both the arm and
> arm64 architectures and updates the PSCI driver to use this interface
> instead for firmware communication.

I applied this series to a test branch of the arm-soc tree and pushed it
for build/boot testing at kernelci.org, which found a new build
failures[1] when building multi_v7_defconfig with CONFIG_THUMB2_KERNEL=y:

../arch/arm/kernel/smccc-call.S: Assembler messages:
../arch/arm/kernel/smccc-call.S:40: Error: too many positional arguments
../arch/arm/kernel/smccc-call.S:49: Error: too many positional arguments
make[2]: *** [arch/arm/kernel/smccc-call.o] Error 1
make[2]: Target `__build' not remade because of errors.
make[1]: *** [arch/arm/kernel] Error 2

That obviously prevented boot testing for that particular build, but all
the other boot tests are normal[2].

Kevin

[1] http://kernelci.org/build/arm-soc/kernel/v4.4-rc3-4-g7a438b46311d/
[2] http://kernelci.org/boot/all/job/arm-soc/kernel/v4.4-rc3-4-g7a438b46311d/
