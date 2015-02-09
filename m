From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 9 Feb 2015 10:27:32 +0200
Subject: [PATCH 0/2] ARM: omap2+: omap_hwmod: Fix false lockdep warning
In-Reply-To: <54D5154F.8080208@ti.com>
References: <1423226916-18804-1-git-send-email-peter.ujfalusi@ti.com>
 <20150206141346.GP21418@twins.programming.kicks-ass.net>
 <54D4E64C.7060208@ti.com>
 <20150206183205.GS21418@twins.programming.kicks-ass.net>
 <54D5154F.8080208@ti.com>
Message-ID: <54D86F74.7070703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2015 09:26 PM, Peter Ujfalusi wrote:
>> Yeah, I've never really bothered with data too much, its a debug
>> feature. So lock_class_key is 8 bytes, and strictly speaking you could
>> union them over other fields, all we really need is unique addresses, we
>> don't actually use the storage.
> 
> True. our omap2plus defconfig does not have LOCKDEP enabled so it should not
> add anything to the data when running default kernel.
> I'll test the lockdep_set_class() method you suggested on Monday (not
> tomorrow), but still as first thing.
> If it is working as expected I'll send a patch with you as author.

With omap2plus_defconfig my build produces (vmlinux size):
Base: 				99905522
with my series:			99908385 (base + 2863)
with Peter Zijlstra's patch:	99910625 (base + 5103)

The reason for this is that we will only have
struct lock_class_key { };
in case of !CONFIG_LOCKDEP. On ARM however CONFIG_LOCKDEP is enabled by
default, while the CONFIG_DEBUG_LOCKDEP is disabled.

So it does add more data to our default omap2plus config.

Tony: do you have preference on the way we fix this issue?

As I recall there is a plan to remove the hwmod static database and move it or
generate it from DT? Not sure when and how this will be done, but will it
affect the lockdep_set_class() way?

-- 
P?ter
