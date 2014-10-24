From: dianders@chromium.org (Doug Anderson)
Date: Thu, 23 Oct 2014 21:44:36 -0700
Subject: [PATCH v4 4/6] ARM: rockchip: add suspend and resume for RK3288
In-Reply-To: <1413933928-25803-1-git-send-email-zyw@rock-chips.com>
References: <1413933461-25602-1-git-send-email-zyw@rock-chips.com>
 <1413933928-25803-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=XOvPP+2yJ10e03ko9iWmyU7BawrVyA6Dqt8RkSDMXgTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Tue, Oct 21, 2014 at 4:25 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> +static inline void rk3288_copy_data_to_sram(void)
> +{
> +       u32 resume_code_size = (u32)&rkpm_bootdata_cpu_code -
> +                              (u32)rockchip_slp_cpu_resume + 4;
> +
> +       /* save root sram data in ddr mem */
> +       memcpy(rk3288_bootram_base, bootram_save_data, SZ_4K);

I swore we looked at this before, but the above memcpy is backwards.

> +       /* move resume code and data to bootsram */
> +       memcpy(rk3288_bootram_base, rockchip_slp_cpu_resume,
> +              resume_code_size);
> +}
> +
> +static inline void rk3288_restore_original_sram(void)
> +{
> +       memcpy(bootram_save_data, rk3288_bootram_base, SZ_4K);

This one too.
