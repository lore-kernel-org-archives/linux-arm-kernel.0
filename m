From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Sep 2017 18:37:16 +0200
Subject: [PATCH 1/2] bus: mbus: fix window size calculation for 4GB windows
In-Reply-To: <87wp4urbp5.fsf@free-electrons.com>
References: <20170828152517.24506-1-jlu@pengutronix.de>
 <20170828152517.24506-2-jlu@pengutronix.de>
 <87wp4urbp5.fsf@free-electrons.com>
Message-ID: <20170920163716.l6kpf56ig5gfqzbi@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 04:43:18PM +0200, Gregory CLEMENT wrote:
> Hi Jan,
>  
>  On lun., ao?t 28 2017, Jan Luebbe <jlu@pengutronix.de> wrote:
> 
> > At least the Armada XP SoC supports 4GB on a single DRAM window. Because
> > the size register values contain the actual size - 1, the MSB is set in
> > that case. For example, the SDRAM window's control register's value is
> > 0xffffffe1 for 4GB (bits 31 to 24 contain the size).
> >
> > The MBUS driver reads back each window's size from registers and
> > calculates the actual size as (control_reg | ~DDR_SIZE_MASK) + 1, which
> > overflows for 32 bit values, resulting in other miscalculations further
> > on (a bad RAM window for the CESA crypto engine calculated by
> > mvebu_mbus_setup_cpu_target_nooverlap() in my case).
> >
> > This patch changes the type in 'struct mbus_dram_window' from u32 to
> > u64, which allows us to keep using the same register calculation code in
> > most MBUS-using drivers (which calculate ->size - 1 again).
> >
> 
> Your patch looks good, but as it is a fix we should also apply it on
> stable, could you provide the commit to fix?

It was there just from the start: the .c file was introduced in
v3.10-rc1~64^2~1^2~8^2~2 and already did that 32 bit calculus.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
