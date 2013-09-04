From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Wed, 4 Sep 2013 11:32:22 +0530
Subject: [RFC Patch v2 0/3] add temporary parent migration support
In-Reply-To: <3927125.3UOplv4uU5@localhost>
References: <1378208072-10173-1-git-send-email-chander.kashyap@linaro.org>
 <3927125.3UOplv4uU5@localhost>
Message-ID: <CANuQgHFCJ=4xukQ8xBySu1yue6s7eRB70At9C7KyxFg425u7Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 September 2013 04:06, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Chander,
>
> On Tuesday 03 of September 2013 17:04:28 Chander Kashyap wrote:
>> Some platform has provision to change cpu parent clock during
>> cpu frequency scaling. This patch series provides a mechanism to
>> implement the same using CCF.
>>
>> Patch1 provides mechanism to migrate to new parent temporarily.
>>
>> Patch2 updates the user of clk_register_mux and DEFINE_CLK_MUX which are
>> modified to add support for clk migration.
>>
>> Patch3 adds support to Exynos5250 to use the clock parent migration
>> feature implemented in CCF.
>
> I don't really like this approach. A need to change mux setting
> temporarily is heavily platform-specific and I don't think it should be
> handled by generic code.


As of now beside samsung  platforms, tegra is doing temporary parent
migration. That why i opted to implement this feature in generic code.
Here only set_parent operation is called on mux_clk. which is again
implemented in generic framework. So i dont think any other platform
specific requirements need to be taken care.

>First of all there are many factor that you would
> have to account for to make this solution generic, such as:
>  - board specific alternative parents,

Yes true, that's why,  that information is passed during registration time.

>  - exact moment of parent change,

Here it is only during set rate operation.

>  - some other platform specific conditions, like CPU voltage that must be

That will be handled separately when actual migration of cpufreq
driver will be done.

> changed when mux is changed, because it changes CPU frequency,
>  - and probably a lot of more factors that only people working with all
> the platforms supported (and unsupported yet) by Linux.
>
> I can see at least two solutions for this problem that don't require
> changing core code of common clock framework:
>
> 1) Implementing a special clock type using normal mux ops, but also
> registering a notifier for its PRE_RATE_CHANGE and POST_RATE_CHANGE events
> to perform parent switching.
>
> 2) Using normal mux clock, but registering such notifiers in clock
> controller or cpufreq driver.
>

I agree with you, but i am attempting through generic framework be
keeping in mind the future usage of this feature by other platforms.

> Best regards,
> Tomasz
>



-- 
with warm regards,
Chander Kashyap
