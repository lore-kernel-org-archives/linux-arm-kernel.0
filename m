From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Mon, 16 Feb 2015 14:05:15 -0600
Subject: [PATCH v10 4/6] ARM: add vdso user-space code
In-Reply-To: <loom.20150213T053547-381@post.gmane.org>
References: <1411413485-7675-1-git-send-email-nathan_lynch@mentor.com>
 <1411413485-7675-5-git-send-email-nathan_lynch@mentor.com>
 <loom.20150213T053547-381@post.gmane.org>
Message-ID: <54E24D7B.3050806@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2015 10:36 PM, Venkappa Mala wrote:
> Nathan Lynch <nathan_lynch <at> mentor.com> writes:
> 
>> +#ifdef CONFIG_ARM_ARCH_TIMER
>> +
>> +static notrace u64 get_ns(struct vdso_data *vdata)
>> +{
>> +	u64 cycle_delta;
>> +	u64 cycle_now;
>> +	u64 nsec;
>> +
>> +	cycle_now = arch_counter_get_cntvct();
> 
> Hello Nathan,
> 
> Regarding ARM:vDSO, I have enabled your patch set on Cortex-A7/ARMv7, 
> the vDSO is up and running using generic arch timer using physical 
> counter but not with VCT.

Hi,

Sorry for not seeing this earlier but it doesn't look like my address
was in the recipients list, and I just happened to catch up on list
traffic today.

It looks like Catalin already covered everything, but just to sum up --
the patches need to be updated to avoid enabling the VDSO gettimeofday
on systems where CNTVCT is not usable, for whatever reason.  I do not
intend to enable user space / VDSO access to CNTPCT to accommodate
systems that don't initialize the virtual counter/offset correctly.
