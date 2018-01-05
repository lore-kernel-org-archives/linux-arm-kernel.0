From: james.morse@arm.com (James Morse)
Date: Fri, 05 Jan 2018 18:28:46 +0000
Subject: [PATCH v5 04/13] arm64: kernel: Survive corrected RAS errors
 notified by SError
In-Reply-To: <720fa5cc-93a9-8844-c2f3-83116a724d1b@huawei.com>
References: <20171215155101.23505-1-james.morse@arm.com>
 <20171215155101.23505-5-james.morse@arm.com>
 <79ccc7df-802b-e25c-05cf-b1ecc7c05569@huawei.com>
 <720fa5cc-93a9-8844-c2f3-83116a724d1b@huawei.com>
Message-ID: <5A4FC3DE.3010907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On 16/12/17 04:51, gengdongjiu wrote:
> On 2017/12/16 12:08, gengdongjiu wrote:
>> On 2017/12/15 23:50, James Morse wrote:
>>> +	case ESR_ELx_AET_UER:	/* Uncorrected Recoverable */
>>> +		/*
>>> +		 * The CPU can't make progress. The exception may have
>>> +		 * been imprecise.
>>> +		 */
>>> +		return true;

>>         For Recoverable error (UER), the error has not been  silently propagated,
>>         and has not been architecturally consumed by the PE, and
>>         The exception is precise and PE can recover execution from the preferred return address of the exception.

>>         so I do not think it should be panic here if the SError come from user space instead of coming from kernel space.

'coming from' doesn't mean an awful lot unless we know what the error is.
To repeat the earlier examples, it could be a fault in the page tables, or pages
shared between processes, e.g. the vdso data page.

I don't want this crude panic/continue to consider anything other than the ESR.
Lets keep it crude, its a stop-gap: both kernel-first and firmware-first can do
a better job - this is just some glue to hold things together until we have
one/both implemented.


[...]

> Recoverable error (UER)
> The state of the PE is Recoverable if all of the following are true:
> ? The error has not been silently propagated.
> ? The error has not been architecturally consumed by the PE. (The PE architectural state is not infected.)
> ? The exception is precise and PE can recover execution from the preferred return address of the exception, if software locates and repairs the error.


It's this bit that made me err on the side of caution/panic():

> The PE cannot make correct progress without either consuming the error or
> otherwise making the error unrecoverable. The error remains latent in the system.

Without firmware-first or kernel-first we can't know where the error is. What
should we do?:

> If software cannot locate and repair the error, either the application or the
> VM, or both, must be isolated by software.


Thanks,

James
