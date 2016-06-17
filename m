From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 17 Jun 2016 14:38:32 +0100
Subject: [PATCH] arm64: Kconfig: select PM for ARCH_VEXPRESS
In-Reply-To: <4148732.Pd5phtR9Qh@wuerfel>
References: <1466090128-24425-1-git-send-email-sudeep.holla@arm.com>
 <4148732.Pd5phtR9Qh@wuerfel>
Message-ID: <5763FD58.3090300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/06/16 12:53, Arnd Bergmann wrote:
> On Thursday, June 16, 2016 4:15:28 PM CEST Sudeep Holla wrote:
>> The Linux AMBA bus framework probes the peripheral IDs when adding the
>> AMBA devices very early on the boot. Generally they are on APB bus and
>> just require APB clocks to be on even when most of the core logic of the
>> IP is powered down.
>>
>> However on Juno, the entire debugsys domain needs to be ON to access
>> even the coresight components' CID/PID registers and hence broken by
>> design. Accessing those while debugsys power domain is off will lead to
>> the bridge stalling the transactions instead of returning the slave error.
>>
>> Further, the AMBA framework can't deal with !CONFIG_PM case: it ignores
>> the error and proceeds to access the device region. It was suggested to
>> always enable CONFIG_PM in order to handle this scenario.
>>
>> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/arm64/Kconfig.platforms | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> Hi ARM-SoC team,
>>
>> The discussion on this happened on linux-pm list[1]. This is need on
>> Juno once we introduce coresight components in the DT. With !CONFIG_PM,
>> the board stalls on boot and hence this patch is needed. This shouldn't
>> change any thing in the defconfig as couple of other platforms already
>> do the same. It's needed in case all other ARCH_* configs are disabled.
>>
>> Without this, we need a dirty trick in the DT[2] to handle !CONFIG_PM.
>>
>> Can you please pick this for v4.8 ?
>
> Question: if AMBA cannot deal with CONFIG_PM disabled, should
> the 'select' be done from CONFIG_ARM_AMBA instead?
>

But few platforms using AMBA may not want PM at all.

> I also feel a little uncomfortable with just adding 'select PM', given
> that this option is normally just implied by CONFIG_SUSPEND ||
> CONFIG_HIBERNATE_CALLBACKS,

On that analogy, for the current requirement I would say 
PM_GENERIC_DOMAINS should select but it just depends on PM.

> but not selected individually,

I agree, but Ulf suggested this.

> so we might run into regressionswhen we get configurations that
> were invalid before.

Sorry my build/config knowledge is limited, I don't understand what you
mean by the above. I am asking just to improve my knowledge.

> Then again  ARCH_RENESAS seems to already do this.

Yes, it was hard to find get !CONFIG_PM as many platforms select it
directly or indirectly.

-- 
Regards,
Sudeep
