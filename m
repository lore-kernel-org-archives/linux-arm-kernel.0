From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 5 Dec 2011 18:45:22 +0000
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
References: <20111110162859.GA7088@oksana.dev.rtsoft.ru>
 <20111202192618.GC3037@localhost.localdomain>
 <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
Message-ID: <20111205184522.316598de@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> But as you illustrated, there is a large number of drivers that already 
> assume no IRQ is < 0, even if they don't use any IRQ #0 themselves.  
> That is a much bigger problem to fix.

And a much larger number assuming the reverse is true which are hiding
potential bugs on ARM.

Looking at the serial stuff the best checks appear to be looking at
"irq", "-1" and NO_IRQ.

For migration stuff that's doing broken things like

	if (irq < 0)

can be changed to

	if (irq <= 0)

and that can be done before NO_IRQ itself is nailed on ARM and PA-RISC.
