From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 19:58:16 +0100
Subject: [PATCH 05/32] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <201302121800.48723.arnd@arndb.de>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302121800.48723.arnd@arndb.de>
Message-ID: <20130212195816.6e34b3ce@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 12 Feb 2013 18:00:48 +0000, Arnd Bergmann wrote:
> On Tuesday 12 February 2013, Thomas Petazzoni wrote:
> > The pcim_*() functions are used by the libata-sff subsystem, and
> > this subsystem is used for many SATA drivers on ARM platforms that
> > do not necessarily have I/O ports.
> > 
> > Signed-off-by: Thomas Petazzoni
> > <thomas.petazzoni@free-electrons.com> Cc: Paul Gortmaker
> > <paul.gortmaker@windriver.com> Cc: Jesse Barnes
> > <jbarnes@virtuousgeek.org> Cc: Yinghai Lu <yinghai@kernel.org>
> > Cc: linux-kernel at vger.kernel.org
> 
> Sorry, but this patch is still incorrect.

I know, but the discussion was so huge on the first posting that it was
basically impossible to draw a conclusion out of it.

> Any driver that requires a
> linear mapping of I/O ports to __iomem pointers must depend
> CONFIG_HAS_IOPORT with the current definition of that symbol (as
> mentioned before, we should really rename that to
> CONFIG_HAS_IOPORT_MAP). Having these functions not defined is a
> compile time check that is necessary to ensure that all drivers have
> the correct annotation.

I have the feeling that the problem is more complex than that. My
understanding is that the pcim_iomap_regions() function used by
drivers/ata/libata-sff.c can perfectly be used to map memory BARs, and
not necessarily I/O BARs. Therefore, this driver can perfectly be used
in an architecture where CONFIG_NO_IOPORT is selected.

The thing is that pcim_iomap_regions() transparently allows to remap an
I/O BAR is such a BAR is passed as argument, or a memory BAR if such a
BAR is passed as argument.

Therefore, I continue to believe that the pcim_*() functions are useful
even if the platform doesn't have CONFIG_HAS_IOPORT.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
