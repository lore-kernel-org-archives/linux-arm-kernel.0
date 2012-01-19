From: eranian@googlemail.com (stephane eranian)
Date: Thu, 19 Jan 2012 13:55:45 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMsRxfJ2VrfFZevkxoZzSD5fZn1CErF68y0ny+MZi5r___ERJA@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
 <4F0B182D.7060507@us.ibm.com>
 <20120109224945.GA23090@mudshark.cambridge.arm.com>
 <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
 <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
 <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
 <CAMsRxfLtLnMiP0ZGr6rNLv-UeLUwOSJ=7do2nezOU5OkOA+MbQ@mail.gmail.com>
 <CACVXFVMbrQGi4Sg9TUPP5Bcc5kzFoX74n=ii4QrDRudbuDHOGg@mail.gmail.com>
 <CAMsRxfJmHkZw2f0A+4FsStJpXk_vrxvDduRcRGkcWpqp8a9m_w@mail.gmail.com>
 <CACVXFVOQNDRs=c8A2YC+WvYAHs5Abbz-QUEe1VJqrj2esFO11g@mail.gmail.com>
 <CAMsRxf+e38jRcyxESLhYDZ3OL910AQdapZD9P8vWDXfUE34DAA@mail.gmail.com>
 <CACVXFVPnhSy_DbdK+ro8G78QjL2s6fBBq1Dvq-pmxJ20qA-ymA@mail.gmail.com>
 <CAMsRxfJ2VrfFZevkxoZzSD5fZn1CErF68y0ny+MZi5r___ERJA@mail.gmail.com>
Message-ID: <CAMsRxfKhka80UNCJMvP-Avj4ThzYg2Y9t_Rkw8_q2QUdnT1cbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 1:51 PM, stephane eranian
<eranian@googlemail.com> wrote:
> On Thu, Jan 19, 2012 at 1:45 PM, Ming Lei <ming.lei@canonical.com> wrote:
>> Hi,
>>
>> On Thu, Jan 19, 2012 at 7:34 PM, stephane eranian
>> <eranian@googlemail.com> wrote:
>>> Hi,
>>>
>>> Ok some update on this.
>>> With your .config file + 3.2.0 (Linus) + patch 3, 4, 5, 6, I get a kernel that
>>
>> You forget patch 1 and patch 2?
>>
> They are already in 3.2.0. Unless I am mistaken.
>
e0516a6 arm: pmu: allow platform specific irq enable/disable handling
14eec97 arm: introduce cross trigger interface helpers

> are you sure you don't have anything else applied?
>
>>> boots. It does recognize the PMU. However, it still does not count correctly
>>> and I believe for the same reason.: no interrupts are delivered.
>>>
>>> I run a cycle burner program on CPU0, I watch /proc/interrupts.
>>> and then I run ?libpfm4 program that does per-cpu monitoring on CPU0 and
>>> print the counts every second:
>>
>> I just run 'perf top', then watch output of '/proc/interrupts' in
>> another terminal. I am sure I can see perf is OK and interrupts are
>> generated on my pandaboard.
>>
>>>
>>> $ sudo ./syst_count -d 10 -p -c 0 -e cpu_cycles
>>> <press CTRL-C to quit before 10s time limit>
>>> # 1s -----
>>> CPU0 ? G0 ?1008129147 ? ? ? ? ? cpu_cycles (scaling 0.00%,
>>> ena=1000152588, run=1000152588)
>>> # 2s -----
>>> CPU0 ? G0 ?2016240766 ? ? ? ? ? cpu_cycles (scaling 0.00%,
>>> ena=2000335693, run=2000335693)
>>> # 3s -----
>>> CPU0 ? G0 ?3024249265 ? ? ? ? ? cpu_cycles (scaling 0.00%,
>>> ena=3000427245, run=3000427245)
>>> # 4s -----
>>> CPU0 ? G0 ?4072779364 ? ? ? ? ? cpu_cycles (scaling 0.00%,
>>> ena=4040710449, run=4040710449)
>>> # 5s -----
>>> CPU0 ? G0 ?785954705 ? ? ? ? ? ?cpu_cycles (scaling 0.00%,
>>> ena=5040954589, run=5040954589)
>>> # 6s -----
>>> CPU0 ? G0 ?1803397848 ? ? ? ? ? cpu_cycles (scaling 0.00%,
>>> ena=6050384520, run=6050384520)
>>> # 7s -----
>>>
>>> You clearly see that after 4s you've reached the 32-bit limit of the
>>> counter and then you wrap around.
>>> It should show 5 billions or so cycles. Over the entire run, no
>>> arm-pmu interrupt was delivered according
>>> to /proc/interrupts.
>>>
>>> I guess you can test the same condition using perf directly, use a
>>> program that burns cycles
>>> for a know duration. Try < 4s and then > 4s. I use 1s vs. 10s and I
>>> expect the count to be
>>> 10x larger in the latter test case. If it's not then, interrupts are
>>> not coming in,
>>>
>>>
>>> On Thu, Jan 19, 2012 at 2:21 AM, Ming Lei <ming.lei@canonical.com> wrote:
>>>> Hi,
>>>>
>>>> On Thu, Jan 19, 2012 at 5:58 AM, stephane eranian
>>>> <eranian@googlemail.com> wrote:
>>>>> Ming,
>>>>>
>>>>> Ok, so I used Linus' tree @
>>>>>
>>>>> It already includes patches #1 and #2. I applied 4-6.
>>>>
>>>> The patch #3 is missed?
>>>>
>>>>> Recompiled but my kernel does not boot, I don't see
>>>>> anything on the serial console. Could be a broken
>>>>
>>>> I don't think that the patches can cause your non boot, you
>>>> can try the linus tree kernel first, then try the patches.
>>>>
>>>>> .config file. Could you send me your .config for Panda?
>>>>
>>>> See the attachment.
>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>> On Wed, Jan 18, 2012 at 11:07 AM, Ming Lei <ming.lei@canonical.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Wed, Jan 18, 2012 at 5:54 PM, stephane eranian <eranian@googlemail.com>
>>>>>>> Should I use Will's -next tree as the base instead of Linus'?
>>>>>>
>>>>>> Either one is OK. If you use linus tree as base, you need to apply the #1 and
>>>>>> #2 patch manually.
>>>>>>
>>>>>>> Given that MARC is shutdown today, would you mind packing those patches
>>>>>>> into a tarball and sending them to me directly?
>>>>>>
>>>>>> See attachment, which includes the patches from #3 to #6.
>>>>>>
>>>>>>>
>>>>>>> When you mention Will's -next tree, are you talking about:
>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
>>>>>>
>>>>>> It is perf/omap4 brach, you can pick up the two patches[1][2] directly from
>>>>>> the branch.
>>>>>>
>>>>>>
>>>>>> thanks,
>>>>>> --
>>>>>> Ming Lei
>>>>>>
>>>>>> [1], http://git.kernel.org/?p=linux/kernel/git/will/linux.git;a=commit;h=7924a3eba0766348d6d6a56cbb9873cdbcab0d8c
>>>>>>
>>>>>> [2], http://git.kernel.org/?p=linux/kernel/git/will/linux.git;a=commit;h=bde071f005e2dc71378aff69e86b961d8cd7922f
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>>> the body of a message to majordomo at vger.kernel.org
>>>>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
