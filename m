From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 17 Apr 2015 09:53:05 -0600
Subject: [PATCH 00/13] Enable CoreSight for the Ux500
In-Reply-To: <1429261140-13910-1-git-send-email-linus.walleij@linaro.org>
References: <1429261140-13910-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CANLsYkymJjSjf1VD=XvrSciGKGAcdNA2empupSZiDtJ10nhOwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2015 at 02:58, Linus Walleij <linus.walleij@linaro.org> wrote:
> This patch series enables the CoreSight blocks for the Ux500.
>
> To do so I ran into a few obstacles, all resolved in this
> series:
>
> - The Ux500 have two distinct clocks clocking the CS blocks,
>   APETRACECLK clocking the AHB interconnect, what is usually
>   referred to as "apb_pclk" in the AMBA primecell abstraction
>   layer, and another clock called APEATCLK which is connected
>   to the actual ATCLK on the CS blocks. So I have to add
>   handling for this second clock as only the PCLK is handled
>   today.
>
> - Doing so I need to use runtime PM, and I discovered that
>   the current CS drivers go in and grab the PCLK from the
>   AMBA primecell abstraction which is wrong: this shall be
>   handled using runtime PM callbacks, see e.g.
>   drivers/mmc/host/mmci.c. So I made a patch series fixing
>   this. This also fixes the problem that the PCLK is left
>   on since none of the drivers call pm_runtime_put() so
>   the AMBA core can disable the PCLK, instead they are
>   poking around with the PCLK themselves which is wrong.
>
> Linus Walleij (13):
>   coresight: etm: print what version of ETM/PTM is detected
>   coresight: support the TPIU version found in Ux500
>   coresight: etm: let runtime PM handle core clock
>   coresight: tpiu: let runtime PM handle core clock
>   coresight: etb: let runtime PM handle core clock
>   coresight: funnel: let runtime PM handle core clock
>   coresight: tmc: let runtime PM handle core clock
>   coresight: etm: retrieve and handle atclk
>   coresight: tpiu: retrieve and handle atclk
>   coresight: etb: retrieve and handle atclk
>   coresight: funnel: retrieve and handle atclk
>   coresight: replicator: retrieve and handle atclk
>   ARM: ux500: add CoreSight blocks to DTS file
>
>  arch/arm/boot/dts/ste-dbx5x0.dtsi        | 129 +++++++++++++++++++++++++++++++
>  drivers/coresight/coresight-etb10.c      |  74 +++++++++++-------
>  drivers/coresight/coresight-etm.h        |   4 +-
>  drivers/coresight/coresight-etm3x.c      | 102 +++++++++++++-----------
>  drivers/coresight/coresight-funnel.c     |  63 +++++++++++----
>  drivers/coresight/coresight-replicator.c |  43 +++++++++++
>  drivers/coresight/coresight-tmc.c        |  20 ++---
>  drivers/coresight/coresight-tpiu.c       |  62 +++++++++++----
>  8 files changed, 376 insertions(+), 121 deletions(-)
>
> --
> 1.9.3
>

Thank you for the submission.

I was waiting for issues with associating cpuidle_states and genPDs to
be sorted out before sending my own patchset, which is pretty close to
what you did, but this work can go in.

I'm in agreement with the comments raised by Ulf.  Also this patchset
doesn't apply against my coresight branch [1] or what is going into
4.1.  Do you think you can get me another version?

Thanks,
Mathieu

[1]. https://git.linaro.org/kernel/coresight.git/ master
