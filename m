From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 29 Jun 2018 15:38:31 +0100
Subject: [PATCH v3 01/17] platform-msi: allow creation of MSI domain
 without interrupt number
In-Reply-To: <20180629094035.5199fe89@xps13>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
 <20180622151432.1566-2-miquel.raynal@bootlin.com>
 <c5b38c34-5ba0-6545-3635-45be1858fa3b@arm.com>
 <20180629094035.5199fe89@xps13>
Message-ID: <86bmbtzmhk.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jun 2018 08:40:35 +0100,
Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> Hi Marc,
> 
> Marc Zyngier <marc.zyngier@arm.com> wrote on Thu, 28 Jun 2018 12:12:04
> +0100:
> 
> > On 22/06/18 16:14, Miquel Raynal wrote:
> > > platform_msi_alloc_priv_data() checks that a number of interrupts is
> > > always given. This extra-check has no real impact and just prevents
> > > uselessly the user to create an MSI tree domain: remove it.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/base/platform-msi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> > > index 60d6cc618f1c..9f001f4ccc0f 100644
> > > --- a/drivers/base/platform-msi.c
> > > +++ b/drivers/base/platform-msi.c
> > > @@ -203,7 +203,7 @@ platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
> > >  	 * accordingly (which would impact the max number of MSI
> > >  	 * capable devices).
> > >  	 */
> > > -	if (!dev->msi_domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
> > > +	if (!dev->msi_domain || !write_msi_msg || nvec > MAX_DEV_MSIS)
> > >  		return ERR_PTR(-EINVAL);
> > >  
> > >  	if (dev->msi_domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {
> > >   
> > 
> > Huh... It's not that simple.
> > 
> > Yes, it allows you to get a tree via platform_msi_create_device_domain
> > (assuming that's why you're changing it -- your commit message doesn't
> > say much)
> 
> Indeed. That was exactly my intention.
> 
> > but it also has some impact on the way msi_domain_prepare_irqs
> > works (see how it is called from platform_msi_create_device_domain).
> > 
> > Importantly, the msi_prepare callback takes nvec as a parameter, and
> > that ends up trickling down to the irqchip, or whatever will setup the
> > MSI domain. Things like the GICv3 ITS do rely on that to carve out the
> > LPI space that subsequently gets used to populate the domain.
> > 
> > So no, you can't do it like that. If you really want a tree, add a
> > helper that does so.
> 
> So if I understand correctly, what should be done is writting a new
> helper that would do something similar to
> platform_msi_create_device_domain(), but creating instead a tree domain
> and still giving msi_domain_prepare_irqs() a meaningful number (as
> nvec) that would be the maximum number of MSIs that could be allocated.
> Am I right here?

What I have in mind is the following (untested) patch. Let me know if
that works for you.

Thanks,

	M.

>From f9bc9e331503b0d7f44fe9771fedb8bcd4a2c979 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Fri, 29 Jun 2018 15:29:11 +0100
Subject: [PATCH] genirq/msi: Allow creation of a tree-based irqdomain for
 platform-msi

platform_msi_create_device_domain() always creates a revmap-based
irqdomain, which has the drawback of requiring the number of MSIs
that can be allocated ahead of time. This is not always possible,
and we sometimes need to use a tree-based irqdomain instead.

Add a new platform_msi_create_device_tree_domain() helper to
that effect.

Reported-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/base/platform-msi.c | 14 ++++++++------
 include/linux/msi.h         | 17 ++++++++++++-----
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 60d6cc618f1c..f39a920496fb 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -321,11 +321,12 @@ void *platform_msi_get_host_data(struct irq_domain *domain)
  * Returns an irqdomain for @nvec interrupts
  */
 struct irq_domain *
-platform_msi_create_device_domain(struct device *dev,
-				  unsigned int nvec,
-				  irq_write_msi_msg_t write_msi_msg,
-				  const struct irq_domain_ops *ops,
-				  void *host_data)
+__platform_msi_create_device_domain(struct device *dev,
+				    unsigned int nvec,
+				    bool is_tree,
+				    irq_write_msi_msg_t write_msi_msg,
+				    const struct irq_domain_ops *ops,
+				    void *host_data)
 {
 	struct platform_msi_priv_data *data;
 	struct irq_domain *domain;
@@ -336,7 +337,8 @@ platform_msi_create_device_domain(struct device *dev,
 		return NULL;
 
 	data->host_data = host_data;
-	domain = irq_domain_create_hierarchy(dev->msi_domain, 0, nvec,
+	domain = irq_domain_create_hierarchy(dev->msi_domain, 0,
+					     is_tree ? 0 : nvec,
 					     dev->fwnode, ops, data);
 	if (!domain)
 		goto free_priv;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 5839d8062dfc..0e9c50052ff3 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -317,11 +317,18 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *args);
 struct irq_domain *
-platform_msi_create_device_domain(struct device *dev,
-				  unsigned int nvec,
-				  irq_write_msi_msg_t write_msi_msg,
-				  const struct irq_domain_ops *ops,
-				  void *host_data);
+__platform_msi_create_device_domain(struct device *dev,
+				    unsigned int nvec,
+				    bool is_tree,
+				    irq_write_msi_msg_t write_msi_msg,
+				    const struct irq_domain_ops *ops,
+				    void *host_data);
+
+#define platform_msi_create_device_domain(dev, nvec, write, ops, data)	\
+	__platform_msi_create_device_domain(dev, nvec, false, write, ops, data)
+#define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
+	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
+
 int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 			      unsigned int nr_irqs);
 void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-- 
2.17.1


-- 
Jazz is not dead, it just smell funny.
