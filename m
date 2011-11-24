From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 24 Nov 2011 18:49:46 +0000
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <alpine.LFD.2.02.1111241336320.17904@xanadu.home>
References: <20111123175446.GI30049@opensource.wolfsonmicro.com>
 <alpine.LFD.2.02.1111231402370.17904@xanadu.home>
 <alpine.LFD.2.02.1111231929050.17904@xanadu.home>
 <20111124125615.GJ8470@opensource.wolfsonmicro.com>
 <20111124160853.GB2509@sirena.org.uk>
 <alpine.LFD.2.02.1111241254310.17904@xanadu.home>
 <20111124180228.GA32119@opensource.wolfsonmicro.com>
 <alpine.LFD.2.02.1111241316510.17904@xanadu.home>
 <20111124183153.GA3395@opensource.wolfsonmicro.com>
 <alpine.LFD.2.02.1111241336320.17904@xanadu.home>
Message-ID: <20111124184946.GB3395@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 01:37:51PM -0500, Nicolas Pitre wrote:
> On Thu, 24 Nov 2011, Mark Brown wrote:

> > It looks like that'll need more substantial refactoring than I have the
> > time to do right now, currently the CPU ID is immediately used to decide
> > how to carry on with low level setup.

> Where, and from what call path?

s3c64xx_init_io() is:

	/* initialise the io descriptors we need for initialisation */
	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
	iotable_init(mach_desc, size);
	init_consistent_dma_size(SZ_8M);

	/* detect cpu id */
	s3c64xx_init_cpu();

	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));

where s3c64xx_init_cpu() is the function relying on the effects of the
first iotable_init().  It initializes samsung_cpu_id for the call to 
s3c_init_cpu() which calls the callbacks in s3c6400.c or s3c6410.c.

Simply moving the detection to init_early() fails though I only tried
briefly.
