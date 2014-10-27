From: dianders@chromium.org (Doug Anderson)
Date: Mon, 27 Oct 2014 10:42:14 -0700
Subject: [PATCH v3 4/6] ARM: rockchip: add suspend and resume for RK3288
In-Reply-To: <7ha94l6syu.fsf@deeprootsystems.com>
References: <1413862894-2623-1-git-send-email-zyw@rock-chips.com>
 <1413863063-2815-1-git-send-email-zyw@rock-chips.com>
 <7ha94l6syu.fsf@deeprootsystems.com>
Message-ID: <CAD=FV=WLqbtRSVU+jqwn9qt33uNLbaWqL6NOCOMiutWn=8iVPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Fri, Oct 24, 2014 at 2:47 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> +static void rk3288_fill_in_bootram(u32 level)
>> +{
>> +     rkpm_bootdata_cpusp = rk3288_bootram_phy + (SZ_4K - 8);
>> +     rkpm_bootdata_cpu_code = virt_to_phys(cpu_resume);
>> +
>> +     rkpm_bootdata_l2ctlr_f  = 1;
>> +     rkpm_bootdata_l2ctlr = rk3288_l2_config();
>
> You're storing this to an offset in your assembly code, which is then
> copied to SRAM.  Why not just read/store it from your assembly code?

I didn't understand this comment.  Chris is saving the pre-suspend
value into a location that will be accessible to the resume code.  It
needs to be PC-relative for the resume code to get to it since there's
no MMU yet.

He could copy it to SRAM first and then put it into SRAM, but I'm not
sure it makes a huge difference.


>> +static int rk3288_suspend_enter(suspend_state_t state)
>> +{
>> +     local_fiq_disable();
>> +
>> +     rk3288_save_settings(ROCKCHIP_ARM_OFF_LOGIC_NORMAL);
>
> You (re)write your assembly code into SRAM every time you suspend.  Does
> your SRAM lose context? ...
>
>> +     cpu_suspend(0, rockchip_lpmode_enter);
>> +
>> +     rk3288_restore_settings();
>
> ... or is it just because you overwrite it here?
>
> Why are you reading/writing 4K of SRAM every suspend/resume?  Is it
> because the SRAM is actually shared with some other devices/drivers?
>
> If so, maybe you should be using an SRAM allocator so the SRAM can be
> shared, and you don't have to read/write a full page of SRAM for every
> suspend/resume.

This 4K chunk of SRAM is pretty specifically for suspend/resume, at
least on rk3288.  Other than the fact that it's only 4K, it has a lot
of severe limitations that keep it from being generally useful (it
will crash the SoC if you write non word-sized data to it and also it
can't be cached).

I'm going to suggest that we just don't save/restore it.
