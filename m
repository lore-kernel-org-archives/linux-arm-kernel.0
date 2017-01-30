From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jan 2017 15:52:09 +0000
Subject: [PATCH v9 0/4] arm64: arch_timer: Add workaround for
 hisilicon-161010101 erratum
In-Reply-To: <20170124163551.GB2021@mai>
References: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
 <765699aa-cbc6-67eb-9108-cbf335338e4c@linaro.org>
 <35cf654f-3944-fc76-5120-25e33f71be4f@arm.com>
 <20170124163551.GB2021@mai>
Message-ID: <20170130155209.GC1160@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tue, Jan 24, 2017 at 05:35:51PM +0100, Daniel Lezcano wrote:
> That wasn't my point. The way the errata are handled in this patchset is
> elegant and I have nothing against it. I'm worried about the accumulation of
> fixes, hacks, workarounds in this driver. So my naive question is about not
> using an identified bogus clocksource and use another one available on the
> board, which is I believe often the case, instead of trying to deal with bogus
> hardware. Apparently, that is not possible because 1) of KVM, 2) of duplication
> and 3) of integration with the ARM64 code.
> 
> Does it mean it is not possible to use another clocksource/clockevent than the
> armv8-timer ?
> 
> Can you elaborate these three points ? 

Practically speaking, these platforms have no other clocksource or
clockevent device that I am aware of, which can be enumerated in a
standard manner using ACPI.

For point 1, KVM is intimately familiar with the architected timer
(which is managed during VM context switch in hyp code, for example).
KVM knows nothing of other clocksource or clockevent devices, and it is
far from trivial to plumb these in either way. Since the architected
timer is a mandatory part of ARMv8, guests may attempt to use it
regardless.

For point 3, arm64 currently requires the architected timer as this is
mandatory per the ARMv8 architecture. It is non-trivial to add support
for other devices to the vDSO, the delay loop, etc.

Localising these quirks to the architected timer driver is by far the
least worst option available. Marc and I are perfectly happy to manage
that.

Thanks,
Mark.
