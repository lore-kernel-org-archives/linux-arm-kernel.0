From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Jul 2014 11:52:58 +0100
Subject: [PATCH v3 3/8] component: add support for component match array
In-Reply-To: <CAK5sBcEupbnzpxskD8D7wXbFRfU+4gh5oDE9X-SvkZEQ2+dQ_w@mail.gmail.com>
References: <CAK5sBcEupbnzpxskD8D7wXbFRfU+4gh5oDE9X-SvkZEQ2+dQ_w@mail.gmail.com>
Message-ID: <20140704105258.GF21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 04:17:35PM +0530, Sachin Kamat wrote:
> Hi Russell
> 
> > +int component_master_add_with_match(struct device *dev,
> > +       const struct component_master_ops *ops,
> > +       struct component_match *match)
> >  {
> >         struct master *master;
> >         int ret;
> >
> > +       if (ops->add_components && match)
> > +               return -EINVAL;
> > +
> > +       /* Reallocate the match array for its true size */
> > +       match = component_match_realloc(dev, match, match->num);
> 
>            ^^^^^^^^^^^^^
> This gives a NULL pointer dereference error when match is NULL (as passed
> by component_master_add() below). Observed this while testing linux-next
> kernel (next-20140704) on Exynos based board with DRM enabled.

Thanks for your report.  Please verify that the patch below resolves it
for you.  Thanks.

 drivers/base/component.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index b4236daed4fa..f748430bb654 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -293,10 +293,12 @@ int component_master_add_with_match(struct device *dev,
 	if (ops->add_components && match)
 		return -EINVAL;
 
-	/* Reallocate the match array for its true size */
-	match = component_match_realloc(dev, match, match->num);
-	if (IS_ERR(match))
-		return PTR_ERR(match);
+	if (match) {
+		/* Reallocate the match array for its true size */
+		match = component_match_realloc(dev, match, match->num);
+		if (IS_ERR(match))
+			return PTR_ERR(match);
+	}
 
 	master = kzalloc(sizeof(*master), GFP_KERNEL);
 	if (!master)


-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
