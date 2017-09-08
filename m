From: gengdongjiu@huawei.com (gengdongjiu)
Date: Fri, 8 Sep 2017 15:19:21 +0800
Subject: [PATCH] arm64: KVM: VHE: reset PSTATE.UAO when switch to host
In-Reply-To: <d01b49a2-e204-73af-23e3-5fd7f7202859@arm.com>
References: <0184EA26B2509940AA629AE1405DD7F2015EF473@DGGEMA503-MBX.china.huawei.com>
 <d01b49a2-e204-73af-23e3-5fd7f7202859@arm.com>
Message-ID: <1bcd0c1e-c3b5-aac4-bb4f-83ee14b1d1ab@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/9/7 23:23, Marc Zyngier wrote:
> On 07/09/17 16:03, gengdongjiu wrote:
>>> On 07/09/17 12:49, gengdongjiu wrote:
>>>>
[...]

> 
> I really cannot think of a good reason why we'd want to do that. Playing
> with set_fs() is almost universally wrong, and I'm certainly going to
> oppose to any change in that area unless the code that calls set_fs()
> has been made public and properly reviewed. Until then, UAO/PAN will
> stay as they are unless you prove that our current code is wrong.

Marc,

sorry I have another question for the PAN.

In the non-VHE mode, The host kernel is running in the EL1. Before host kernel enter guest, host OS will call 'HVC' instruction to do the world-switch,
and the pstate.PAN will be saved into the SPSR_EL2. When world-switch back to host kernel from EL2, it will call 'eret' instruction to EL1 host,
this 'eret' instruction will restore the SPSR_EL2 to the PSTATE. so the PSTATE.PAN will be restored.

For the Non-VHE mode, in the EL2 where mainly have word-switch code, do you think it needs to reset the PSTATE.PAN? From the spec, it does not provide SCTLR_EL2.SPAN bit for non-VHE mode,
so reset the PSTATE.PAN does not sure whether it is needed or whether affects the performance. If you think it is needed for El2 in Non-VHE mode, moving the reset PSTATE.PAN to
the exception entry to EL2 may be better, such as "el1_sync", because host can also call 'hvc' instruction without guest running.

> 
> 	M.
> 
