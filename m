From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 19 Nov 2014 11:06:13 -0700
Subject: [RFC 1/2] mfd: qcom-rpm: Expose sleep state resources to clients
In-Reply-To: <20141112192342.GA19703@sonymobile.com>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1415659966-16200-2-git-send-email-bjorn.andersson@sonymobile.com>
 <20141111120457.GZ24004@x1> <20141111183319.GD16980@sonymobile.com>
 <20141112095200.GD24004@x1> <20141112144508.GD45276@linaro.org>
 <20141112192342.GA19703@sonymobile.com>
Message-ID: <20141119180613.GA941@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12 2014 at 12:23 -0700, Bjorn Andersson wrote:
>On Wed 12 Nov 06:45 PST 2014, Lina Iyer wrote:
>
>> On Wed, Nov 12 2014 at 02:52 -0700, Lee Jones wrote:
>> >On Tue, 11 Nov 2014, Bjorn Andersson wrote:
>> >
>> >> On Tue 11 Nov 04:04 PST 2014, Lee Jones wrote:
>> >>
>> >> > On Mon, 10 Nov 2014, Bjorn Andersson wrote:
>> >> >
>>
>> > > > +	writel_relaxed(BIT(state), RPM_CTRL_REG(rpm, RPM_REQUEST_CONTEXT));
>> >> >
>> >> > How are the state bits organised?
>> >> >
>> >>
>> >> BIT(0) is active mode, BIT(1) is sleep mode, as specified below. I could add
>> >> some sanity checking here if you would like to.
>> >
>> >I'm just double checking that you know what that means.
>> >
>> >BIT(0) == b01
>> >BIT(1) == b10
>> >
>> >It seems strange to represent a single boolean state over 2 bits.
>> >
>> >Also, what happens if b11 or b00 occurs?
>> >
>> Lee is correct, it should be 0 for Active and 1 for Sleep set.
>>
>
>In the caf msm-3.4 tree the regulator core will call e.g. vreg_set_voltage()
>that will call vreg_set(), that will call msm_rpm_set(MSM_RPM_CTX_SET_0,...).
>That comes from the following:
>
>enum {
>	MSM_RPM_CTX_SET_0,
>	MSM_RPM_CTX_SET_SLEEP,
>	MSM_RPM_CTX_SET_COUNT,
>
>	MSM_RPM_CTX_NOTIFICATION = 30,
>	MSM_RPM_CTX_REJECTED = 31,
>};
>
>So there's your 0 and 1.
>
>msm_rpm_set() calls msm_rpm_set_common() that calls msm_rpm_set_exclusive()
>that contains these two statements:
>
>        uint32_t ctx_mask = msm_rpm_get_ctx_mask(ctx);
>	...
>	msm_rpm_write(MSM_RPM_PAGE_CTRL, target_ctrl(MSM_RPM_CTRL_REQ_CTX_0), ctx_mask);
>
>And we have:
>
>static inline uint32_t msm_rpm_get_ctx_mask(unsigned int ctx)
>{
>	return 1UL << ctx;
>}
>
>So, as far as I can see it should be BIT(state) here. But there's a lot of code
>and a lot of indirections here and I've been tricked by it before, so please
>let me know if I got something wrong on the way.
Sorry, I retract my earlier objection. This is how it is, strangely.

>
>Regards,
>Bjorn
