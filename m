From: john.stultz@linaro.org (John Stultz)
Date: Mon, 27 Nov 2017 09:35:30 -0800
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171123095456.lkc4nkuzsd2q26mm@piout.net>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
Message-ID: <CALAqxLUBWd-mv_3iiFrXLf0ka685t0an89jjduHpT-2jjv5O2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 1:54 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 13/10/2017 at 11:54:33 -0600, Jason Gunthorpe wrote:
>> ntp is currently hardwired to try and call the rtc set when wall clock
>> tv_nsec is 0.5 seconds. This historical behaviour works well with certain
>> PC RTCs, but is not universal to all rtc hardware.
>>
>> Change how this works by introducing the driver specific concept of
>> set_offset_nsec, the delay between current wall clock time and the target
>> time to set (with a 0 tv_nsecs).
>>
>> For x86-style CMOS set_offset_nsec should be -0.5 s which causes the last
>> second to be written 0.5 s after it has started.
>>
>> For compat with the old rtc_set_ntp_time, the value is defaulted to
>> + 0.5 s, which causes the next second to be written 0.5s before it starts,
>> as things were before this patch.
>>
>> Testing shows many non-x86 RTCs would like set_offset_nsec ~= 0,
>> so ultimately each RTC driver should set the set_offset_nsec according
>> to its needs, and non x86 architectures should stop using
>> update_persistent_clock64 in order to access this feature.
>> Future patches will revise the drivers as needed.
>>
>> Since CMOS and RTC now have very different handling they are split
>> into two dedicated code paths, sharing the support code, and ifdefs
>> are replaced with IS_ENABLED.
>>
>> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>> ---
>>  drivers/rtc/class.c   |   3 +
>>  drivers/rtc/systohc.c |  53 +++++++++++-----
>>  include/linux/rtc.h   |  43 ++++++++++++-
>>  kernel/time/ntp.c     | 166 ++++++++++++++++++++++++++++++++++----------------
>>  4 files changed, 196 insertions(+), 69 deletions(-)
>>
>> Hello All,
>>
>> Here is the latest version of this patch that was circulating between
>> RMK and myself. I have done a few more minor changed and been able to
>> test it myself on x86 KVM and on the ARM system that motivated the
>> original CONFIG_RTC_SYSTOHC patch.
>>
>> From all my testing, this patch does not change the existing behavior
>> at all, but provides the base infrastructure to fix individual RTCs
>> one at a time.
>>
>> There are a few followup patches that will set the set_offset_nsec
>> value for various RTC drivers, and I still have to look at RMK's
>> hrtimer patch, but those are all incremental on top of this.
>>
>
> So I'm discovering that this patch made it upstream silently. While it
> somewhat solves the issue for some RTCs, it is not a proper solution for
> most.

Sorry. I thought the discussion had finished up and it looked ok, so I
queued it up. Apologies.

Shall I revert it?

thanks
-john
