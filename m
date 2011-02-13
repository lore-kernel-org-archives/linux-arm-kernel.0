From: ccross@android.com (Colin Cross)
Date: Sun, 13 Feb 2011 13:25:05 -0800
Subject: [RFC PATCH 3/3] ARM: vfp: Use cpu pm notifiers to save vfp state
In-Reply-To: <AANLkTinYf3G+b8n6okeZk44xvO0xP0dw8S_dfE2C4E1-@mail.gmail.com>
References: <1297373487-23902-1-git-send-email-ccross@android.com>
	<1297373487-23902-4-git-send-email-ccross@android.com>
	<1297426345.17584.99.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinYf3G+b8n6okeZk44xvO0xP0dw8S_dfE2C4E1-@mail.gmail.com>
Message-ID: <AANLkTik=RgXyy-RR2aPy4bVeE5XjYTsiHO7OML3ZbU7S@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 11:50 AM, Colin Cross <ccross@android.com> wrote:
>> Something like below (untested):
>>
>> ? ? ? ?if (last_VFP_context[cpu]) {
>> ? ? ? ? ? ? ? ?vfp_save_state(last_VFP_context[cpu], fpexc);
>> ? ? ? ? ? ? ? ?/* force a reload when coming back from idle */
>> ? ? ? ? ? ? ? ?last_VFP_context[cpu] = NULL;
>> ? ? ? ? ? ? ? ?fmxr(FPEXC, fpexc & ~FPEXC_EN);
>> ? ? ? ?}
One more fix is necessary, the VFP will usually not be enabled when
this is called.  The VFP needs to be enabled before vfp_save_state,
and then disabled after.

> ? ? ? ?/* save state for resumption */
> ? ? ? ?if (last_VFP_context[ti->cpu]) {
> ? ? ? ? ? ? ? ?printk(KERN_DEBUG "%s: saving vfp state\n", __func__);
> ? ? ? ? ? ? ? ?vfp_save_state(last_VFP_context[ti->cpu], fpexc);
>
> ? ? ? ? ? ? ? ?/* disable, just in case */
> ? ? ? ? ? ? ? ?fmxr(FPEXC, fpexc & ~FPEXC_EN);
> ? ? ? ?}
Same fix is needed here.
