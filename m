From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu, 15 Oct 2015 15:30:16 +0200
Subject: Atmel sama5d3 boot regression, today's linux-next
Message-ID: <20151015133015.GA28863@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Atmel SAMA5D31 boards no longer boot on today's linux-next. Bisected to:

commit 7d24068e144adc03b805806645d732cf79488717
Author: Wonhong Kwon <wonhongkwon@gmail.com>
Date:   Tue Oct 6 10:10:20 2015 +0900

    PM / hibernate: Move pm_init/pm_disk_init to late_initcall_sync

    pm_init is being invoked by core_initcall and hibernate_image_size_init
    calculates preferred image size (image_size) based on total pages
    (totalram_pages). This totalram_pages can be modified during various
    initcall-s phase and this can cause miscalculated image_size.

    For example, when CMA is being used, init_cma_reserved_pageblock tries
    to change the totalram_pages and this job is done during core_initcall.
    In order words, the totalram_pages doesn't take CMA reserved pages into
    account when image_size is calculated and it can be too small.

    Move pm_init and pm_disk_init to late_initcall_sync so that it happens
    after all other initcall-s change the totalram_pages.

    Reported-by: Sangseok Lee <sangseok.lee@lge.com>
    Signed-off-by: Wonhong Kwon <wonhong.kwon@lge.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reverting it fixes the issue.

Sylvain
