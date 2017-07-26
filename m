From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 26 Jul 2017 08:59:10 +0800
Subject: [PATCH v5 1/7] drm/rockchip: vop: initialize registers directly
In-Reply-To: <3165793.eZGRgZzZRy@phil>
References: <1500518564-30371-1-git-send-email-mark.yao@rock-chips.com>
 <1500518603-30486-1-git-send-email-mark.yao@rock-chips.com>
 <3165793.eZGRgZzZRy@phil>
Message-ID: <5977E95E.1040700@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?07?26? 06:36, Heiko Stuebner wrote:
> Hi Mark,
>
> Am Donnerstag, 20. Juli 2017, 10:43:22 CEST schrieb Mark Yao:
>> At present we are using init_table to initialize some
>> registers, but the Register init table use un-document define,
>> it is unreadable, and sometimes we only want to update tiny
>> bits, init table method is not friendly, it's diffcult to
>> reuse for difference chips.
>>
>> To make it clean, initialize registers directly, and drops
>> init_table mechanism out.
>>
>> Changes in v3:
>> - Explain more in details
>>
>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> [...]
>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
>> index bafd698..00e9d79 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
>> @@ -127,13 +127,7 @@
>>   	.cfg_done = VOP_REG(RK3036_REG_CFG_DONE, 0x1, 0),
>>   };
>>   
>> -static const struct vop_reg_data rk3036_vop_init_reg_table[] = {
>> -	{RK3036_DSP_CTRL1, 0x00000000},
>> -};
>> -
>>   static const struct vop_data rk3036_vop = {
>> -	.init_table = rk3036_vop_init_reg_table,
>> -	.table_size = ARRAY_SIZE(rk3036_vop_init_reg_table),
>>   	.ctrl = &rk3036_ctrl_data,
>>   	.intr = &rk3036_intr,
>>   	.win = rk3036_vop_win_data,
> This seems to break vop initialization on my rk3036 kylin board.
>
> Before, kylin was able to bring output to the hdmi but with this
> patch applied this stops working. As the init-value is to zero it seems
> there is still something turned on, that should be turned off instead.
>
> rk3288 seems to stay in working condition though.
>
>
> Heiko
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
>
>
Hi Heiko

Thanks for your testing on rk3036 board.

I research the init table on rk3036, the dsp_blank reset value is 1, we need set the register to zero.

So I think not working problem can be fixed by following change:

     drivers/gpu/drm/rockchip/rockchip_vop_reg.c:
     static const struct vop_ctrl rk3036_ctrl_data = {
             .standby = VOP_REG(RK3036_SYS_CTRL, 0x1, 30),
     +       .dsp_blank = VOP_REG(RK3036_DSP_CTRL1, 0x1, 24),
             .out_mode = VOP_REG(RK3036_DSP_CTRL0, 0xf, 0),
             .pin_pol = VOP_REG(RK3036_DSP_CTRL0, 0xf, 4),
             .htotal_pw = VOP_REG(RK3036_DSP_HTOTAL_HS_END, 0x1fff1fff, 0),

-- 
?ark Yao
