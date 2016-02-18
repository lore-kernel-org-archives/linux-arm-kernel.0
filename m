From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Thu, 18 Feb 2016 12:38:09 +0300
Subject: KASAN issues with idle / hotplug area
In-Reply-To: <56C57F40.3050500@virtuozzo.com>
References: <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com> <20160217143950.GC32647@leverpostej>
 <20160217170110.GE32647@leverpostej> <20160217175656.GJ32647@leverpostej>
 <20160217191643.GK32647@leverpostej> <56C57F40.3050500@virtuozzo.com>
Message-ID: <56C59101.80805@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/18/2016 11:22 AM, Andrey Ryabinin wrote:

> I see two options here:
>  * completely disable instrumentation for drivers/firmware/psci.c
>  * get back to assembly implementation

One more option is to allocate struct arm_smccc_res on stack of arm_smccc_[hvc, smc](), and return res.a0
from arm_smccc_[hvc,smc]().

So it will look like this:

asmlinkage unsigned long arm_smccc_hvc(unsigned long a0, unsigned long a1,
			unsigned long a2, unsigned long a3, unsigned long a4,
			unsigned long a5, unsigned long a6, unsigned long a7);


static unsigned long __invoke_psci_fn_hvc(unsigned long function_id,
			unsigned long arg0, unsigned long arg1,
			unsigned long arg2)
{
	return arm_smccc_hvc(function_id, arg0, arg1, arg2, 0, 0, 0, 0);
}
