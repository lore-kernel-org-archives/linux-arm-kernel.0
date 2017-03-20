From: fu.wei@linaro.org (Fu Wei)
Date: Mon, 20 Mar 2017 17:43:29 +0800
Subject: [PATCH v21 01/13] clocksource: arm_arch_timer: introduce two
 functions to get the frequency from mmio and sysreg.
In-Reply-To: <CADyBb7vZ4G+q1y6w6OVQ7i-ZiTtcdx_w2BOSWqy=2jWhAV6Hmw@mail.gmail.com>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-2-fu.wei@linaro.org>
 <20170317180513.GB15909@leverpostej>
 <CADyBb7vZ4G+q1y6w6OVQ7i-ZiTtcdx_w2BOSWqy=2jWhAV6Hmw@mail.gmail.com>
Message-ID: <CADyBb7vawnjnL6Phxc_owTnEK0qf95cYAUWPga9axGqEWc46Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 20 March 2017 at 15:36, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Mark,
>
> On 18 March 2017 at 02:05, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Tue, Feb 07, 2017 at 02:50:03AM +0800, fu.wei at linaro.org wrote:
>>> +static u32 arch_timer_get_sysreg_freq(void)
>>> +{
>>> +     /*
>>> +      * Try to get the frequency from the CNTFRQ of sysreg.
>>> +      */
>>> +     return arch_timer_get_cntfrq();
>>> +}
>>
>> We already have arch_timer_get_cntfrq(), so I don't see the point in
>> this wrapper.
>>
>>> +static u32 arch_timer_get_mmio_freq(void __iomem *cntbase)
>>> +{
>>> +     /*
>>> +      * Try to get the frequency from the CNTFRQ of timer frame registers.
>>> +      * Note: please verify cntbase in caller.
>>> +      */
>>> +     return readl_relaxed(cntbase + CNTFRQ);
>>> +}
>>
>> Wrapping the MMIO read makes sense if we're going to do this in more
>> than one place, so I'm happy with this wrapper.
>>
>> If you can s/arch_timer_get_mmio_freq/arch_timer_get_cntfrq/, and drop
>
> sorry, May I guess that is
> "s/arch_timer_get_mmio_freq/arch_timer_get_mmio_cntfrq/"
> or
> "s/arch_timer_get_mmio_freq/arch_timer_mem_get_cntfrq/"
>
> which one do you prefer? :-)

keeping using arch_timer_get_cntfrq();  for per-CPU arch timer, then

+static u32 arch_timer_mem_get_cntfrq(void __iomem *cntbase)
+{
+       return readl_relaxed(cntbase + CNTFRQ);
+}
+

Is that OK for you?

>
>> the comments, then this looks fine to me.
>>
>> Thanks,
>> Mark.
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
