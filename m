From: sonnyrao@chromium.org (Sonny Rao)
Date: Thu, 20 Nov 2014 01:18:46 -0800
Subject: [PATCH v4] clocksource: arch_timer: Fix code to use physical
 timers when requested
In-Reply-To: <20141120084900.GC24143@lukather>
References: <1412753937-29343-1-git-send-email-sonnyrao@chromium.org>
 <20141120084900.GC24143@lukather>
Message-ID: <CAPz6YkU2ix0MOZDHHMN5=rdFQ3mLmCVN-0Wy6fHw_wgC6Lvgfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 12:49 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Wed, Oct 08, 2014 at 12:38:57AM -0700, Sonny Rao wrote:
>> This is a bug fix for using physical arch timers when
>> the arch_timer_use_virtual boolean is false.  It restores the
>> arch_counter_get_cntpct() function after removal in
>>
>> 0d651e4e "clocksource: arch_timer: use virtual counters"
>>
>> We need this on certain ARMv7 systems which are architected like this:
>>
>> * The firmware doesn't know and doesn't care about hypervisor mode and
>>   we don't want to add the complexity of hypervisor there.
>>
>> * The firmware isn't involved in SMP bringup or resume.
>>
>> * The ARCH timer come up with an uninitialized offset between the
>>   virtual and physical counters.  Each core gets a different random
>>   offset.
>>
>> * The device boots in "Secure SVC" mode.
>>
>> * Nothing has touched the reset value of CNTHCTL.PL1PCEN or
>>   CNTHCTL.PL1PCTEN (both default to 1 at reset)
>>
>> One example of such as system is RK3288 where it is much simpler to
>> use the physical counter since there's nobody managing the offset and
>> each time a core goes down and comes back up it will get reinitialized
>> to some other random value.
>>
>> Fixes: 0d651e4e65e9 ("clocksource: arch_timer: use virtual counters")
>> Cc: stable at vger.kernel.org
>> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>> Acked-by: Olof Johansson <olof@lixom.net>
>
> Has this been merged yet?
>
> If not, you can add my Tested-by, it makes the Allwinner A31 boot
> flawlessly with the arch timers (together with the patch "clocksource:
> arch_timer: Allow the device tree to specify uninitialized timer
> registers")

No, it has not been merged, and Doug just pinged Daniel about status
on the other patch you mentioned.  I'm glad these patches are useful
to you another system, hopefully this will help the case for
inclusion.

Daniel, Mark, Will, others, is there any objection to this patch?  If
not could we please merge?


> Thanks!
> Maxime
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
