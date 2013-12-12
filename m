From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Thu, 12 Dec 2013 11:35:12 +0000
Subject: [PATCH 2/3] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <1386792029-23148-2-git-send-email-broonie@kernel.org>
References: <1386792029-23148-1-git-send-email-broonie@kernel.org>
 <1386792029-23148-2-git-send-email-broonie@kernel.org>
Message-ID: <20131212113512.GC28621@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 08:00:28PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> In non-heterogeneous systems like big.LITTLE systems the scheduler will be
> able to make better use of the available cores if we provide power numbers
> to it indicating their relative performance. Do this by parsing the CPU
> nodes in the DT.

Setting the relative performance through cpu_power in it current form
eads to sub-optimal scheduling on big.LITTLE in common scenarios.

I know that this is how it is currently done for ARMv7 and one could
argue that we should do the same for ARMv8 until we have a better
solution. I just want to highlight that setting cpu_power this way is
not generally the right thing to do for big.LITTLE. It will have to be
fixed eventually.

I fully agree that we need to pass relative performance information to
the scheduler, but it isn't really ready for it yet.

It doesn't harm when using the ARM big.LITTLE reference patches as they
ignore cpu_power for load-balancing. However, it leads to
under-utilization of little cpus with the mainline scheduler.

> 
> The power numbers are the same as for ARMv7 since it seems that the
> expected differential between the big and little cores is very similar on
> both ARMv7 and ARMv8. These numbers are just an initial and basic
> approximation for use with the current scheduler, it is likely that both
> experience with silicon and ongoing work on improving the scheduler will
> lead to further tuning.

As said above, it needs to be fixed in the scheduler.

Morten
