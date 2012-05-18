From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 18 May 2012 17:59:32 +0800
Subject: [PATCH 2/2] mfd: anatop: permit adata be NULL when access register
In-Reply-To: <20120514135035.GC29393@b20223-02.ap.freescale.net>
References: <1336870794-6351-1-git-send-email-richard.zhao@freescale.com>
 <1336870794-6351-2-git-send-email-richard.zhao@freescale.com>
 <20120514035137.GB20367@S2100-06.ap.freescale.net>
 <20120514080835.GB31985@opensource.wolfsonmicro.com>
 <4FB0C9D4.2060409@linaro.org>
 <20120514094357.GF20367@S2100-06.ap.freescale.net>
 <4FB10821.4000004@linaro.org>
 <20120514135035.GC29393@b20223-02.ap.freescale.net>
Message-ID: <20120518095932.GI30755@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 09:50:36PM +0800, Richard Zhao wrote:
> On Mon, May 14, 2012 at 09:26:57PM +0800, Ying-Chun Liu (PaulLiu) wrote:
> > (2012?05?14? 17:43), Shawn Guo wrote:
> > > On Mon, May 14, 2012 at 05:01:08PM +0800, Ying-Chun Liu (PaulLiu) wrote:
> > >> I think what the concern is we probably don't want several
> > >> non-continuous memory blocks of misc hardwares.
> > >> If we look into the current registers in anatop, it is really sparse.
> > >> Several regulators are using non-continuous address and the thermals are
> > >> also using different addresses. If the addresses are continuous then we
> > >> don't need the mfd driver.
> > >>
> > > I do not quite follow that.  The reason we need mfd driver isn't because
> > > we do not want to both regulator and thermal drivers to map and access
> > > the same address on their own which may have synchronization issue?
> > > 
> > 
> > Not sure about the synchronization issue. But currently thermal driver
> > in Linaro kernel do map and access the same address on its own now. It
> > is not a device driver yet and just access the address directly and
> > work. It seems to me that each different type of misc devices in Anatop
> > just work alone.
Guys, we need to draw conclusion.
I think current patch keep some how compatible with multi-anatop.
It's ok.

Thanks
Richard
> > 
> > So let's go back to the patch. Why do we need this modification? Anatop
> > thermal driver can be written as a device driver and don't need this
> > patch. And we might get benefits when thermal driver written in this
> > way. Especially some boards do not have a correct fuse data. Any real
> > use cases of this patch?
> Some bits in anatop is not owned by any driver.
> It's for below code:
>         /* Some phy and power's special controls for host1           
>          * 1. The external charger detector needs to be disabled
>          * or the signal at DP will be poor                          
>          * 2. The PLL's power and output to usb for host 1
>          * is totally controlled by IC, so the Software only needs   
>          * to enable them at initializtion.
>          */ 
>         
>         anatop_write_reg(NULL, HW_ANADIG_USB2_CHRG_DETECT,           
>                         BM_ANADIG_USB2_CHRG_DETECT_EN_B |
>                         BM_ANADIG_USB2_CHRG_DETECT_CHK_CHRG_B,       
>                         ~0);
>         anatop_write_reg(NULL, HW_ANADIG_USB2_PLL_480_CTRL, 0,       
>                         BM_ANADIG_USB2_PLL_480_CTRL_BYPASS);
> 
>         val = BM_ANADIG_USB2_PLL_480_CTRL_ENABLE |                   
>               BM_ANADIG_USB2_PLL_480_CTRL_POWER |
>               BM_ANADIG_USB2_PLL_480_CTRL_EN_USB_CLKS;               
>         anatop_write_reg(NULL, HW_ANADIG_USB2_PLL_480_CTRL, val, val);
> 
> Thanks
> Richard
> > 
> > Yours Sincerely,
> > Paul
> > 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
