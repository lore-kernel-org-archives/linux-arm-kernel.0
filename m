From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 18 Apr 2018 15:48:56 +0300
Subject: [bug report] coresight: tmc: allocating memory when needed
Message-ID: <20180418124856.GA5771@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ This bug is a couple years old now so presumably it can't be that
  serious but maybe it's still worth looking at?  -dan ]

Hello Mathieu Poirier,

The patch de5461970b3e: "coresight: tmc: allocating memory when
needed" from May 3, 2016, leads to the following static checker
warning:

	drivers/hwtracing/coresight/coresight-tmc-etr.c:174 tmc_enable_etr_sink_sysfs()
	error: uninitialized symbol 'paddr'.

drivers/hwtracing/coresight/coresight-tmc-etr.c
   121  static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
   122  {
   123          int ret = 0;
   124          bool used = false;
   125          unsigned long flags;
   126          void __iomem *vaddr = NULL;
   127          dma_addr_t paddr;
                ^^^^^^^^^^^^^^^^
   128          struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
   129  
   130  
   131          /*
   132           * If we don't have a buffer release the lock and allocate memory.
   133           * Otherwise keep the lock and move along.
   134           */
   135          spin_lock_irqsave(&drvdata->spinlock, flags);
   136          if (!drvdata->vaddr) {
                     ^^^^^^^^^^^^^^
   137                  spin_unlock_irqrestore(&drvdata->spinlock, flags);
   138  
   139                  /*
   140                   * Contiguous  memory can't be allocated while a spinlock is
   141                   * held.  As such allocate memory here and free it if a buffer
   142                   * has already been allocated (from a previous session).
   143                   */
   144                  vaddr = dma_alloc_coherent(drvdata->dev, drvdata->size,
   145                                             &paddr, GFP_KERNEL);
   146                  if (!vaddr)
   147                          return -ENOMEM;
   148  
   149                  /* Let's try again */
   150                  spin_lock_irqsave(&drvdata->spinlock, flags);
   151          }
   152  
   153          if (drvdata->reading) {
   154                  ret = -EBUSY;
   155                  goto out;
   156          }
   157  
   158          /*
   159           * In sysFS mode we can have multiple writers per sink.  Since this
   160           * sink is already enabled no memory is needed and the HW need not be
   161           * touched.
   162           */
   163          if (drvdata->mode == CS_MODE_SYSFS)
   164                  goto out;
   165  
   166          /*
   167           * If drvdata::buf == NULL, use the memory allocated above.
   168           * Otherwise a buffer still exists from a previous session, so
   169           * simply use that.
   170           */
   171          if (drvdata->buf == NULL) {
                    ^^^^^^^^^^^^^^^^^^^^

Perhaps ->buf is only NULL when ->vaddr is NULL?  It's surprising that
we're not testing ->buf in both places.

   172                  used = true;
   173                  drvdata->vaddr = vaddr;
   174                  drvdata->paddr = paddr;
                        ^^^^^^^^^^^^^^^^^^^^^^^

   175                  drvdata->buf = drvdata->vaddr;
   176          }
   177  
   178          drvdata->mode = CS_MODE_SYSFS;

regards,
dan carpenter
