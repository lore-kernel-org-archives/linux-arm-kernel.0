From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Oct 2011 14:48:52 -0700
Subject: linux-next failure on tegra due to conflicts between PPI and irq
	domain patches and irq.h->module.h include removal
Message-ID: <CAOesGMhqRg29tq5Cw03UQMzGs_6nc3YA9UE6Cvps_0q7h5OeZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Looks like Marc added new references to irq_start in his PPI patch,
and Rob removed it in parallel. Also, irq_offset is no longer
available. Looks like you need to respin your patch, Marc.

arch/arm/common/gic.c: In function 'gic_dist_init':
arch/arm/common/gic.c:290: error: 'irq_start' undeclared (first use in
this function)
arch/arm/common/gic.c:290: error: (Each undeclared identifier is
reported only once
arch/arm/common/gic.c:290: error: for each function it appears in.)
arch/arm/common/gic.c:296: error: 'struct gic_chip_data' has no member
named 'irq_offset'


The second error is because of the change from Paul that removes
module.h from irq.h:

arch/arm/common/gic.c: In function 'gic_init':
arch/arm/common/gic.c:620: error: 'THIS_MODULE' undeclared (first use
in this function)

Looks odd that I should need to include module.h on my own just to use
irq defines. Paul?


-Olof
