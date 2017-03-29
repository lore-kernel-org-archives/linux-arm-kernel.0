From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 29 Mar 2017 18:27:40 +0800
Subject: [PATCH v5 6/9] coresight: add support for CPU debug module
In-Reply-To: <5584203e-cb19-a5d2-45b1-3e78d3482c55@arm.com>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-7-git-send-email-leo.yan@linaro.org>
 <31be033f-514e-e48a-3ba2-a5c5cd477548@arm.com>
 <20170329030735.GA23889@leoy-linaro>
 <5584203e-cb19-a5d2-45b1-3e78d3482c55@arm.com>
Message-ID: <20170329102740.GA20804@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 10:07:07AM +0100, Suzuki K Poulose wrote:

[...]

> >>>+	if (mode == EDDEVID_IMPL_NONE) {
> >>>+		drvdata->edpcsr_present  = false;
> >>>+		drvdata->edcidsr_present = false;
> >>>+		drvdata->edvidsr_present = false;
> >>>+	} else if (mode == EDDEVID_IMPL_EDPCSR) {
> >>>+		drvdata->edpcsr_present  = true;
> >>>+		drvdata->edcidsr_present = false;
> >>>+		drvdata->edvidsr_present = false;
> >>>+	} else if (mode == EDDEVID_IMPL_EDPCSR_EDCIDSR) {
> >>>+		if (!IS_ENABLED(CONFIG_64BIT) &&
> >>>+			(pcsr_offset == EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32))
> >>>+			drvdata->edpcsr_present = false;
> >>>+		else
> >>>+			drvdata->edpcsr_present = true;
> >>
> >>Sorry, I forgot why we do this check only in this mode. Shouldn't this be
> >>common to all modes (of course which implies PCSR is present) ?
> >
> >No. PCSROffset is defined differently in ARMv7 and ARMv8; So finally we
> >simplize PCSROffset value :
> >0000 - Sample offset applies based on the instruction state (indicated by PCSR[0])
> >0001 - No offset applies.
> >0010 - No offset applies, but do not use in AArch32 mode!
> >
> >So we need handle the corner case is when CPU runs AArch32 mode and
> >PCSRoffset = 'b0010. Other cases the pcsr should be present.
> 
> I understand that reasoning. But my question is, why do we check for PCSROffset
> only when mode == EDDEVID_IMPL_EDPCSR_EDCIDSR and not for say mode == EDDEVID_IMPL_EDPCSR or
> any other mode where PCSR is present.

Sorry I misunderstood your question.

I made mistake when I analyzed the possbile combination for mode and
PCSROffset so I thought it's the only case should handle:
{ EDDEVID_IMPL_EDPCSR_EDCIDSR, EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32 }

Below three combinations are possible to exist; so you are right, I
should move this out for the checking:
{ EDDEVID_IMPL_NONE,           EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32 }
{ EDDEVID_IMPL_EDPCSR_EDCIDSR, EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32 }
{ EDDEVID_IMPL_FULL,           EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32 }

Thanks,
Leo Yan
