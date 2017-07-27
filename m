From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 27 Jul 2017 12:10:40 +0200
Subject: [PATCH v6 4/7] drm/rockchip: vop: group vop registers
In-Reply-To: <44153824.CqyclESHdT@diego>
References: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
 <1501049966-6070-1-git-send-email-mark.yao@rock-chips.com>
 <44153824.CqyclESHdT@diego>
Message-ID: <10499935.q3BgzX4LKL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 27. Juli 2017, 11:51:06 CEST schrieb Heiko St?bner:
> Hi Mark,
> 
> Am Mittwoch, 26. Juli 2017, 14:19:25 CEST schrieb Mark Yao:
> > Grouping the vop registers facilitates make register
> > definition clearer, and also is useful for different vop
> > reuse the same group register.
> > 
> > Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> > ---
> > 
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  99
> >  ++++++++++++------------
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  60 ++++++++-------
> >  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 112
> > 
> > +++++++++++++++------------- 3 files changed, 144 insertions(+), 127
> > deletions(-)
> 
> This breaks display support on both rk3036 and rk3288 and I end up
> with a null pointer dereference in
> 
> [   10.640297] Unable to handle kernel NULL pointer dereference at virtual
> address 00000000 [   10.654430] pgd = c0204000
> [   10.657452] [00000000] *pgd=00000000
> [   10.661473] Internal error: Oops: 5 [#1] SMP ARM
> [   10.666635] Modules linked in: snd_pcm media snd_timer phy_rockchip_dp
> snd soundcore rockchipdrm dw_hdmi analogix_dp rtc_rk808 pwm_rockchip
> clk_rk808 spi_rockchip [   10.682897] CPU: 2 PID: 143 Comm: kworker/2:2 Not
> tainted 4.13.0-rc2-01791-g2b86603d0515 #355 [   10.692430] Hardware name:
> Rockchip (Device Tree)
> [   10.697692] Workqueue: events deferred_probe_work_func
> [   10.702152] Linux video capture interface: v2.00
> [   10.708590] task: ee38c800 task.stack: ed2e6000
> [   10.713656] PC is at vop_reg_set.constprop.4+0x4/0xa8 [rockchipdrm]
> [   10.720668] LR is at vop_bind+0x568/0x8a0 [rockchipdrm]

The obvious reason for that is

> @@ -164,14 +153,20 @@ static inline uint32_t vop_read_reg(struct vop *vop,
> uint32_t base, return (vop_readl(vop, base + reg->offset) >> reg->shift) &
> reg->mask; }
> 
> -static inline void vop_mask_write(struct vop *vop, uint32_t offset,
> -				  uint32_t mask, uint32_t shift, uint32_t v,
> -				  bool write_mask, bool relaxed)
> +static void vop_reg_set(struct vop *vop, const struct vop_reg *reg,
> +			uint32_t _offset, uint32_t _mask, uint32_t v,
> +			const char *reg_name)
>  {
> -	if (!mask)
> +	int offset = reg->offset + _offset;
> +	int mask = reg->mask & _mask;
> +	int shift = reg->shift;
> +
> +	if (!reg || !reg->mask) {
> +		dev_dbg(vop->dev, "Warning: not support %s\n", reg_name);
>  		return;
> +	}

where the check for !reg happens after it got already dereferenced.
But even with that fixed I end up with

on rk3288:
[    7.254823] rockchip-vop ff930000.vop: Warning: not support global_regdone_en
[    7.262847] rockchip-vop ff930000.vop: Warning: not support gate
[    7.269580] rockchip-vop ff930000.vop: Warning: not support gate
[    7.302765] rockchip-vop ff940000.vop: Warning: not support global_regdone_en
[    7.310758] rockchip-vop ff940000.vop: Warning: not support gate
[    7.317475] rockchip-vop ff940000.vop: Warning: not support gate
[    7.425724] rockchip-vop ff930000.vop: Warning: not support edp_pin_pol
[    7.526298] rockchip-vop ff940000.vop: Warning: not support hdmi_pin_pol

on rk3036:
[   12.389138] rockchip-vop 10118000.vop: Warning: not support global_regdone_en
[   12.397324] rockchip-vop 10118000.vop: Warning: not support gate
[   12.404165] rockchip-vop 10118000.vop: Warning: not support gate
[   13.747361] rockchip-vop 10118000.vop: Warning: not support hdmi_pin_pol
[   13.747371] rockchip-vop 10118000.vop: Warning: not support hdmi_en
[   13.747379] rockchip-vop 10118000.vop: Warning: not support hpost_st_end
[   13.747385] rockchip-vop 10118000.vop: Warning: not support vpost_st_end
[   13.747461] rockchip-vop 10118000.vop: Warning: not support src_alpha_ctl
[   13.767098] rockchip-vop 10118000.vop: Warning: not support src_alpha_ctl
[   13.786060] rockchip-vop 10118000.vop: Warning: not support src_alpha_ctl

While reqdone and friends are obviously features of newer vops, at least
the hdmi pin-pol is available on both these socs.

With this patch applied (and null-ptr fixed) I end up without hdmi output
on both socs.


Heiko
