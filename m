From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 5 Feb 2015 17:25:28 -0800
Subject: [PATCH 5/9] mtd: pxa3xx_nand: add support for the Marvell Berlin
 nand controller
In-Reply-To: <54C7A3C0.6020507@free-electrons.com>
References: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
 <1422367816-4257-6-git-send-email-antoine.tenart@free-electrons.com>
 <54C7A3C0.6020507@free-electrons.com>
Message-ID: <20150206012528.GD30781@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 11:42:08AM -0300, Ezequiel Garcia wrote:
> On 01/27/2015 11:10 AM, Antoine Tenart wrote:
> > --- a/drivers/mtd/nand/pxa3xx_nand.c
> > +++ b/drivers/mtd/nand/pxa3xx_nand.c
...
> > @@ -244,10 +254,13 @@ module_param(use_dma, bool, 0444);
> >  MODULE_PARM_DESC(use_dma, "enable DMA for data transferring to/from NAND HW");
> >  
> >  static struct pxa3xx_nand_timing timing[] = {
> > -	{ 40, 80, 60, 100, 80, 100, 90000, 400, 40, },
> > -	{ 10,  0, 20,  40, 30,  40, 11123, 110, 10, },
> > -	{ 10, 25, 15,  25, 15,  30, 25000,  60, 10, },
> > -	{ 10, 35, 15,  25, 15,  25, 25000,  60, 10, },
> > +	{ 40, 80, 60, 100, 80, 100,  90000, 400, 40, },
> > +	{ 10,  0, 20,  40, 30,  40,  11123, 110, 10, },
> > +	{ 10, 25, 15,  25, 15,  30,  25000,  60, 10, },
> > +	{ 10, 35, 15,  25, 15,  25,  25000,  60, 10, },
> > +	{  5, 20, 10,  12, 10,  12,  60000,  60, 10, },
> > +	{  5, 20, 10,  12, 10,  12, 200000, 120, 10, },
> > +	{  5, 15, 10,  15, 10,  15,  60000,  60, 10, },
> >  };
> >  
> >  static struct pxa3xx_nand_flash builtin_flash_types[] = {
> > @@ -260,6 +273,20 @@ static struct pxa3xx_nand_flash builtin_flash_types[] = {
> >  { "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, 4096, &timing[2] },
> >  { "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096, &timing[2] },
> >  { "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048, &timing[3] },
> > +{ },
> > +};
> > +
> > +static struct pxa3xx_nand_flash berlin_builtin_flash_types[] = {
> > +{ "2GiB 8-bit",    0xd5ec, 128, 8192,  8,  8, 2048, &timing[4] },
> > +{ "2GiB 8-bit",    0xd598, 128, 8192,  8,  8, 2048, &timing[5] },
> > +{ "2GiB 8-bit",    0x482c, 256, 4096,  8,  8, 2048, &timing[6] },
> > +{ "4GiB 8-bit",    0xd7ec, 128, 8192,  8,  8, 4096, &timing[5] },
> > +{ "8GiB 8-bit",    0xdeec, 128, 8192,  8,  8, 4096, &timing[5] },
> > +{ "4GiB 8-bit",    0xd7ad, 256, 8192,  8,  8, 2048, &timing[5] },
> > +{ "4GiB 8-bit",    0x682c, 256, 4096,  8,  8, 4096, &timing[6] },
> > +{ "8GiB 8-bit",    0x882c, 256, 8192,  8,  8, 4096, &timing[6] },
> > +{ "8GiB 8-bit",    0xdead, 256, 8192,  8,  8, 4096, &timing[6] },
> > +{ },
> >  };
> >  
> 
> IMO, this sucks. I was hoping to see this old style probing go away,
> instead of be augmented.
> 
> There are proper ways to set timings.

Agreed. I'm not taking any additions to this table. Please rewrite the
code to use the onfi_async_timing_mode_to_sdr_timings() helpers.

Brian
