From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 02 Oct 2014 08:36:16 -0700
Subject: [PATCH v2 0/3] ARM: rk3288 : Add PM Domain support
In-Reply-To: <542D1F1B.8040501@ti.com> (Grygorii Strashko's message of "Thu, 2
 Oct 2014 12:47:07 +0300")
References: <1411899774-8484-1-git-send-email-jinkun.hong@rock-chips.com>
 <7hoatvvimd.fsf@deeprootsystems.com>
 <CAD=FV=VPT5qiyY==nJbb4DqKMBnj0i-_MhLRVG0ikar2qtP4=A@mail.gmail.com>
 <7h38b7v8pp.fsf@deeprootsystems.com> <542D1F1B.8040501@ti.com>
Message-ID: <7hr3yqtrf3.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grygorii Strashko <grygorii.strashko@ti.com> writes:

> Hi,
>
> On 10/01/2014 11:25 PM, Kevin Hilman wrote:
>> Doug Anderson <dianders@chromium.org> writes:
>> 
>>>
>>> On Wed, Oct 1, 2014 at 9:51 AM, Kevin Hilman <khilman@kernel.org> wrote:
>>>> +Geert, Ulf
>>>>
>>>> "jinkun.hong" <jinkun.hong@rock-chips.com> writes:
>>>>
>>>>> From: "jinkun.hong" <jinkun.hong@rock-chips.com>
>>>>>
>>>>> Use PM Domain framework to manage the clock.
>>>>
>>>> Which clock?  This changelog needs a more thorough description.
>>>
>>>
>>> I think what he meant was:
>>>
>>> Use the generic PM Domain framework for Rockchip
>>>
>>> ...but I agree that he could describe it more.
>>>
>>>
>>>> Also,
>>>> with this series alone, it's not clear how the power-domain transitions
>>>> ever happen, since I don't see any devices hooked up to your power
>>>> domains, or do I see your platform using runtime PM.  In order for this
>>>> to be reviewed properely, it's important for reviewers to be able to see
>>>> how this PM domain support will be used.
>>>
>>> I noticed that too.  As the patchset currently stands it only ever disables...
>>>
>>>
>>>> Also, remember that the DT is supposed to reflect the hardware, not the
>>>> design choices of linux drivers.  Because of that, it's a little
>>>> surprising to see clocks as properties of a power domain because clocks
>>>> are usually properties of devices.
>>>
>>> I haven't dug all the way into the hardware to figure out why (or if
>>> this is really necessary), but right now the rockchip power domain
>>> driver only leaves these clocks on during the powering on and powering
>>> off of the power domain.  In other words to turn on the power domain:
>>>
>>> 1. Turn on all clocks
>>> 2. Flip the bit that sets the power domain on
>>> 3. Wait until hardware says power domain is on.
>>> 4. Turn off all the clocks.
>>>
>>> ...and to turn off:
>>>
>>> 1. Turn on all clocks
>>> 2. Flip the bit that sets the power domain off
>>> 3. Wait until hardware says power domain is off.
>>> 2. Turn off all the clocks.
>>>
>>> ...if the above is actually necessary when turning on and off power
>>> domains then it seems like it is actually describing the hardware.
>> 
>> Yes, I understand. The need to have some *device* clocks enabled when
>> powering on/off the power-domain itself is quite common across many
>> SoCs.
>> 
>> My point is that these clocks are actually properties of *devices*, not
>> the power-domain itself.  In the shmobile example I pointed to, the
>> clocks are properties of the devices in DT, and the devices are attached
>> to the powerdomain.  When the devices are connected to the power-domain,
>> the custom attach function looks up all the *device* clocks and and
>> addes them to the power-domain using pm_clk_add.
>
> Sorry, but this is not quite right :(
> Patches from Geert will add only first clock for device and not all
> of them. 
> The right way to add all clocks for device from DT using 
> generic PM domain represented in my series:
>  
>  ARM: keystone: pm: switch to use generic pm domains
>  http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg735601.html

Thanks for clarifying.

Kevin
