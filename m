From: trblinux@gmail.com (Tushar Behera)
Date: Mon, 23 Jun 2014 09:26:41 +0530
Subject: mainline boot: 64 boots: 62 pass, 2 fail (v3.16-rc1-2-gebe0618)
In-Reply-To: <53A2BE94.2010308@gmail.com>
References: <539fdd37.e7bc420a.76b9.ffffb583@mx.google.com>	<CAGa+x85nqPbH-sye28ni=gUEdgjGdUDqHhv1+0pV5aO8y1+wHQ@mail.gmail.com>	<53A106F1.10201@gmail.com>
 <CAGa+x8527FEPk6fg5kv-fbOzK3MzcFooFGE9Me12b9C_Pv=UzA@mail.gmail.com>
 <53A2AE11.2050208@gmail.com> <53A2BE94.2010308@gmail.com>
Message-ID: <53A7A579.4010702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding linux-samsung-soc and linux-arm-kernel ML for wider audience.

On 06/19/2014 04:12 PM, Tushar Behera wrote:
> On 06/19/2014 03:02 PM, Tushar Behera wrote:
>> On 06/18/2014 09:22 AM, Kevin Hilman wrote:
>>> On Tue, Jun 17, 2014 at 8:26 PM, Tushar Behera <trblinux@gmail.com> wrote:
>>>> On 06/17/2014 10:23 PM, Kevin Hilman wrote:
>>>>> Sachin,
>>>>>
>>>>> On Mon, Jun 16, 2014 at 11:16 PM, Kevin's boot bot <khilman@linaro.org> wrote:
>>>>>>
>>>>>> Tree/Branch: mainline
>>>>>> Git describe: v3.16-rc1-2-gebe0618
>>>>>> Failed boot tests (console logs at the end)
>>>>>> ===========================================
>>>>>>      exynos5420-arndale-octa:     FAIL:    arm-exynos_defconfig
>>>>>>                 ste-snowball:     FAIL:    arm-u8500_defconfig
>>>>>
>>>>> FYI... these failures are getting more consistent on my octa board,
>>>>> but still not failing every time.
>>>>>
>>>>> Kevin
>>>>>
>>>>
>>>> Hi Kevin,
>>>>
>>>> Same here.
>>>>
>>>> Observation: If you soft-reset the board (through the jumpers) after
>>>> getting this problem, the problem keeps repeating. But if you hard-reset
>>>> the board (by removing the power cord), the problem doesn't occur during
>>>> next iteration.
>>>
>>> I don't ever use the soft-reset, I only toggle the wall power.  I
>>> don't ever actually remove the power cord though, I'm using a
>>> USB-controlled relay to toggle the wall power.
>>>
>>> Kevin
>>>
>>
>> Laura,
>>
>> We are getting following kernel panic [1] (not always, but quite
>> regularly) while booting Arndale-Octa (based on Samsung's Exynos5420)
>> board with upstream kernel. I haven't observed this issue with other
>> boards yet.
>>
>> This issue is observed when I am booting with uImage + dtb (within
>> roughly ~10 iterations).
>>
> 
> Some more information:
> 
> The boot logs are provided in pastebin, okay[2] and failed[3].
> 
> In case of boot failures, I am getting a higher value for vm_total_pages
> (684424 in [3]). In case of successful boot on my board, it is always
> 521232 [2] on my board.
> 
> [2] http://pastebin.com/1iLaizuL
> [3] http://pastebin.com/5tdDt4GL
> 
>> There is no issue when I am booting appended zImage (zImage+dtb). I
>> tried running it over 200 cycles, but without any failure.
>>
>> 'git bisect' points to this commit.
>> commit 1c2f87c22566 "ARM: 8025/1: Get rid of meminfo"
>>
>> Reverting this commit on top of v3.16-rc1-17-ge99cfa2, I tested for
>> around 100 iterations of booting with uImage+dtb, without any failure.
>>
>> [1] Kernel log
>> Unhandled fault: external abort on non-linefetch (0x008) at 0xffc00000
>> Internal error: : 8 [#1] PREEMPT SMP ARM
>> Modules linked in:
>> CPU: 0 PID: 1136 Comm: kworker/u16:0 Not tainted
>> 3.15.0-rc1-00027-g1c8c3cf-dirty #5
>> task: ed0f5800 ti: eda52000 task.ti: eda52000
>> PC is at __copy_to_user_std+0x4c/0x3a8
>> LR is at copy_page_to_iter+0xb0/0x26c
>> pc : [<c01b858c>]    lr : [<c00982c0>]    psr: 60000113
>> sp : eda53de4  ip : 00000000  fp : ee103040
>> r10: ed9fb700  r9 : 00000080  r8 : eda53eb8
>> r7 : ffc00000  r6 : 00000000  r5 : 00000080  r4 : eda53e78
>> r3 : 00000000  r2 : 00000000  r1 : ffc00000  r0 : ed9fb700
>> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>> Control: 10c5387d  Table: 2000406a  DAC: 00000015
>> Process kworker/u16:0 (pid: 1136, stack limit = 0xeda52240)
>>
> 
> 


-- 
Tushar Behera
