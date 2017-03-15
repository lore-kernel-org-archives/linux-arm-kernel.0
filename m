From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Wed, 15 Mar 2017 13:33:16 +0100
Subject: [PATCH] drm/exynos: Print kernel pointers in a restricted form
In-Reply-To: <ee50f87d-d79e-d74e-25b3-091c49a5e1d4@samsung.com>
References: <20170314183804.13788-1-krzk@kernel.org>
 <e1800491-0b60-74d1-1377-756d5b0bb371@math.uni-bielefeld.de>
 <20170314190859.y55wlc4z7xdsbbxg@kozik-lap>
 <de5e8583-748b-9df2-f7cc-c1b4fb499d17@math.uni-bielefeld.de>
 <20170314195240.gj7jbgql7hfziw42@kozik-lap>
 <CGME20170314204224epcas4p1c8b7716ebbebe60d14463f64da61d135@epcas4p1.samsung.com>
 <e147ef15-0f7c-19f0-8e1b-db6a75930932@math.uni-bielefeld.de>
 <ee50f87d-d79e-d74e-25b3-091c49a5e1d4@samsung.com>
Message-ID: <ac039bb8-c10a-63db-274a-796afaa5c970@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrzej,

note that i had already pointed Krzysztof to that documentation in my
previous mail.

- Tobias

Andrzej Hajda wrote:
> Hi Tobias,
> 
> On 14.03.2017 21:41, Tobias Jakobi wrote:
>> Krzysztof Kozlowski wrote:
>>> On Tue, Mar 14, 2017 at 08:17:35PM +0100, Tobias Jakobi wrote:
>>>> Krzysztof Kozlowski wrote:
>>>>> On Tue, Mar 14, 2017 at 08:01:41PM +0100, Tobias Jakobi wrote:
>>>>>> Hello Krzysztof,
>>>>>>
>>>>>> I was wondering about the benefit of this. From a quick look these are
>>>>>> all messages that end up in the kernel log / dmesg.
>>>>>>
>>>>>> IIRC %pK does nothing there, since dmest_restrict is supposed to be used
>>>>>> to deny an unpriviliged user the access to the kernel log.
>>>>>>
>>>>>> Or am I missing something here?
>>>>> These are regular printks so depending on kernel options (e.g. dynamic
>>>>> debug, drm.debug) these might be printed also in the console. Of course
>>>>> we could argue then if access to one of the consoles is worth
>>>>> securing.
>>>> This here suggests otherwise.
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/sysctl/kernel.txt#n388
>>>>
>>>> I have not tested this, but IIRC %pK is not honored by the kernel
>>>> logging infrastucture. That's why dmesg_restrict is there.
>>>>
>>>> Correct me if I'm wrong.
>>> The %pK will not help for dmesg or /proc/kmsg but it will help for
>>> console (/dev/ttySACN, ttySN etc) because effectively it uses the same
>>> vsprintf()/pointer() functions.
>> Thanks for the explanation, I didn't know that there was a difference
>> there. In that case, looks good to me.
>>
>>
> 
> Just to clarify %pK:
> 
> Documentation/printk-formats.txt:
>         %pK     0x01234567 or 0x0123456789abcdef
> 
>         For printing kernel pointers which should be hidden from
> unprivileged
>         users. The behaviour of %pK depends on the kptr_restrict sysctl
> - see
>         Documentation/sysctl/kernel.txt for more details.
> 
> Documentation/sysctl/kernel.txt:
> 
> kptr_restrict:
> 
> This toggle indicates whether restrictions are placed on
> exposing kernel addresses via /proc and other interfaces.
> 
> When kptr_restrict is set to (0), the default, there are no restrictions.
> 
> When kptr_restrict is set to (1), kernel pointers printed using the %pK
> format specifier will be replaced with 0's unless the user has CAP_SYSLOG
> and effective user and group ids are equal to the real ids. This is
> because %pK checks are done at read() time rather than open() time, so
> if permissions are elevated between the open() and the read() (e.g via
> a setuid binary) then %pK will not leak kernel pointers to unprivileged
> users. Note, this is a temporary solution only. The correct long-term
> solution is to do the permission checks at open() time. Consider removing
> world read permissions from files that use %pK, and using dmesg_restrict
> to protect against uses of %pK in dmesg(8) if leaking kernel pointer
> values to unprivileged users is a concern.
> 
> When kptr_restrict is set to (2), kernel pointers printed using
> %pK will be replaced with 0's regardless of privileges.
> ---
> 
> Regards
> Andrzej
> 
