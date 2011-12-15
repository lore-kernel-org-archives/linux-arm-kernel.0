From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 15 Dec 2011 15:25:51 +0000
Subject: [PATCH v6 3/9] ARM: versatile: Map local timers using Device
 Tree when possible
In-Reply-To: <4EEA09E8.3010807@gmail.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-4-git-send-email-pawel.moll@arm.com>
 <4EEA09E8.3010807@gmail.com>
Message-ID: <1323962751.18989.4.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-12-15 at 14:53 +0000, Rob Herring wrote:
> > @@ -21,6 +23,16 @@
> >   */
> >  int __cpuinit local_timer_setup(struct clock_event_device *evt)
> >  {
> > +#if defined(CONFIG_OF)
> > +	struct device_node *node = of_find_compatible_node(NULL,
> > +			NULL, "arm,smp-twd");
> > +
> > +	if (node)
> > +		twd_base = of_iomap(node, 0);
> > +#endif
> 
> I think your previous version was more correct. This is going to find
> the node and do ioremap N times where N is the number of cores. It does
> work though because that is what I did initially too.

Right, how about that, then:

@@ -21,6 +23,22 @@
  */
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
+#if defined(CONFIG_OF)
+       static int dt_node_probed;
+
+       if (!dt_node_probed) {
+               struct device_node *node = of_find_compatible_node(NULL,
+                               NULL, "arm,smp-twd");
+
+               if (node)
+                       twd_base = of_iomap(node, 0);
+
+               dt_node_probed = 1;
+       }
+#endif
+       if (!twd_base)
+               return -ENXIO;
+
        evt->irq = IRQ_LOCALTIMER;
        twd_timer_setup(evt);
        return 0;


Cheers!

Pawe?
