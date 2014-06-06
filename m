From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Sat, 7 Jun 2014 00:42:58 +0530
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <CAM4voa=cTbobQHi+sBOCy_CDYAnQ6CsvvuoE7XwqFZV_E3gEbQ@mail.gmail.com>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <CAD=FV=Vo1JR6n496Q3FqXjRBkbTBRg89_fJQNsqeRx8WQW_a9w@mail.gmail.com>
 <CAM4voakAMN4jdAZDPz55tnc3woZDieZ5aL3TVU2kYsNHT+AMqg@mail.gmail.com>
 <CAD=FV=UjmN5AwWMPy7mQt-J4A_niO8Ug4r15Ez2ZWPT1g3L=VA@mail.gmail.com>
 <CAM4voa=1FY5bfk095BU=3X=vzqjnCSfdLoXpCix5tOwDgOoioQ@mail.gmail.com>
 <CAD=FV=UwgPQVm_KvHbpoJNs-5EtpyaYJ2rp2f-466uhnob=ixA@mail.gmail.com>
 <CAM4voa=cTbobQHi+sBOCy_CDYAnQ6CsvvuoE7XwqFZV_E3gEbQ@mail.gmail.com>
Message-ID: <CAM4voa=jfGvbDD=Q0uGdE07ktYAMVN4gyrUC-b4H9YFAO1nqzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 7, 2014 at 12:39 AM, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> Hi Doug,
>
> On Sat, Jun 7, 2014 at 12:26 AM, Doug Anderson <dianders@google.com> wrote:
>> Abhilash,
>>
>> On Fri, Jun 6, 2014 at 11:31 AM, Abhilash Kesavan
>> <kesavan.abhilash@gmail.com> wrote:
>>> Hi Doug,
>>>
>>> On Fri, Jun 6, 2014 at 11:50 PM, Doug Anderson <dianders@google.com> wrote:
>>>> Abhilash,
>>>>
>>>>
>>>>
>>>> On Fri, Jun 6, 2014 at 11:12 AM, Abhilash Kesavan
>>>> <kesavan.abhilash@gmail.com> wrote:
>>>>> Hi Doug,
>>>>>
>>>>> On Fri, Jun 6, 2014 at 11:32 PM, Doug Anderson <dianders@google.com> wrote:
>>>>>> Abhilash,
>>>>>>
>>>>>> On Fri, Jun 6, 2014 at 10:36 AM, Abhilash Kesavan
>>>>>> <kesavan.abhilash@gmail.com> wrote:
>>>>>>> Hi Doug,
>>>>>>>
>>>>>>> The first change in the kernel (clearing an iRAM location) is needed
>>>>>>> because of an unnecessary change that we are carrying in the Chrome
>>>>>>> U-boot. There is no reason for us to have the workaround in the
>>>>>>> mainline kernel. Rather, we should remove the check from our u-boot.
>>>>>>> However AFAIR a clean-up patch that I had posted internally was not
>>>>>>> accepted as we had frozen the SPL at the time.
>>>>>>
>>>>>> Ah, is that this one, or a different one?
>>>>>>
>>>>>> https://chromium-review.googlesource.com/#/c/66049/
>>>>> Yes, this along with a kernel side change.
>>>>
>>>> Can we safely take this one without the kernel-side one?
>>> Yes, just the u-boot change should suffice.
>>>>
>>>>
>>>>>> If we land that patch now it won't help since nobody is going to be
>>>>>> updating their read-only firmware.  We'll need to put code somewhere
>>>>>> that fixes it.
>>>>> We just carry the workaround fix locally until we migrate to mainline
>>>>> u-boot for 5420 where the unnecessay check will not be present.
>>>>
>>>> I think there are people out there who want to run a mainline kernel
>>>> on existing Chromebook 2 hardware and don't want to rewrite their RO
>>>> firmware.  We need a solution for those people.
>>> Yes, I see your point. But, do you think someone who has changed the
>>> existing fused kernel on the device to a mainline one would be averse
>>> to applying a couple of small work-around changes as well ? Their
>>> finding this thread and the proposed "magic" fixes may be difficult
>>> but not the actual application I think.
>>>
>>> How about having a page similar to
>>> "http://www.chromium.org/chromium-os/how-tos-and-troubleshooting/using-an-upstream-kernel-on-snow"
>>> for Peach ? We could have the work-arounds listed there.
>>
>> We can (though the fewer weird things we have the better), but we
>> definitely need to provide workarounds that don't require people to
>> change their RO firmware.
> I do not quite agree with this. They do not need to change their RO
> firmware, just modify their boot commands.
>>
>> Thinking all that through, I think the answer is that we want to
>> abandon the U-Boot change above
>> <https://chromium-review.googlesource.com/#/c/66049/>.  At this point
>> we're never going to take it at this point and there's no possible way
>> to do it in an RW firmware update (right?) since any workaround would
>> be overwritten by the SPL at resume time.
> Sure, will abandon.
>>
>> So the proper "fix" for the "mw.l 02073028 0" is a kernel fix.  ...and
> I believe there is no "proper" fix for incorrect existing code in
> non-mainline u-boot.
>
>> if upstream doesn't want land it because it's impure then we'll just
>> have to list it on our "apply these hacks to your kernel".  You sent
>> me this as a kernel fix before and now I think I understand why (to
>> handle the s2r case).  Can you please post this up to the mailing
>> list?  Please make sure it will handle the suspend/resume case
>> whenever suspend/resume starts working (I haven't tested but I
>> remember hearing that it doesn't work).
>
> Are you talking about the re-writing the mcpm entry point address post-resume ?
S2R does not work right now, but patches have been posted for the
same. I did test the MCPM patches across an S2R cycle and it worked
fine. Implying the SRAM was being retained. I guess that would be
because the regulator support has not been added/enabled for Peach.
>>
>> Note: I think there are actually two possible kernel fixes (right?):
>> 1. Have the kernel itself (re)write the code at 0x02073000 at bootup /
>> resume time.  I don't know of any reason why this should need to be in
>> U-Boot.  Maybe upstream would take this?
>
>>
>> 2. Have the kernel clear this flag to work with existing Chromebook 2 firmware.
>>
>> --
>>
>> The proper "fix" for the "mw.l 10d25000 3" is a U-Boot fix.  Let me
>> see if I can put together something that will handle this in RW
>> U-Boot.  Even if we don't officially ship this RW U-Boot we can always
>> point people at the binaries.
>>
>>
>> Does that make sense?
>>
>> -Doug
