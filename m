From: gengdongjiu@huawei.com (gengdongjiu)
Date: Sat, 16 Dec 2017 12:51:19 +0800
Subject: [PATCH v5 04/13] arm64: kernel: Survive corrected RAS errors
 notified by SError
In-Reply-To: <79ccc7df-802b-e25c-05cf-b1ecc7c05569@huawei.com>
References: <20171215155101.23505-1-james.morse@arm.com>
 <20171215155101.23505-5-james.morse@arm.com>
 <79ccc7df-802b-e25c-05cf-b1ecc7c05569@huawei.com>
Message-ID: <720fa5cc-93a9-8844-c2f3-83116a724d1b@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/12/16 12:08, gengdongjiu wrote:
> On 2017/12/15 23:50, James Morse wrote:
>> +	case ESR_ELx_AET_UER:	/* Uncorrected Recoverable */
>> +		/*
>> +		 * The CPU can't make progress. The exception may have
>> +		 * been imprecise.
>> +		 */
>> +		return true;
>         For Recoverable error (UER), the error has not been  silently propagated,
>         and has not been architecturally consumed by the PE, and
>         The exception is precise and PE can recover execution from the preferred return address of the exception.
>         so I do not think it should be panic here if the SError come from user space instead of coming from kernel space.

I paste the spec definition for the Recoverable error (UER) which got from [0]

Recoverable error (UER)
The state of the PE is Recoverable if all of the following are true:
? The error has not been silently propagated.
? The error has not been architecturally consumed by the PE. (The PE architectural state is not infected.)
? The exception is precise and PE can recover execution from the preferred return address of the exception, if software locates and repairs the error.
The PE cannot make correct progress without either consuming the error or otherwise making the error unrecoverable. The error remains latent in the system.

If software cannot locate and repair the error, either the application or the VM, or both, must be isolated by software.

[0]
https://static.docs.arm.com/ddi0587/a/RAS%20Extension-release%20candidate_march_29.pdf

>> +
