From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 8 Apr 2016 10:58:42 +0100
Subject: [PATCH] arm64: erratum: Workaround for Kryo reserved system
 register read
In-Reply-To: <57069977.5050205@arm.com>
References: <1460044456-5297-1-git-send-email-nkaje@codeaurora.org>
 <57069977.5050205@arm.com>
Message-ID: <570780D2.3060104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/16 18:31, Marc Zyngier wrote:

>> +	All system register encodings above use the form
>> +
>> +	Op0, Op1, CRn, CRm, Op2.
>> +
>> +	Note that some of the encodings listed above include
>> +	the system register space reserved for the following
>> +	identification registers which may appear in future revisions
>> +	of the ARM architecture beyond ARMv8.0.
>> +	This space includes:
>> +	ID_AA64PFR[2-7]_EL1
>> +	ID_AA64DFR[2-3]_EL1
>> +	ID_AA64AFR[2-3]_EL1
>> +	ID_AA64ISAR[2-7]_EL1
>> +	ID_AA64MMFR[2-7]_EL1


AFAIK, the id space is unassigned. So the naming above could cause confusion
if the register is named something else.

>> +
>> +	check_local_cpu_errata();
>> +
>
> What is the impact of moving this around? Suzuki, was there any
> particular reason why this check was done later rather than earlier?

All the existing errata look for MIDR to match, which is read separately
using read_cpuid_id(). The moment we need to do something w.r.t an ID register,
this will break. So at the moment moving this doesn't have much of an impact.

Thanks
Suzuki
