From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 19 Mar 2013 07:44:31 -0400
Subject: [PATCH v3 0/9] refactoring for mask_cache
In-Reply-To: <51484793.5020102@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
 <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
 <20130319100352.GB2419@localhost>
 <20130319110620.GO13280@titan.lakedaemon.net>
 <51484793.5020102@keymile.com>
Message-ID: <20130319114430.GP13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 12:10:11PM +0100, Gerlando Falauto wrote:
> On 03/19/2013 12:06 PM, Jason Cooper wrote:
> >On Tue, Mar 19, 2013 at 07:03:53AM -0300, Ezequiel Garcia wrote:
> >>Hi Gerlando,
> >>
> >>On Mon, Mar 18, 2013 at 03:00:46PM +0100, Gerlando Falauto wrote:
> >>>here is a patchset to address the issue found with Orion, in incremental
> >>>stages as Thomas suggested.
> >>>a) we introduce the new fields and pointer (though only the shared one is used)
> >>>b) we convert all drivers to use it
> >>>c) we rename the field so to force the use of the per-ct pointer
> >>>d) we add per-ct mask cache, provided the new flag
> >>>    IRQ_GC_SEPARATE_MASK_REGISTERS is enabled
> >>>e) we enable the flag for orion-gpio and mvebu drivers
> >>>
> >>>So even though I'm also providing changes for mvebu, I only
> >>>tested the patch on a 3.0.40 kernel with the plat-orion/gpio.c driver.
> >>
> >>Great job! Since this is a really old bug you're fixing I believe that the
> >>patchset applies for stable as well as mainline.
> >>
> >>According to Documentation/stable_kernel_rules.txt all you need to do
> >>is add a 'Cc: stable at vger.kernel.org' tag in your sign-off area.
> >>
> >>Stable people will take care of picking the patch when it hits
> >>mainline. You should receive a mail notification about patches
> >>being included in stable kernels.
> >
> >Yes, and if you have an idea of when the regression was introduced,
> >perhaps even which commit, that would be *extremely* helpful.
> 
> Uhm, you're right, that piece of information sort of got lost while
> reworking the whole thing (from a single patch to a 9-piece
> series!).
> Here it is:
> 
> This fixes a regression introduced by e59347a
> "arm: orion: Use generic irq chip".

Great!

$ git tag --contains e59347a | grep '^v[23]\.[0-9]*\.' | \
	sed -e 's/\.[0-9]*$/.x/' | sort -uV
v3.0.x
v3.1.x
v3.2.x
v3.3.x
v3.4.x
v3.5.x
v3.6.x
v3.7.x
v3.8.x

So:

 Cc: <stable@vger.kernel.org> # 3.0.x

oughta do it for the first patch...

> Question is, where (out of the 9 patches) should that be mentioned?
> On all of them?

That's where it gets more complicated.  Short answer, yes.  The long
answer:  You need to tell the stable team about the dependencies in your
series.  After reading bullet 3 of "Procedures for submitting patches"
in stable_kernel_rules.txt, I would break up your series into two
chunks.

The first is that which can be applied to v3.0.x on up (everything
fixing the regression and plat-orion/gpio.c).  The second being the fix
to gpio-mvebu.c.  Anything affecting gpio-mvebu.c should only be for
v3.7.x and newer.  It would still list the dependency on v3.0.x series
of patches.

Each patch in your series should then have a longer and longer list of
 Cc: stable... lines as they list the previous patches in the series.

Those commit IDs are going to change once LinusW (I presume) applies
them to his tree, so he'll have to edit each commit message to point the
the correct commit.

LinusW, do you want me to handle this?  If you prefer to take it:

Whole series:

Acked-by: Jason Cooper <jason@lakedaemon.net>

Gerlando, Feel free to ask if you have any questions.

Also note, this is something the sub-system maintainers usually handle.
We appreciate all the help we can get, though.  ;-)  Just letting us
know which patch introduced the regression makes this a lot easier.

thx,

Jason.
