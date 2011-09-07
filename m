From: lacombar@gmail.com (Arnaud Lacombe)
Date: Wed, 7 Sep 2011 15:34:35 -0400
Subject: [RFC] Kbuild: allow code re-use across different directories
In-Reply-To: <alpine.LFD.2.00.1109071437400.20358@xanadu.home>
References: <1313800642-32418-1-git-send-email-lacombar@gmail.com>
	<alpine.LFD.2.00.1109071437400.20358@xanadu.home>
Message-ID: <CACqU3MVF8XSdKi0PeZF5SFaH9i2HPqCjkMqccyb83x4V_1Vs1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 7, 2011 at 3:07 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 19 Aug 2011, Arnaud Lacombe wrote:
>
>> Hi folks,
>>
>> The attached patch modify Kbuild to allow to directly re-use code in multiple
>> directory without having to go through a copy. Technically, it changes Kbuild to
>> use by default the VPATH feature of GNU make and provides accessors for Makefile
>> to change it indirectly.
>>
>> Considering:
>>
>> arch/foo/lib:
>> fancy.c
>>
>> We want to be able to build it with -DPANTS=32 in the kernel, but the
>> bootloader requires -DPANTS_SIZE=30.
>>
>> Currently we would do, either:
>>
>> arch/foo/lib/Makefile
>> LDFLAGS_fancy.o := -DPANTS=32
>> obj-y += fancy.o
>>
>> and, either:
>>
>> arch/foo/boot/Makefile:
>> LDFLAGS_fancy.o := -DPANTS=30
>> obj-y += fancy.o
>> $(obj)/fancy.c: $(srctree)/arch/foo/lib/fancy.c
>> ? ? ? $(call cmd,shipped)
>>
>> or
>>
>> arch/foo/boot/Makefile:
>> LDFLAGS_fancy.o := -DPANTS=30
>> obj-y += fancy.o
>> $(obj)/fancy.o: $(srctree)/arch/foo/lib/fancy.c
>> ? ? ? $(call cmd,cc_c_o)
>>
>> The former implies an extra copy of the source file, the latter expose Kbuild
>> internal function.
>>
>> With the attached patch, we would do:
>>
>> arch/foo/boot/Makefile:
>> LDFLAGS_fancy.o := -DPANTS=30
>> obj-y += fancy.o
>> vpath-y += $(srctree)/arch/foo/lib
>>
>> and let GNU make do the job.
>>
>> Comments welcome,
>
> It doesn't work. ?Whatever I do to arch/arm/boot/compressed/Makefile
> (which admittedly looks a bit hairy and could benefit from a shave) in
> order to remove the $(call cmd,shipped) used with lib1funcs.S, I always
> end up with:
>
> make[2]: *** No rule to make target `arch/arm/boot/compressed/lib1funcs.S', needed by `arch/arm/boot/compressed/lib1funcs.o'. ?Stop.
>
What was the exact change you made which triggered this ?

Thanks,
 - Arnaud

> Obviously, restoring the explicit dependency with a $(call cmd,as_o_S)
> does make it work, but this is rather against the point of your patch.
>
> Do you have an example of how arch/arm/boot/compressed/Makefile should
> be changed to benefit from your patch?
>


>
> Nicolas
>
