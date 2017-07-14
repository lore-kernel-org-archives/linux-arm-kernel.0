From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Jul 2017 14:27:19 +0200
Subject: [PATCH 14/14] [media] fix warning on v4l2_subdev_call() result
 interpreted as bool
In-Reply-To: <20170714120512.ioe67nnloqivtbr7@mwanda>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714093938.1469319-1-arnd@arndb.de>
 <20170714120512.ioe67nnloqivtbr7@mwanda>
Message-ID: <CAK8P3a0f84OPcCK1r3P9inGYDJC2KaAO4mjE2vn+vCws-oo_bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 2:05 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Changing:
>
> - if (!frob()) {
> + if (frob() == 0) {
>
> is a totally pointless change.  They're both bad, because they're doing
> success testing instead of failure testing, but probably the second one
> is slightly worse.
>
> This warning seems dumb.  I can't imagine it has even a 10% success rate
> at finding real bugs.  Just disable it.
>
> Changing the code to propagate error codes, is the right thing of course
> so long as it doesn't introduce bugs.

It found a two of bugs that I fixed earlier:

f0e8faa7a5e8 ("ARM: ux500: fix prcmu_is_cpu_in_wfi() calculation")
af15769ffab1 ("scsi: mvsas: fix command_active typo")

plus three patches from this series:

1. staging:iio:resolver:ad2s1210 fix negative IIO_ANGL_VEL read
2. isdn: isdnloop: suppress a gcc-7 warning (my patch is wrong,
   as Joe pointed out there is a real bug)
3. drm/vmwgfx: avoid gcc-7 parentheses (here, Linus had a better
   analysis of the problem, so we should consider that a bug as well)

I would estimate around 25% success rate here, which isn't that
bad for a new warning.

I agree that most of the false positives are really dumb though.

       Arnd
