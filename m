From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 16 Dec 2017 12:05:49 +0900
Subject: [PATCH] kbuild: fix dependency of dtbs targets
In-Reply-To: <CAL_Jsq+E-fH1mN8Cxu8=8-wRZ+edF0YK5wCrKavY3frp1opbZA@mail.gmail.com>
References: <1507091240-12756-1-git-send-email-yamada.masahiro@socionext.com>
 <20171009150523.GT20805@n2100.armlinux.org.uk>
 <CAK7LNASCQqaBvERg6NXPym62Dyza00TuZVOWtj0YqLDKPT2D5g@mail.gmail.com>
 <CAL_Jsq+E-fH1mN8Cxu8=8-wRZ+edF0YK5wCrKavY3frp1opbZA@mail.gmail.com>
Message-ID: <CAK7LNAQXEG2MOaPT+aq9gxhY_cqPEu1a0p0O_HekVzUC1uAj+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-12-14 6:31 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Wed, Oct 25, 2017 at 12:40 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Hi.
>>
>>
>> 2017-10-10 0:05 GMT+09:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
>>> On Wed, Oct 04, 2017 at 01:27:20PM +0900, Masahiro Yamada wrote:
>>>> The target "dtbs" should depend on "scripts" because it needs to
>>>> build dtc.  The "prepare" target is unneeded here.
>>>
>>> Looks fine for ARM, as the only thing the dtbs should depend on is
>>> the kernel configuration (to decide which to build) and DT tooling.
>>>
>>> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
>>>
>>> --
>>
>>
>> I found a potential issue on this
>> because the default DTB install path depends on $(KERNELRELEASE).
>>
>>
>> In top-level Makefile:
>> export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)
>>
>>
>> The include/config/kernel.release is created by "prepare3" target.
>>
>> If the dependency on "parepare" is removed,
>> it is possible to run "make dtbs" and "make dtbs_install"
>> without creating include/config/kernel.release.
>>
>> So, the $(KERNELRELEASE) could be empty when installing DTB.
>>
>>
>> Maybe, drop this patch, or reduce the dependency to "parepare3"?
>
> I was doing some work to get dtb builds to work without depending on
> $arch cross compiler and this patch fixes some of the issues. The
> dtbs_install target has the prepare dependency,

Which line?

I checked arch/{arm,arm64,mips}/Makefile, but I did not see any
dependency.


> so that should be
> sufficient and your patch should be fine.

Generally, adding dependencies to install targets is dangerous
because install targets are often invoked in root privilege.

This is stated by, for example,
commit 19514fc665ffbce624785f76ee7ad0ea6378a527



> BTW, Based on prior
> discussion on "ARM: kbuild: Fix forced rebuild after 'make dtbs'"
> thread, prepare should not be needed just for $(KERNELRELEASE).
>
> Rob

No.
If "prepare" target is dropped, you can run dtbs_install
without include/config/kenrel.release





-- 
Best Regards
Masahiro Yamada
