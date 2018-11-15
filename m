From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Thu, 15 Nov 2018 11:31:33 -0700
Subject: [RFC 0/3] Unify CPU topology across ARM64 & RISC-V
In-Reply-To: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
References: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
Message-ID: <07d92dd4-f943-47ee-e168-46bfaf4ed755@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/8/2018 6:50 PM, Atish Patra wrote:
> The cpu-map DT entry in ARM64 can describe the CPU topology in
> much better way compared to other existing approaches. RISC-V can
> easily adopt this binding to represent it's own CPU topology.
> Thus, both cpu-map DT binding and topology parsing code can be
> moved to a common location so that RISC-V or any other
> architecture can leverage that.
> 
> The relevant discussion regarding unifying cpu topology can be
> found in [1].
> 
> arch_topology seems to be a perfect place to move the common
> code. I have not introduced any functional changes in the moved
> to code. The only downside in this approach is that the capacity
> code will be executed for RISC-V as well. But, it will exit
> immediately after not able to find the appropriate DT node. If
> the overhead is considered too much, we can always compile out
> capacity related functions under a different config for the
> architectures that do not support them.
> 
> The patches have been tested for RISC-V and compile tested for
> ARM64.
> 
> The socket changes[2] can be merged on top of this series or vice
> versa.
> 
> [1] https://lkml.org/lkml/2018/11/6/19
> [2] https://lkml.org/lkml/2018/11/7/918
> 
> Atish Patra (3):
>    dt-binding: cpu-topology: Move cpu-map to a common binding.
>    cpu-topology: Move cpu topology code to common code.
>    RISC-V: Parse cpu topology during boot.
> 
>   Documentation/devicetree/bindings/arm/topology.txt | 475 -------------------
>   .../devicetree/bindings/cpu/cpu-topology.txt       | 526 +++++++++++++++++++++
>   arch/arm64/include/asm/topology.h                  |  23 +-
>   arch/arm64/kernel/topology.c                       | 305 +-----------
>   arch/riscv/Kconfig                                 |   1 +
>   arch/riscv/kernel/smpboot.c                        |   6 +-
>   drivers/base/arch_topology.c                       | 303 ++++++++++++
>   include/linux/arch_topology.h                      |  23 +
>   include/linux/topology.h                           |   1 +
>   9 files changed, 864 insertions(+), 799 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/topology.txt
>   create mode 100644 Documentation/devicetree/bindings/cpu/cpu-topology.txt
> 

I was interested in testing these on QDF2400, an ARM64 platform, since 
this series touches core ARM64 code and I'd hate to see a regression. 
However, I can't figure out what baseline to use to apply these. 
Different patches cause different conflicts of a variety of baselines I 
attempted.

What are these intended to apply to?

Also, you might want to run them through checkpatch next time.  There 
are several whitespace errors.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
