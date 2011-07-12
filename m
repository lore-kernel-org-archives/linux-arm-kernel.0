From: khilman@ti.com (Kevin Hilman)
Date: Tue, 12 Jul 2011 07:55:00 -0700
Subject: [PATCH] OMAP2+: PM: fix watchdog boot when runtime PM is disabled
In-Reply-To: <4E1B8B47.3020904@ti.com> (Santosh Shilimkar's message of "Mon,
	11 Jul 2011 16:46:15 -0700")
References: <1310426484-30083-1-git-send-email-khilman@ti.com>
	<4E1B8B47.3020904@ti.com>
Message-ID: <878vs3v9a3.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On 7/11/2011 4:21 PM, Kevin Hilman wrote:
>> Fix boot crash in watchdog driver when runtime PM is disabled.
>>
>> When runtime PM is disabled, devices should be left enabled so that
>> all device accesses in drivers will succeed even though the runtime PM
>> get/put calls are noops.
>>
>> This is already the case for all devices, but the WDT init has its
>> own hwmod postsetup which was not taking this into account.
>>
>> This fixes a boot crash where the first device access in the WDT probe
>> function would crash a booting kernel.
>>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Signed-off-by: Kevin Hilman<khilman@ti.com>
>> ---
>> Tony, as this is a boot crash, it should probably be queued for v3.0.
>> However, since OMAP2PLUS_TYPICAL always enables runtime PM, this is
>> unlikely to be seen unless specifically testing with runtime PM disabled.
>>
> This patch is exactly same as the one I submitted on Jan 5, 2011 for
> the same issue. Here is the patchwork link for the same.
>
> https://patchwork.kernel.org/patch/453481/
>
> Paul had a valid concern about the boot-loader leaving the watchdog
> enabled. More on this in below thread.
>
> http://www.spinics.net/lists/arm-kernel/msg110937.html
>

Paul's concern is valid, and could be addressed by making that init code
actually check if the WDT is currently active (as suggested by the
comment there.)

In the mean time, this simple fix should be applied to prevent a boot
crash, IMO.

Kevin
