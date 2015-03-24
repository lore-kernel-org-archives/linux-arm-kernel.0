From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 24 Mar 2015 07:31:24 +0200
Subject: [PATCH 2/2] rtc: driver for Conexant Digicolor CX92755 on-chip RTC
In-Reply-To: <20150323153334.a373431dd5af6b669f716d83@linux-foundation.org>
References: <fa36a31a1d58d626ca0cb01ca0dece85aa2dfcb9.1427117334.git.baruch@tkos.co.il>
 <374ef109005ed14c3a0052a9da5226b87f8dc215.1427117334.git.baruch@tkos.co.il>
 <20150323153334.a373431dd5af6b669f716d83@linux-foundation.org>
Message-ID: <20150324053124.GN2825@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Mon, Mar 23, 2015 at 03:33:34PM -0700, Andrew Morton wrote:
> On Mon, 23 Mar 2015 15:28:54 +0200 Baruch Siach <baruch@tkos.co.il> wrote:
> > Add driver for the RTC hardware block on the Conexant CX92755 SoC, from 
> > the
> > Digicolor series of SoCs. Tested on the Equinox evaluation board for the
> > CX92755 chip.
> > 
> > ...
> >
> > +static int dc_rtc_read(struct dc_rtc *rtc, unsigned long *val)
> > +{
> > +	u8 read_cmds[] = {CMD_READ, CMD_NOP};
> > +	u32 reference, time1, time2;
> > +	int ret;
> > +
> > +	ret = dc_rtc_cmds(rtc, read_cmds, ARRAY_SIZE(read_cmds));
> 
> This is asking the compiler to build read_cmds[] on the stack each time
> dc_rtc_read() is called.
> 
> If we instead create the array at compile time:
> 
> +++ a/drivers/rtc/rtc-digicolor.c
> @@ -42,7 +42,7 @@ struct dc_rtc {
>  	void __iomem		*regs;
>  };
>  
> -static int dc_rtc_cmds(struct dc_rtc *rtc, u8 *cmds, int len)
> +static int dc_rtc_cmds(struct dc_rtc *rtc, const u8 *cmds, int len)
>  {
>  	u8 val;
>  	int i, ret;
> @@ -62,7 +62,7 @@ static int dc_rtc_cmds(struct dc_rtc *rt
>  
>  static int dc_rtc_read(struct dc_rtc *rtc, unsigned long *val)
>  {
> -	u8 read_cmds[] = {CMD_READ, CMD_NOP};
> +	static const u8 read_cmds[] = {CMD_READ, CMD_NOP};
>  	u32 reference, time1, time2;
>  	int ret;
>  
> @@ -86,7 +86,7 @@ static int dc_rtc_read(struct dc_rtc *rt
>  
>  static int dc_rtc_write(struct dc_rtc *rtc, u32 val)
>  {
> -	u8 write_cmds[] = {CMD_WRITE, CMD_NOP, CMD_RESET, CMD_NOP};
> +	static const u8 write_cmds[] = {CMD_WRITE, CMD_NOP, CMD_RESET, CMD_NOP};
>  
>  	writel_relaxed(val, rtc->regs + DC_RTC_REFERENCE);
>  	return dc_rtc_cmds(rtc, write_cmds, ARRAY_SIZE(write_cmds));
> 
> The code gets a bit smaller and faster:
> 
>    text    data     bss     dec     hex filename
>    1628     400     512    2540     9ec drivers/rtc/rtc-digicolor.o-before
>    1593     400     536    2529     9e1 drivers/rtc/rtc-digicolor.o-after

Thanks for the tip, and for taking the driver through your tree.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
