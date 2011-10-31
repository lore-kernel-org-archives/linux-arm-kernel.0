From: will.deacon@arm.com (Will Deacon)
Date: Mon, 31 Oct 2011 14:37:45 +0000
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111031141322.GK19187@n2100.arm.linux.org.uk>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
	<20111031141322.GK19187@n2100.arm.linux.org.uk>
Message-ID: <20111031143744.GE29349@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 02:13:22PM +0000, Russell King - ARM Linux wrote:
> On Sat, Oct 29, 2011 at 02:56:53PM +0100, Will Deacon wrote:
> > The only downside is that I have to go over all of the platforms again
> > unless I can polish up my Coccinelle-fu. Ho-hum.
> 
> Well, I've just given coccinelle a go, and having read all the hype about
> it, I'm completely disappointed with it to the extent that I'm going to
> uninstall the tool from my system (unless someone can point out what I'm
> doing wrong.)

I'm really new to it, so I'm by no means an expert...

> I thought I'd give it a spin on a nice simple change - deleting the
> local_irq_disable() calls inside arch_reset() (irqs have already been
> disabled by this time):
> 
> @@
> identifier mode, cmd;
> @@
> 
> arch_reset(char mode, const char *cmd)
> {
> ...
> - local_irq_disable();
> ...
> }

Looks good to me.

> $ spatch -sp_file arch_reset-1.cocci arch/arm/*/include/*/system.h > arch_reset-1.diff
> 
> The diff it created contains:
> 
> --- arch/arm/mach-ep93xx/include/mach/system.h  2011-03-04 19:52:46.419272878 +0000
> +++ /tmp/cocci-output-380-f841cc-system.h       2011-10-31 13:54:52.066705107 +0000
> ...
> --- arch/arm/mach-iop32x/include/mach/system.h  2011-03-04 19:52:46.445272534 +0000
> +++ /tmp/cocci-output-380-c0e3f4-system.h       2011-10-31 13:54:52.072705051 +0000
> ...
> --- arch/arm/mach-ixp2000/include/mach/system.h 2011-03-04 19:52:46.449272482 +0000
> +++ /tmp/cocci-output-380-467f17-system.h       2011-10-31 13:54:52.079704984 +0000
> ...
> 
> which in total deletes 6 lines.  However, the patch is rejected by
> git apply and gnu patch as it stands - it needs the filenames to be
> edited to something more reasonable.  So that also takes six edits.

Ah, yeah, that's not good. I tried using the -dir option but ran into
problems, since spatch only descends one level into the filesystem hierarchy.
In the end I used find and xargs :)

Will
