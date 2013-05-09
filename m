From: pranavkumar@linaro.org (Pranavkumar Sawargaonkar)
Date: Thu, 9 May 2013 21:21:49 +0530
Subject: [PATCH] arm64: KVM: Fix HCR_EL2 and VTCR_EL2 configuration bits
In-Reply-To: <518B9802.1080505@arm.com>
References: <1368099611-4738-1-git-send-email-pranavkumar@linaro.org>
 <518B9802.1080505@arm.com>
Message-ID: <CAAHg+HhO873_Cs_ucKL_T_NO9sV61dRBh1cvtRD3VAiM3sq8Yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 9 May 2013 18:05, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Pranav,
>
> On 09/05/13 12:40, Pranavkumar Sawargaonkar wrote:
>> This patch does following fixes:
>>
>> 1. Make HCR_* flags as unsigned long long constants
>> Reason : By default, compiler assumes numeric constants as
>> signed hence sign extending it when assigned to unsigned variable
>> such as hcr_el2 (in VCPU context). This accidently sets HCR_ID and
>> HCR_CD making entire guest memory non-cacheable. On real HW, this
>> breaks Stage2 ttbl walks and also breaks VirtIO.
>
> Ah. Nice one. I fixed a couple of similar bugs already, but didn't
> notice that one yet, for obvious reasons...
>
> I'll probably rewrite that patch to use the UL(x) macro instead of
> _AC(), as we don't need to have an unsigned long long, and that makes
> the code look much nicer (sort of).
>

Sure I will resubmit with UL change.
Yeah this issue keeps wondering me and anup, unexpected VIRTIO
behavior on board for sometime on board till finally realized :)

>> 2. VTCR_EL2_ORGN0_WBWA and VTCR_EL2_IRGN0_WBWA macros.
>
> Blah. Copy paste. Fucks me all the time.
>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> ---
>>  arch/arm64/include/asm/kvm_arm.h |   73 +++++++++++++++++++-------------------
>>  1 file changed, 37 insertions(+), 36 deletions(-)
>
> Thanks a lot,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
>

Thanks,
Pranav
