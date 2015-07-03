From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 3 Jul 2015 17:53:38 +0200 (CEST)
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <20150703154036.GD19284@katana>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana> <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana> <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana> <alpine.DEB.2.11.1507031640060.3916@nanos>
 <20150703150951.GC19284@katana> <alpine.DEB.2.11.1507031721390.3916@nanos>
 <20150703154036.GD19284@katana>
Message-ID: <alpine.DEB.2.11.1507031746550.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Jul 2015, Wolfram Sang wrote:
> > Ok. One more check please. Does nohz=off on the command line fix/hide
> > the issue as well?
> 
> Yes, it does. It boots to the prompt then.

So something is fishy with this timer. In your UP setting we don't
have any interaction with the broadcast stuff. It's just the single
em_sti timer involved.

Now looking at the code I notice, that this is one of the overly
clever designed compare register based trainwrecks.

Can you try the patch below, whether it makes a difference?

Thanks,

	tglx
---
diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index dc3c6ee04aaa..41d8035d294e 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -308,7 +308,7 @@ static void em_sti_register_clockevent(struct em_sti_priv *p)
 	dev_info(&p->pdev->dev, "used for clock events\n");
 
 	/* Register with dummy 1 Hz value, gets updated in ->set_mode() */
-	clockevents_config_and_register(ced, 1, 2, 0xffffffff);
+	clockevents_config_and_register(ced, 1, 100, 0xffffffff);
 }
 
 static int em_sti_probe(struct platform_device *pdev)
