From: collinsd@codeaurora.org (David Collins)
Date: Thu, 31 Jul 2014 13:33:49 -0700
Subject: [PATCH v3 1/4] mfd: pm8xxx-spmi: add support for Qualcomm SPMI
 PMICs
In-Reply-To: <53DA02C0.2050606@mm-sol.com>
References: <1406205921-7452-1-git-send-email-svarbanov@mm-sol.com>
 <1406205921-7452-2-git-send-email-svarbanov@mm-sol.com>
 <53D8182A.5050204@codeaurora.org> <53DA02C0.2050606@mm-sol.com>
Message-ID: <53DAA82D.4020901@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2014 01:48 AM, Stanimir Varbanov wrote:
> Hi David,
> 
> Thanks for the comments!
> 
> On 07/30/2014 12:54 AM, David Collins wrote:
>> On 07/24/2014 05:45 AM, Stanimir Varbanov wrote:
>>> From: Josh Cartwright <joshc@codeaurora.org>
>>>
>>> The Qualcomm SPMI PMIC chips are components used with the
>>> Snapdragon 800 series SoC family.  This driver exists
>>> largely as a glue mfd component, it exists to be an owner
>>> of an SPMI regmap for children devices described in
>>> device tree.

(...)
>>> +static const struct regmap_config pm8xxx_regmap_config = {
>>> +	.reg_bits	= 16,
>>> +	.val_bits	= 8,
>>> +	.max_register	= 0xffff,
>>
>> Can you please add the following line here?
>>
>> 	.fast_io	= true;
>>
>> This will cause a spinlock to be held during SPMI transactions instead of
>> a mutex lock.  This is needed because several downstream peripheral
>> drivers need to make SPMI read and write calls from atomic context.  I
>> have commented on this point in a previous thread with specific examples [2].
> 
> OK, I understand the need of atomic context, but pmic_arb_read_cmd() and
> pmic_arb_write_cmd() functions use raw_spin_lock_irqsave already. Isn't
> those locks enough?

No, that isn't sufficient.  The problem is that the peripheral driver
would already be in atomic context at the time that it needs to perform an
SPMI read or write via regmap_read() or regmap_write() respectively.
These regmap calls would take a mutex lock if fast_io == false.  This is
not allowed since calling a sleepable function in atomic context can lead
to deadlock.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
