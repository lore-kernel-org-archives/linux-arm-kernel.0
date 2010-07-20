From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Jul 2010 10:04:48 +0900
Subject: [PATCH 0/4] ARM: S5PV210: Clock Framework: powerdomain,
	block-gating, flags
In-Reply-To: <1279528236-6076-1-git-send-email-myungjoo.ham@samsung.com>
References: <1279528236-6076-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <006401cb27a7$90122100$b0366300$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> This patches add support for powerdomain, block-gating, and flags in
struct clk.
> 
> Blockgating re-uses powerdomain support scheme and depends on powerdomain
> support.
> 
> Flags support is independent from powerdomain; however, powerdomain
support
> is NOT stable without flags support. Without flags support, powerdomain
may lock
> up the system with some conditions although they are rare. Thus, when
> powerdomain or block-gating is used, flags support should be turned on for
the
> system stability. (and that's why I'm sending flags support with
> powerdomain/block-gating support).
> 
> Although powerdomain support is requred for blockgating, blockgating is
NOT
> required for powerdomain. Besides, powerdomain support is observed to
reduce
> power consumption significantly (with 2.6.29 kernel); however, blockgating
support
> didn't show any significant improvement.
> 
> 
> MyungJoo Ham (4):
>   ARM: SAMSUNG SoC: Powerdomain/Block-gating Support
>   ARM: S5PV210: Powerdomain/Clock-gating Support
>   ARM: SAMSUNG SoC: Clock Framework: Flag Support for struct clk.
>   ARM: S5PV210: Clock Framework: Flag Support for struct clk.
> 
>  arch/arm/mach-s5pv210/Kconfig              |   17 +
>  arch/arm/mach-s5pv210/clock.c              |  906
> ++++++++++++++++++++++------
>  arch/arm/plat-samsung/Kconfig              |   19 +
>  arch/arm/plat-samsung/clock.c              |  146 +++++-
>  arch/arm/plat-samsung/include/plat/clock.h |   44 ++
>  5 files changed, 935 insertions(+), 197 deletions(-)

Already we discussed about power domain...
And actually your code is similar with my member's 2.6.29 powerdomain
scheme.
So Ben's code review about that is available to your this patch.

Following is from Ben Dooks note.

===

Powerdomain control notes
=========================

Copyright 2010 Simtec Electronics
Ben Dooks <ben@simtec.co.uk>

Code Review
-----------

The current implementation makes a number of #ifdef based additions to
the clock.c which currently lies in plat-s3c/clock.c (but to be moved
to plat-samsung/clock.c). The following are the observations from reviewing
the code as presented:

1) The use of #ifdef is not recommended, as noted before in reviews it
   makes the code hard to read, allows bugs to creep in due to code
   either being skipped, and problems when we get to the stage several
   conflicting configurations could live in the kernel.

2) The code is changing the functionality of the clk_enable() and the
   clk_disable() calls, which is bad for the following reasons:

   A) Anyone reading or modifying a driver using this API may not see
      what is going on underneath.

   B) It ties the clock to the powerdomain, if any of the current drivers
      wish to temporarily stop the clock to reduce the dynamic power
      consumption they cannot (see part A, if all drivers are resting
      in the power domain the whole domain may shutdown with a resulting
      cost to the work resumption).

   C) It ties the drivers to the specific clock implementation and thus
      restricts future use of standard drivers on future devices.

   D) It ties policy into the kernel, as it forces the power domains to
      shut down if the driver is not in use. The developer or end user
      may want to change this depending on either a device wide or usage
      case. Policy decisions are best left out of the kernel.


Part (1) is a definite barrier to merging, the code whilst functional is
both ugly and the use of #ifdefs like that are contrary to a number of
developers beliefs.

The second part is also a stumbling block, as it is likely to be commented
upon by a number of interested parties if it did come up for review. I am
certainly not happy to see this sort of invasive change to the clock system
merged. I expect others would also raise objections.

...

===

So need to another approach for it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
