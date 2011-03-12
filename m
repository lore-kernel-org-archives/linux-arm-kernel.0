From: vb@vsbe.com (vb at vsbe.com)
Date: Fri, 11 Mar 2011 16:14:44 -0800
Subject: compiling 2.6.37 kernel in THUMB2 mode
In-Reply-To: <AANLkTikG=euGb1f4v50p9xwYtSuZ78aRgJ6XTfxy0TPR@mail.gmail.com>
References: <AANLkTi=bJwvTMk0B9N5AAbkNXEh_Wmvu75qrdHeL2Rrh@mail.gmail.com>
	<alpine.LFD.2.00.1102152257500.14920@xanadu.home>
	<AANLkTinQzK=s_r+_uaNRkq4MTPcF4zVE2aHPx5cqwYAN@mail.gmail.com>
	<AANLkTi=PLJBZ=Q-4k8ZUbX4S3w7f3WfUd9acb7iVYGBP@mail.gmail.com>
	<AANLkTi=_=jzs+MrvGbwF3L0c_eSq4nnbqE-xZ_+Z5fgH@mail.gmail.com>
	<AANLkTinKhCG4HauFHrPd=qr9vmVheH59vu2Be=tWoJft@mail.gmail.com>
	<AANLkTik1FY=K1Wuo=vnh5xuq6aS1x2d2Km=ByrCSufJC@mail.gmail.com>
	<AANLkTi=3s6ZRkaBG4uaS=7kaLWD-q2MgN0cN1otBrcmy@mail.gmail.com>
	<AANLkTikG=euGb1f4v50p9xwYtSuZ78aRgJ6XTfxy0TPR@mail.gmail.com>
Message-ID: <AANLkTintEi=JO222wQARaacpfHPor5usnz-qhNAAFXjm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2011 at 2:44 PM,  <vb@vsbe.com> wrote:
>
> boot.ok:usb 3-1.4: SerialNumber: 07A80C01174E078E
> boot.th:usb 3-1.4: SerialNumber: 07AA08011D51D473
>

oh, geez, this is embarrassing - please disregard this 'clue', but th
rest of mystery remains - linux does not boot all the way...

cheers,
/vb


> I wonder if this is an indication of some USB problems (which would
> explain why the file system fails to mount), but find it hard to come
> up with a theory.
>
> I wonder if this rings a bell with anyone,
>
> thank you in advance,
>
> Vadim
>
>
> On Fri, Feb 18, 2011 at 1:26 AM, Dave Martin <dave.martin@linaro.org> wrote:
>> On Thu, Feb 17, 2011 at 5:30 PM, ?<vb@vsbe.com> wrote:
>>
>> [...]
>>
>>>
>>> Hi Dave,
>>>
>>> thank you again for the hints.
>>>
>>> I am trying to build an image for a Tegra2 based platform, it s a
>>> 2.6.37 based tree with a fair amount of private additions (to be
>>> upstreamed at some point), which does now come up and run in ARM mode.
>>> I am trying to see if it can run in Thumb mode.
>>>
>>> It looks like certain files need to be compiled in ARM mode even when
>>> THUMB2_KERNEL is enabled, but I don't see this happening in 2.6.37, I
>>> was wondering how this is done in your tree.
>>
>> Generally, this can be kept to a minimum.
>>
>> On OMAP, the low-level PM code calls into firmware which cannot cope
>> with interworking between ARM and Thumb. ?The PM code on the ARM side
>> could be made to work with this even if it is mostly built in Thumb,
>> but that would be complex and not really worth the pain.
>>
>> You may have this problem if you're trying to communicate with
>> firmware, but it's best if you port everything else to be buildable in
>> Thumb-2: the primary reason is that for backwards compatibility
>> reasons, much of the assembler code in the kernel doesn't support
>> ARM/Thumb interworking either. ?This means that mixing ARM and Thumb
>> code in the kernel will lead to problems unless you're careful.
>>
>>>
>>> I tried building an OMAP image, but it does not build in Thumb mode,
>>> and Thumb can't even be enabled for it because CPU_V6 configured in.
>>> So I was wondering if this tree has some other working config which
>>> does use Thumb mode. I'll look at the config files you mentioned, but
>>> any suggestions/warnings about converting a kernel to work in Thumb
>>> mode are welcome,
>>
>> Assuming you started with omap2plus_defconfig, you need to remove
>> CONFIG_ARCH_OMAP2 from the config. ?It's not possible to incorporate
>> support for omap2 with CONFIG_THUMB2_KERNEL enabled because ARMv6
>> doesn't support Thumb-2.
>>
>> Here's the config I was using:
>> http://people.linaro.org/~dmart/arm_omap-thumb2+v2_config (based on
>> the linaro config-- note: you don't need to build all the modules!
>> Just make zImage or uImage)
>>
>> Hope that helps!
>> ---Dave
>>
>
