From: kassey1216@gmail.com (Kassey)
Date: Thu, 31 Aug 2017 08:56:20 +0800
Subject: kasan is not working on 3.18 kernel due to patch "BACKPORT:
 kernel: add kcov code coverage"
In-Reply-To: <CACT4Y+aMFp47QecE6QeY-K6kFz9pnJ+YT0xHo+5vO8qvjN7Cuw@mail.gmail.com>
References: <CAKwPUoxHDW4x=uqY5o2rimHDkDPqaN1GdUZ9=eHuP1hwsa7ngw@mail.gmail.com>
 <CACT4Y+aMFp47QecE6QeY-K6kFz9pnJ+YT0xHo+5vO8qvjN7Cuw@mail.gmail.com>
Message-ID: <CAKwPUozYTTqZhvdFxOQ5jqUR+k2622WWzcyp6BhZs=DGhx5NWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Dmitry:
      you are right. upstream kernel did not touch the
      scripts/Makefile.lib for kasan, I am checking my internel tree now.

     thanks for your kind remind.


BR
Kassey

On Wed, Aug 30, 2017 at 4:50 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 30, 2017 at 10:20 AM, Kassey <kassey1216@gmail.com> wrote:
>> hi, Dmitry:
>>     with your change on 3.18 kernel,
>>
>>      https://github.com/Elite-Kernels/HTC-10/commit/7c8e808c673b50a52e6b5db9bba54678386fa61b
>>
>>     it was find that cflags for GCC with KASAN enabled is not working.
>>     testing is doing arm64 platfrom with below configure and gcc 5.1.1
>>
>>     +CONFIG_KASAN=y
>>     +CONFIG_TEST_KASAN=m
>>
>>
>>
>>     and the issue can be fixed by the change, would you please review ?
>>
>> Author: Kassey <kassey1216@gmail.com>
>> Date:   Wed Aug 30 15:45:58 2017 +0800
>>
>>     scripts: correct cflags for kasan
>>
>>     Signed-off-by: Kassey<kassey1216@gmail.com>
>>
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index cea530c..0f1d004 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -125,7 +125,7 @@ endif
>>  #
>>  ifeq ($(CONFIG_KASAN),y)
>>  _c_flags += $(if $(patsubst n%,, \
>> -
>> $(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)$(CONFIG_KASAN_SANITIZE_ALL)),
>> \
>> +               $(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)y), \
>>                 $(CFLAGS_KASAN))
>>  endif
>
>
> Hi Kassey,
>
> This is a patch on top of what?
>
> It does not look like the KCOV patch has any relation to this. It did
> not touch KASAN stuff in scripts/Makefile.lib.
>
> Do you know who backported the KCOV patch? The backport mentions some
> conflicts, maybe that's the problem. But I don't know what were the
> conflicts.
>
> What's the current failure mode?
>
> Why does upstream work? What's different in your tree?
>
> I don't feel that I have enough information to say anything regarding the patch.



-- 
Best regards
Kassey
