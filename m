From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 27 Feb 2015 15:36:04 -0600
Subject: [PATCH 4/4] firmware: qcom: scm: Move the scm driver to
 drivers/firmware
In-Reply-To: <54F0BE39.7020302@codeaurora.org>
References: <1424987976-14531-1-git-send-email-galak@codeaurora.org>
 <1424987976-14531-4-git-send-email-galak@codeaurora.org>
 <54F0BE39.7020302@codeaurora.org>
Message-ID: <97A78288-DB81-4B88-BB13-D3A53C4C819E@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 27, 2015, at 12:58 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 02/26/15 13:59, Kumar Gala wrote:
>> Architectural changes in the ARM Linux kernel tree mandate the eventual
>> removal of the mach-* directories. Move the scm driver to
>> drivers/firmware and the scm header to include/linux to support that
>> removal.
>> 
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> ---
>> MAINTAINERS                  |   1 +
>> arch/arm/mach-qcom/Kconfig   |   3 -
>> arch/arm/mach-qcom/Makefile  |   3 -
>> arch/arm/mach-qcom/platsmp.c |   2 +-
>> arch/arm/mach-qcom/scm.c     | 344 -------------------------------------------
>> arch/arm/mach-qcom/scm.h     |  29 ----
>> drivers/firmware/Kconfig     |   4 +
>> drivers/firmware/Makefile    |   2 +
>> drivers/firmware/qcom_scm.c  | 344 +++++++++++++++++++++++++++++++++++++++++++
>> include/linux/qcom_scm.h     |  29 ++++
>> 10 files changed, 381 insertions(+), 380 deletions(-)
>> delete mode 100644 arch/arm/mach-qcom/scm.c
>> delete mode 100644 arch/arm/mach-qcom/scm.h
>> create mode 100644 drivers/firmware/qcom_scm.c
>> create mode 100644 include/linux/qcom_scm.h
> 
> Can you generate this with -M -C? Or just throw
> 
> [diff]
>        renames = copy
> 
> int your git config.
> 
> The files are the same right?

Will, do.. I keep forgetting to make this change in .gitconfig

> 
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index 41983883..6517132 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -132,6 +132,10 @@ config ISCSI_IBFT
>> 	  detect iSCSI boot parameters dynamically during system boot, say Y.
>> 	  Otherwise, say N.
>> 
>> +config QCOM_SCM
>> +	bool
>> +	depends on ARM || ARM64
> 
> No need to have depends on here if the option is hidden. Just make sure
> it isn't selected unless the depends are true.

While not needed, I?d like to keep it since there is some ARM asm code.

> Also, the drivers/firmware/Kconfig file needs to be sourced in the
> arch/arm/Kconfig so that we can still get this option on arm (Lina
> noticed it isn't working on arm). It looks like arm64 is already
> sourcing it.

will fix

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
