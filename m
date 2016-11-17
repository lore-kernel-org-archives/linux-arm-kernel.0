From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Thu, 17 Nov 2016 09:59:40 +0530
Subject: [PATCH 12/16] ARM: imx: use generic API for enabling SCU
In-Reply-To: <20161114142631.GP3310@dragon>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-13-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161114142651epcas5p2ffdb722d348257c900d233fdb95885f3@epcas5p2.samsung.com>
 <20161114142631.GP3310@dragon>
Message-ID: <65abb76e-2aff-4057-c1ac-7ed71563d426@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Monday 14 November 2016 07:56 PM, Shawn Guo wrote:
> On Mon, Nov 14, 2016 at 10:32:07AM +0530, Pankaj Dubey wrote:
>> Now as we have of_scu_enable which takes care of mapping
>> scu base from DT, lets use it.
>>
>> At the same time this patch cleans up mach-imx platform files by
>> removing static mapping of SCU and dropping imx_scu_map_io function.
> 
> I remember that the static mapping of SCU is necessary because SCU is
> being accessed at very early boot stage where dynamic mapping hasn't
> been set up.
> 
>> CC: Shawn Guo <shawnguo@kernel.org>
>> CC: Sascha Hauer <kernel@pengutronix.de>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>  arch/arm/mach-imx/common.h     |  5 -----
>>  arch/arm/mach-imx/mach-imx6q.c |  8 +-------
>>  arch/arm/mach-imx/platsmp.c    | 32 +++++---------------------------
>>  arch/arm/mach-imx/pm-imx6.c    |  3 ++-
>>  4 files changed, 8 insertions(+), 40 deletions(-)
> 
> I tested it and saw that the booting of imx6q is broken like below.

Thanks for testing and letting me know about this.

Currently only two platforms (IMX and ZYNQ) are using SCU address at
very early stage of boot, for configuring possible cpus via
set_cpu_possible().. rest platforms are either using DT method or they
handle this in smp_prepare_cpus.

Since I am not sure if all boards based on IMX has been moved to DT
based boot, if it has moved to completely DT based then we do not need
this set_cpu_possible in smp_init_cpus, it will be taken care via
"arm_dt_init_cpu_maps" and this will avoid need of early mapping of SCU
base as well.

If not then, currently I can't see any other way to handle this and in
that case I will drop-out IMX platform's patch of using generic SCU APIs
in v2 version of series.

Thanks,
Pankaj Dubey
