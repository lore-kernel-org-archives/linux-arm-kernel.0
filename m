From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 1 Feb 2012 09:34:15 +0100
Subject: [PATCH] ARM: OMAP3+: PM debug: fix the use of debugfs_create_* API
In-Reply-To: <87ehufojh1.fsf@ti.com>
References: <1328008819-1110-1-git-send-email-j-pihet@ti.com>
 <87ehufojh1.fsf@ti.com>
Message-ID: <CAORVsuWbRDFGGgs2hg3-9cz-Pd16B97QRU-5c4QQ4C6S_uLRog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Tue, Jan 31, 2012 at 6:44 PM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> The debugfs_create_* API returns a NULL ptr in case of problem.
>> Fix the PM debug code to take this into account.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> ?arch/arm/mach-omap2/pm-debug.c | ? ?4 ++--
>> ?1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
>> index 4411163..e5bf367 100644
>> --- a/arch/arm/mach-omap2/pm-debug.c
>> +++ b/arch/arm/mach-omap2/pm-debug.c
>> @@ -264,8 +264,8 @@ static int __init pm_dbg_init(void)
>> ? ? ? ? ? ? ? return 0;
>>
>> ? ? ? d = debugfs_create_dir("pm_debug", NULL);
>> - ? ? if (IS_ERR(d))
>> - ? ? ? ? ? ? return PTR_ERR(d);
>> + ? ? if (!d)
>
> I think this should be IS_ERR_OR_NULL() because this function can also
> return ERR_PTR(-ENODEV). ?(Yes, only when debugfs is not enabled, but
> it's still more correct.)
That makes sense, even if the PM debug code is enclosed by #ifdef
CONFIG_DEBUG_FS.
I have a new version of the patch, it also fixes another potential
problem with debugfs.

Thanks,
Jean

>
> Kevin
>
