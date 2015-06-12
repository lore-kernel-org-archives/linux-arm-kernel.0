From: caesar.upstream@gmail.com (Caesar Wang)
Date: Fri, 12 Jun 2015 13:11:01 +0800
Subject: [PATCH v14 0/3] ARM: rk3288: Add PM Domain support
In-Reply-To: <7h383lzaqt.fsf@deeprootsystems.com>
References: <1429862868-14218-1-git-send-email-wxt@rock-chips.com>	<3550912.kR0pejLP0h@diego>
 <7h383lzaqt.fsf@deeprootsystems.com>
Message-ID: <557A69E5.5080701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Heiko

Thanks for your comments.
Sorry for delay reply.

? 2015?04?28? 02:28, Kevin Hilman ??:
> Heiko St?bner <heiko@sntech.de> writes:
>
>> Am Freitag, 24. April 2015, 16:07:45 schrieb Caesar Wang:
>>>      Add power domain drivers based on generic power domain for
>>> Rockchip platform, and support RK3288.
>>>
>>>      Verified on url =
>>>      https://chromium.googlesource.com/chromiumos/third_party/kernel.
>>>
>>>      At the moment,there are mass of products are using the driver.
>>> I believe the driver can happy work for next kernel.
>> I've taken a look at the driver and here are some global remarks:
>>
>> (1) You provide dt-bindings/power-domain/rk3288.h in patch 3. This breaks
>> bisectability, as the driver itself in patch 2 also includes the header and
>> would thus fail to compile if the later patch 3 is missing.
>> Ideally I think the header addition should be a separate patch itself, so that
>> we can possibly share it between driver and dts branches.
>> So 1: binding doc, 2: binding-header, 3: driver, 4: dts-changes.
OK, done.

>>
>> (2) The dts-changes in patch 3 should also add any necessary power-domain
>> assignment on devices if they're still missing, so that we don't introduce
>> regressions. In my case my work-in-progress edp died because the powerdomain
>> was turned off automatically it seems.
OK, I will list that devices.
At the moment, I don't find the EDP driver for rockchip. (I think the 
EDP driver hasn't a upstream).

Anyway, I will test it on 
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14,
Meanwhile work on next-kernel.


>>
>> (3) more like wondering @Kevin or so, is there some more generic place for a
>> power-domain driver nowadays?
> I think the preference has been to put these under drivers/soc/<vendor> for now,
> so they can shared across arm32 and arm64.
>

Interesting. Do you want to put the domain driver into /driver/soc/rockchip?
I guess the efuse driver ...is also do that.

Perhaps, it's a good select in the future.


>> (4) As Tomasz remarked previously the dts should represent the hardware and
>> the power-domains are part of the pmu. There is a recent addition from Linus
>> Walleij, called simple-mfd [a] that is supposed to get added real early for
>> kernel 4.2. So I'd think the power-domains should use that and the patchset
>> modified to include the changes shown below [b]?
>>
>> (5) Keven Hilman and Tomasz had reservations about all the device clocks
>> being listed in the power-domains itself in the previous versions. I don't see
>> a comment from them yet changing that view.
> Correct.

How about this patch?

https://patchwork.kernel.org/patch/5145241/

I will do that.

Maybe, do you have more suggestions?


>> Their wish was to get the clocks by reading the clocks from the device nodes,
>> though I see a problem on how to handle devices that do not have any bindings
>> at all yet.
>>
>> Kevin, Tomasz any new thoughts?
> I don't see any issues with devices that don't have bindings, as all
> that would be needed would be to simple device nodes with a clock
> property.  I wouldn't even matter if those devices had device drivers.
>
> Kevin
>
>
>
