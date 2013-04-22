From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Apr 2013 15:06:01 +0100
Subject: [PATCH v6 1/4] arm: introduce psci_smp_ops
In-Reply-To: <alpine.DEB.2.02.1304181714560.7254@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130418161341.GB14496@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1304181714560.7254@kaball.uk.xensource.com>
Message-ID: <20130422140601.GH14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 05:20:23PM +0100, Stefano Stabellini wrote:
> On Thu, 18 Apr 2013, Russell King - ARM Linux wrote:
> > Remember, we're trying to move away from using "mdesc"s for platform
> > stuff, relying on things like DT and such like.  We really should not
> > be going for mdesc-overriding-newstuff but newstuff-overriding-mdesc.
> 
> That's correct, in fact if you look at the next patch you'll see that it
> changes the order.

You may have noticed that I've been catching up with email, and it's
exceedingly difficult to track what patches are obsolete and have been
overridden by new versions.

> I introduced the mechanism first and changed the priority later - it
> should help bisectability.
> I can fold the two patches into one if you prefer.

On the face of it, I think that would be better.  I don't remember what
your last version looks like though.

> > Now, if the psci stuff can't be relied upon to provide the correct
> > functionality, then that's a separate problem which needs addressing
> > differently.
> > 
> > This should allow the Xen problem to be resolved, because Xen will
> > provide the PSCI operations, and it's correct in that case to override
> > the platform's SMP operations.
> 
> Yes, increasing the priority of PSCI helps Xen a lot.
> In order to completely solve the issue for Xen though, another patch is
> needed (http://marc.info/?l=linux-kernel&m=136630106201968&w=2) because
> of the introduction of smp_init.

Given the way the code in setup.c will work:

+static bool __init xen_smp_init(void)
+{
+#ifdef CONFIG_SMP
+	/* If we are running on Xen, use PSCI if available.
+	 * In any case do not try to use the native smp_ops. */
+	if (psci_smp_available())
+		smp_set_ops(&psci_smp_ops);
+#endif
+	return true;
+}

Doesn't this just need to return false, and then we'll drop down to
using PSCI if those operations are available?
