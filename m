From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 5 Apr 2018 18:39:17 +0530
Subject: [PATCH v5 12/44] clk: davinci: Add platform information for TI
 DA850 PSC
In-Reply-To: <CAEG3pND6Cu0P_t3y_VM9Sm-GCb3yW0Pa8q4cRUOXYxa5=2nWUQ@mail.gmail.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-13-git-send-email-david@lechnology.com>
 <CAMRc=MfQuqTK+mDT0Gawa6J-3d1z6djLutaHREKfVm+3hATEqQ@mail.gmail.com>
 <CAEG3pND6Cu0P_t3y_VM9Sm-GCb3yW0Pa8q4cRUOXYxa5=2nWUQ@mail.gmail.com>
Message-ID: <a4d84be0-e3d3-4e39-40f9-cae9006cb6ee@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On Friday 09 February 2018 10:18 PM, Michael Turquette wrote:
> On Fri, Feb 9, 2018 at 8:22 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> 2018-01-08 3:17 GMT+01:00 David Lechner <david@lechnology.com>:

>> Hi David,
>>
>> I've been working on moving the genpd code from its own driver to the
>> psc one. I couldn't get the system to boot though and problems
>> happened very early in the boot sequence. I struggled to figure out
>> what's happening, but eventually I noticed that psc uses
>> CLK_OF_DECLARE() to initialize clocks. The functions registered this
>> way are called very early in the boot sequence, way before
>> late_initcall() in which the genpd framework is initialized. This of

late_initcall() is too late for genpd to be initialized. As you may have
seen with the latest set of patches, we have problems with timer
initialization. After converting to platform devices, PSC and PLL clocks
get initialized post time_init(). We are working that around using
fixed-clocks, which hopefully will work (I still need to test many of
the affected platforms).

Can you please reply with the exact issue you faced with genpd framework
initialization so we do have that on record.

Thanks,
Sekhar

>> course makes it impossible to register genpd at the same time we
>> register PSCs.
>>
>> Mike, Stephen - it would be great if you could confirm, but I believe
>> the clock framework now only accepts clock drivers which create real
>> platform drivers, in which case this series would need to be modified.
> 
> You are correct. All new uses of CLK_OF_DECLARE are met with high
> suspicion, and all new drivers should be platform drivers.
> 
> There are cases when CLK_OF_DECLARE is necessary (sometimes
> temporarily while things are reworked), but it seems this is not the
> case for this driver based on your testing of the platform driver
> approach. Please use the platform driver approach instead.
> 
> Thanks,
> Mike
> 
>>
>> David: FYI I quickly converted the functions in psc-da850.c to actual
>> probe callbacks and it worked just fine on a da850-lcdk board.
>>
>> Best regards,
>> Bartosz Golaszewski
