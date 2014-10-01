From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed, 01 Oct 2014 12:52:04 -0700
Subject: [PATCH v4 2/2] iommu/arm-smmu: add support for iova_to_phys
 through ATS1PR
In-Reply-To: <61772524.IxG1939KJq@wuerfel> (Arnd Bergmann's message of "Wed,
 01 Oct 2014 10:27:27 +0200")
References: <1412126893-15796-1-git-send-email-mitchelh@codeaurora.org>
 <1412126893-15796-3-git-send-email-mitchelh@codeaurora.org>
 <61772524.IxG1939KJq@wuerfel>
Message-ID: <vnkwoatv600r.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01 2014 at 01:27:27 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 30 September 2014 18:28:13 Mitchel Humpherys wrote:
>> +       if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
>> +                               !(tmp & ATSR_ACTIVE), 50, 100)) {
>> 
>
> This looks really bad.
>
> You are doing up to 50 100us delays, each of which can be much longer,
> so you can do up to 10ms total delay with interrupts disabled.
>
> Don't do that.

Oh wow somehow I forgot I was in atomic context even though I was
explicitly moving to the `_atomic' polling function in this version.
Don't ask.

Let me ratchet that down to a maximum of 10 delays of 5 microseconds
each for v5.


-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
