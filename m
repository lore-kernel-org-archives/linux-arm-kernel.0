From: dmitriyz@google.com (Dima Zavin)
Date: Wed, 26 Jan 2011 14:12:59 -0800
Subject: [PATCH v2 02/11] msm: Generalize timer register mappings
In-Reply-To: <8yaei81kjlc.fsf@huya.qualcomm.com>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-3-git-send-email-davidb@codeaurora.org>
	<1295908604.29639.62.camel@c-dwalke-linux.qualcomm.com>
	<8yaei81kjlc.fsf@huya.qualcomm.com>
Message-ID: <AANLkTi=UBfBp-VOQ=n_a4sjA9v_dhcv-rXcXiE6zrf23@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 2:44 PM, David Brown <davidb@codeaurora.org> wrote:
> On Mon, Jan 24 2011, Daniel Walker wrote:
>
>> On Wed, 2011-01-19 at 12:25 -0800, David Brown wrote:
>>> + ? ? ? int global_offset = 0;
>>> +
>>> + ? ? ? if (cpu_is_msm7x01()) {
>>> + ? ? ? ? ? ? ? msm_clocks[MSM_CLOCK_GPT].regbase = MSM_CSR_BASE;
>>> + ? ? ? ? ? ? ? msm_clocks[MSM_CLOCK_DGT].regbase = MSM_CSR_BASE + 0x10;
>>> + ? ? ? } else if (cpu_is_msm7x30()) {
>>> + ? ? ? ? ? ? ? msm_clocks[MSM_CLOCK_GPT].regbase = MSM_CSR_BASE + 0x04;
>>> + ? ? ? ? ? ? ? msm_clocks[MSM_CLOCK_DGT].regbase = MSM_CSR_BASE + 0x24;
>>> + ? ? ? } else if (cpu_is_qsd8x50()) {
>>> + ? ? ? ? ? ? ? msm_clocks[MSM_CLOCK_GPT].regbase = MSM_CSR_BASE;
>>> + ? ? ? ? ? ? ? msm_clocks[MSM_CLOCK_DGT].regbase = MSM_CSR_BASE + 0x10;
>>> + ? ? ? } else if (cpu_is_msm8x60()) {
>>> + ? ? ? ? ? ? ? msm_clocks[MSM_CLOCK_GPT].regbase = MSM_TMR_BASE + 0x04;
>>> + ? ? ? ? ? ? ? msm_clocks[MSM_CLOCK_DGT].regbase = MSM_TMR_BASE + 0x24;
>>> +
>>> + ? ? ? ? ? ? ? /* Use CPU0's timer as the global timer. */
>>> + ? ? ? ? ? ? ? global_offset = MSM_TMR0_BASE - MSM_TMR_BASE;
>>> + ? ? ? } else
>>> + ? ? ? ? ? ? ? BUG();
>>
>> Ifdef's here would be OK I think, your already using the "runtime"
>> checks ..
>
> The point of the change is to get rid of the ifdefs so that we can
> dynamically detect which target we are on. ?Yes, there are other places
> where it doesn't work, but we'll get there gradually.

To be honest I don't understand why you would want to do this at
runtime. You cannot select multiple SoCs in the kernel build anyway,
nor would you want to. Trying to have same kernel to boot on ARM v6
and ARM v7 would already be freaky enough. On top of that mixing 7201a
with all the baggage that it comes with 8x60 just wouldn't make sense.
These architectures are so different that it I can't see that ever
being useful. When would you ever envision building for multiple of
these SoCs at the same time?

--Dima

>
> David
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
>
