From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jun 2014 15:46:36 +0100
Subject: [PATCH/RESEND 9/9] drm/tilcdc: replace late_initcall with
 module_init
In-Reply-To: <20140625143246.GA743@arch.cereza>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-10-git-send-email-guido@vanguardiasur.com.ar>
 <53A9F5F4.3030806@ti.com> <20140625130042.GK3705@n2100.arm.linux.org.uk>
 <20140625143246.GA743@arch.cereza>
Message-ID: <20140625144636.GO3705@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 11:32:46AM -0300, Ezequiel Garc?a wrote:
> (Ccing Guido back)
> 
> Hello Russell, Darren,
> 
> On 25 Jun 02:00 PM, Russell King - ARM Linux wrote:
> > On Tue, Jun 24, 2014 at 05:04:36PM -0500, Darren Etheridge wrote:
> > > If I recall, the late_initcall stuff was done to try and make sure the  
> > > tda998x/i2c subsystem came up before tilcdc.
> 
> That doesn't make any sense. Using late_initcall for the tilcdc DRM
> driver would make the tilcdc DRM get probed before any other regular
> module_init driver, including the tda998x encoder.

A module_init() is a device_initcall(), which is at level 6.  A
late_initcall() is at level 7.  Level 6 initcalls are run before level
7 initcalls.  The tda998x is a module_init(), so the tda998x gets
initialised *before* tilcdc's late_initcall().

Now, if you build everything as a module, then you have no initialisation
ordering, and you can't rely on any kind of order.  Initialisation
functions can even run in parallel on different CPUs due to modules being
loaded from userspace in a multi-threaded way.  So anything which relies
on a certain initcall ordering is fundamentally broken if it can be
modular.

> > There's a solution to that...
> 
> A solution to *what* ?

Maybe if you left the context above that line in place, you might
understand that my "that" refers to what was discussed in that
context.  That being the initialisation ordering.

Convention and proper Internet etiquette is to trim the quoted text
and place relies below the paragraph to which they refer, the quoted
paragraph giving the context to the reply.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
