From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Tue, 19 Jul 2011 10:05:02 +0100 (BST)
Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register
	of ARM v6 & v7 Architectures
In-Reply-To: <4E2426F4.6060609@st.com>
References: <mailman.2928.1310636156.20023.linux-arm-kernel@lists.infradead.org>
	<alpine.DEB.2.00.1107141054400.2609@localhost6.localdomain6>
	<4E20440C.80902@st.com>
	<alpine.DEB.2.00.1107151611540.2303@localhost6.localdomain6>
	<4E2426F4.6060609@st.com>
Message-ID: <alpine.DEB.2.00.1107190927030.2369@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Jul 2011, Wolfgang BETZ wrote:

> Hi Frank,
>
> > On 07/15/2011 05:59 PM, Frank Hofmann wrote:
> >
> > Ah, ok, I see now ...
> >
> >
> > We were a bit ahead of the world; Will Deacon and myself have recently
> > (June) submitted patches for discussion that require / use MMU-off
> > codepaths.
[ ... ]

Hi Wolfgang,

>
> As described in my previous mail to Will Deacon, using the task structure input is unfortunately unavoidable, but your proposal regarding the resembling of the generic switch_mm signature would be absolutely OK with me. Actually, what we proposed was simply unaware of your efforts regarding MMU-off code-paths and not due to a special need regarding to the switch_mm signature. So, if you agree, I will prepare a new version of our patch (v3) which will aim at accommodate your proposal and send it to the ARM kernel mailing list asap.

thanks for the clarification. As far as using it, if it's callable with 
the same args as the system passes to switch_mm() than that's fine for me.

>
> Please let me repeat just one thing which I believe is essential to keep in mind when evaluating our patch: the patch is the outcome of a mid-term collaboration between STM & Lauterbach and is solely about tracing with the ETM (either off-chip with a debugger, or on-chip into an ETB). Without the patch there is no chance to detect thread switches!!!
> There are already *several* customers using the patch happily - so we can be quite sure that it works and above all that it does not compromise the ASID overflow handling in the way it was already implemented in the Linux kernel.

Well, as a developer I value everything that helps me do debugging of 
course. In that sense, no doubt the patch works and does what it 
advertises. It's cycles well spent - for that purpose.

On the other hand, as a user I value a well-performing, responsive system 
even if the hardware in my appliance is on the lower end. And if achieving 
that means making the developer's task a little harder, then so be it ... 
that's the job.

In that sense, "detecting thread switches" - breakpoints/hooks in the 
context switching code (and/or postprocessing E/PTM trace instruction 
addresses against the kernel symbol table) achieve that as well, don't 
they ? The MMU context ID reg (or whichever other mach-specific "handle 
reg" is used) is a shortcut, agreed, and a really useful one where 
available, but you make it sound like the only means to that end. Is it 
really ?


What I'm trying to say is that it is only useful on v6/v7 that support it 
in hardware - which are the faster ones anyway. Adding it unconditionally 
(even if only a few dozen cycles for the empty-arg-marshaling) punishes 
those most which have most to loose from overhead.
I.e. if it's possible to _not create_ this code in the first place for the 
"minor" ARM chips (where it just burns cycles for no gain), then wouldn't 
that be worth doing ?

just my 0.02p,
FrankH.

>
> Pleas let me know!
>
> Ciao Wolfgang

>
>
>
>
