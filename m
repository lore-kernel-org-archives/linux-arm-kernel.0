From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Apr 2014 18:13:27 +0800
Subject: [PATCH] ARM: prima2: remove L2 cache size override
In-Reply-To: <20140415100002.GQ24070@n2100.arm.linux.org.uk>
References: <1397555342-25644-1-git-send-email-21cnbao@gmail.com>
 <20140415100002.GQ24070@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4zt4KMLk7v93e40Zj1A7fHBnvE2_c94nAbGAr9xcCFnwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-15 18:00 GMT+08:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Apr 15, 2014 at 05:49:02PM +0800, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> L2 cache size has been read by l2x0_init(), it is useless to set
>> WAY_SIZE and ASSOCIATIVITY in prima2.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  -Derived from Russell's "ARM: l2c: prima2: remove cache size override"
>
> You're a SMP architecture... it would be much better to initialise the
> L2 cache before the secondary CPUs are brought online.

ok, it seems we still need to hook this into the callback of this
specific machine instead of using a global early_initcall(). since now
the dt compatible field has been generic enough, it will cause other
platforms to execute l2x0_of_init() too.

>
> In any case, across the board, it's preferable that the L2 cache is
> enabled before the delay loop calibration as it can have an effect on
> the calibrated value.

what if the real case is that l2x0 has been enabled in bootloader?

>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.

-barry
