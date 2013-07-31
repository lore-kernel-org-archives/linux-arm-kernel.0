From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 31 Jul 2013 15:00:08 +0900
Subject: ARM CPU Hotplug breakage on mach-shmobile and KZM9D
In-Reply-To: <20130731010404.GJ17209@verge.net.au>
References: <CANqRtoRx7voEVwJG8UNNy_Jiixo=uRJCvxTD0bZdzVohoryBUA@mail.gmail.com>
 <20130725010607.GB31464@verge.net.au>
 <20130730074939.GE7210@verge.net.au>
 <51F7CD67.6020209@windriver.com>
 <20130731010404.GJ17209@verge.net.au>
Message-ID: <CANqRtoRcNGo+xXPzmgEtXgqqWF+07bbf8Ch6yRWeOFURRVMtwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Paul,

On Wed, Jul 31, 2013 at 10:04 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Jul 30, 2013 at 10:27:51AM -0400, Paul Gortmaker wrote:
>> On 13-07-30 03:49 AM, Simon Horman wrote:
>> > [ Cc Paul Gortmaker ]
>> >
>> > On Thu, Jul 25, 2013 at 10:06:07AM +0900, Simon Horman wrote:
>> >> On Thu, Jul 25, 2013 at 12:15:49AM +0900, Magnus Damm wrote:
>> >>> Hi everyone,
>> >>>
>> >>> Bad news: CPU Hotplug on KZM9D seems broken on recent kernels.
>> >>>
>> >>> On renesas-next-20130710 or earlier I can perform the following:
>> >>>
>> >>> # echo 0 > /sys/devices/system/cpu/cpu1/online
>> >>> CPU1: shutdown
>> >>> # echo 1 > /sys/devices/system/cpu/cpu1/online
>> >>> CPU1: Booted secondary processor
>> >>> #
>> >>>
>> >>> While on more recent kernels the hotplug boot fails. This may be
>> >>> related to the move to v3.11-rc. The tag renesas-next-20130710
>> >>> surprisingly seems to be the final kernel based on v3.10-rc before
>> >>> jumping to v3.11-rc.
>> >>>
>> >>> I wonder, do other ARM platforms have working CPU Hotplug in v3.11-rc?
>> >>
>> >> I have a snowball that I could test if you think it would be useful.
>> >
>> > Unfortunately getting snowball to work turned out to be rather painful.
>> > So instead I bisected the problem on the KZM9G (N.b: the D in the subject
>> > seems to be incorrect :^)
>> >
>> > The result is that the following patch, added in v3.11-rc1,
>> > appears to be the culprit.
>>
>> Double check that you have this commit present:
>>  ---------------
>> commit 8c69d7af12265e5be9326110b695e010b47505bd
>> Author: Stephen Warren <swarren@nvidia.com>
>> Date:   Fri Jul 5 22:59:42 2013 +0100
>>
>>     ARM: 7780/1: add missing linker section markup to head-common.S
>>  ---------------
>>
>> as I think you are reporting the same problem that it fixed.
>
> Unfortunately that does not seem to resolve the problem that I am seeing.
> I have tried both v3.11-rc3 and 22f0a27367742f65130c0fb25ef00f7297e032c1
> with 8c69d7af12265e5be9326110b695e010b47505bd cherry picked on top and
> in both cases I see:
>
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> CPU1: shutdown
> # echo 1 > /sys/devices/system/cpu/cpu1/online
> CPU1: failed to come online

Thanks for your help. I've now tracked down this issue to the following fix:

[PATCH] ARM: Fix memblock_reserve() to include stext

Let me know if you think the code should be changed somehow.

Cheers,

/ magnus
