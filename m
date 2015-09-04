From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 4 Sep 2015 08:58:31 -0700
Subject: [PATCH v2] mtd: nand: sunxi: rely on nand_dt_init initialization
In-Reply-To: <20150902102108.72219170@bbrezillon>
References: <1440411031-8910-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150902011616.GP81844@google.com>
 <20150902102108.72219170@bbrezillon>
Message-ID: <20150904155831.GD81844@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 10:21:08AM +0200, Boris Brezillon wrote:
> On Tue, 1 Sep 2015 18:16:16 -0700
> Brian Norris <computersforpeace@gmail.com> wrote:
> > There's also a subtle change here that affects more than just here: you
> > don't have a good way to tell the difference between "no ECC mode
> > provide" and NAND_ECC_NONE. Perhaps we can modify the nand_ecc_modes_t
> > enum to include a "uninitialized" value? I'm not sure if that'd work
> > best as 0, -1, or something else, in case there are people making
> > assumptions elsewhere...
> 
> It really depends on what we want to do. I see at least two solutions
> for this problem:
> 1/ keep the nand_dt_init() implementation as is and ask
>    nand_scan_ident() callers to pre-set their default value in ecc.mode.
>    This should work since ecc.mode is only overridden if ecc_mode is >= 0.
> 2/ modify the nand_dt_init function to assign the ecc_mode even if it
>    is negative, or create a new value in the enum (NAND_ECC_UNSPECIFIED
>    = -1) and assign it to ecc.mode when ecc_mode is negative.
> 
> 1# does not require any change, but if we choose this solution, we
> should make it clear that NAND controller drivers should set their
> default value before calling nand_scan_ident().

I'm OK with your choice of #1. Your v3 patch looks fine.

> And if go for 2#, that's not like we'll have to patch a lot of
> drivers (AFAICT, the only user in 4.2 is the brcmnand driver) ;-).

:) Well, I thought there were others in the pipeline. I've at least
reviewed another addition somewhat recently, but it wasn't quite ready.

Brian
