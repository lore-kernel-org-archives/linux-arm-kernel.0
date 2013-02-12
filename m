From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Feb 2013 09:39:36 -0700
Subject: [PATCH] HACK: ARM: Fix generic timer broadcast for TWD
In-Reply-To: <20130212155516.GP17833@n2100.arm.linux.org.uk>
References: <1360684194-10894-1-git-send-email-thierry.reding@avionic-design.de>
 <20130212155516.GP17833@n2100.arm.linux.org.uk>
Message-ID: <511A7048.3070905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2013 08:55 AM, Russell King - ARM Linux wrote:
> On Tue, Feb 12, 2013 at 04:49:54PM +0100, Thierry Reding wrote:
>> Note that I have close to no clue what I'm doing, so the patch might be
>> the completely wrong thing to do. An alternative I had initially thought
>> about was to check for NULL before calling the clock_event_device's
>> .broadcast() function.
>>
>> The reason why I chose to always assign .broadcast instead is that a
>> previous patch (3d06770: Add generic timer broadcast support) aims at
>> generically implementing broadcast support on ARM and providing a
>> tick_broadcast() implementation for this purpose so it seemed like the
>> right thing to do.
>>
>> The above-mentioned patch for some reason removed the assignment to the
>> .broadcast() member for apparently no reason, so maybe that was just
>> done by mistake?
> 
> This is now supposed to be handled by the timer core stuff.  It
> looks to me like 3d06770eef43eaad606e77246bfcc7e82b1d9fb4
> (arm: Add generic timer broadcast support) is slightly busted in
> that it doesn't deal with the #else case you identified below.

This is fixed by:

"clockevents: fix generic broadcast for FEAT_C3STOP"

http://www.spinics.net/lists/arm-kernel/msg223568.html

For some reason this hasn't made it into linux-next yet, at least not by
next-20130211.

It's in:

git://nv-tegra.nvidia.com/user/swarren/linux-2.6 next-20130211-fixed
