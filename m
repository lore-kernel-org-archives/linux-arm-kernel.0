From: Madhusudhan.Gowda@elektrobit.com (Madhusudhan.Gowda at elektrobit.com)
Date: Wed, 22 Feb 2012 10:42:27 +0200
Subject: [GIT PULL] OMAP PM EMU fix for v3.3
In-Reply-To: <87linxa5gk.fsf@ti.com>
References: <87liw8agk4.fsf@ti.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC7@fioues08.ebgroup.elektrobit.com><20120127190239.GC9339@atomide.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC8@fioues08.ebgroup.elektrobit.com><AA48DD8077D5D945A49BD1782C1140F10122E2B7@fioues08.ebgroup.elektrobit.com>
 <87linxa5gk.fsf@ti.com>
Message-ID: <AA48DD8077D5D945A49BD1782C1140F10122E4FF@fioues08.ebgroup.elektrobit.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin / Paul,

I have tested this on beagle board as well as on OMAP3630 based
propriatory phone using SDTI serial trace interface.

Also you can test it by just observing the 
CM_EMU (48005100) clkstctrl register
 48 => 00000001
Across MPU OFF alone

[root at beagleboard /]# echo 0 >
/sys/kernel/debug/pm_debug/neon_pwrdm/suspend
[root at beagleboard /]# echo 0 >
/sys/kernel/debug/pm_debug/mpu_pwrdm/suspend
[root at beagleboard /]# echo 1 >
/sys/kernel/debug/pm_debug/core_pwrdm/suspend
[root at beagleboard /]# echo 1 >
/sys/kernel/debug/pm_debug/per_pwrdm/suspend
[root at beagleboard /]# echo mem >/sys/power/state
[   59.694671] PM: Syncing filesystems ... done.
[   59.758209] Freezing user space processes ... (elapsed 0.02 seconds)
done.
[   59.789947] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   59.820709] Suspending console(s) (use no_console_suspend to debug)
[   60.055816] PM: suspend of devices complete after 212.493 msecs
[   60.059661] PM: late suspend of devices complete after 3.784 msecs
[   60.059753] Disabling non-boot CPUs ...
[   64.299865] Successfully put all powerdomains to target state
[   64.302551] PM: early resume of devices complete after 2.319 msecs
[   64.636444] PM: resume of devices complete after 332.336 msecs
[   64.688446] Restarting tasks ... done.
[root at beagleboard /]# 

And then print again the CM_EMU (48005100) clkstctrl register offset 48
this will have the reset value and PRM_EMU (48307100) offset e4 =>
00000100 register confirms the domain wakeup reset from OFF.

At this moment the SDTI serial trace interface looses connection.

With my patch applied the CM_EMU (48005100) clkstctrl register restores
it initial setting across MPU OFF.

Thanks
Gowda


-----Original Message-----
From: Kevin Hilman [mailto:khilman at ti.com] 
Sent: 20 February 2012 17:30
To: Gowda Madhusudhan; Paul Walmsley
Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
tony at atomide.com
Subject: Re: [GIT PULL] OMAP PM EMU fix for v3.3

+Paul

Paul maintains the CM core code and should take this patch if he's OK
with it.

Also, it is most helpful if you describe what platforms it was tested on
and exactly how you tested it.

Thanks,

Kevin

<Madhusudhan.Gowda@elektrobit.com> writes:

> Hi Kevin,
>
> I think you have missed my last mail. Could you please ACK the pull 
> request and pull the same.
>
> Best Regards
> Gowda
>
>
> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
> linux-arm-kernel-bounces+madhusudhan.gowda=elektrobit.com at lists.infrad
> linux-arm-kernel-bounces+ea
> d.org
> Sent: 28 January 2012 09:58
> To: tony at atomide.com; khilman at ti.com
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [GIT PULL] OMAP PM EMU fix for v3.3
>
> Thanks Tony
>
> Hi Kevin
> Please do the needful and pull the same.
>
> Best Regards
> Gowda
>
>
> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of 
> Tony Lindgren
> Sent: 27 January 2012 21:03
> To: Gowda Madhusudhan
> Cc: Kevin Hilman; linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [GIT PULL] OMAP PM EMU fix for v3.3
>
> Hi,
>
> * Madhusudhan.Gowda at elektrobit.com <Madhusudhan.Gowda@elektrobit.com>
> [120127 10:25]:
>> Hi Tony,
>> 
>> Please pull the PM EMU off mode fix for v3.3
>
> It's best that Kevin queues this as it affects PM. Or it at least 
> needs an ack from Kevin.
>
> Regards,
>
> Tony
>  
>> Thanks
>> Gowda
>> 
>> The following changes since commit
>> 1c6ece3c23e58d0dbc687407d606f3560ded582a:
>> 
>>   Merge branch 'omap_fixes_a_3.3rc' of git://git.pwsan.com/linux-2.6
>> (2012-01-26 16:48:37 -0800)
>> 
>> are available in the git repository at:
>> 
>>   git://github.com/elektrobit/linux.git linux-omap-emu-fix
>> 
>> Madhusudhan Gowda (1):
>>       ARM: OMAP3 PM:Save and restore EMU context across MPU OFF
>> 
>>  arch/arm/mach-omap2/cm2xxx_3xxx.c |   16 ++++++++++++----
>>  arch/arm/mach-omap2/cm2xxx_3xxx.h |    2 ++
>>  arch/arm/mach-omap2/pm34xx.c      |    8 ++++++++
>>  3 files changed, 22 insertions(+), 4 deletions(-)
>> 
>> 
>> ----------------------------------------------------------------
>> Please note: This e-mail may contain confidential information 
>> intended
>
>> solely for the addressee. If you have received this e-mail in error, 
>> please do not disclose it to anyone, notify the sender promptly, and 
>> delete the message from your system.
>> Thank you.
>> 
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
> ----------------------------------------------------------------
> Please note: This e-mail may contain confidential information intended

> solely for the addressee. If you have received this e-mail in error, 
> please do not disclose it to anyone, notify the sender promptly, and 
> delete the message from your system.
> Thank you.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" 
> in the body of a message to majordomo at vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
