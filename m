From: abelvesa@gmail.com (Abel Vesa)
Date: Thu, 2 Mar 2017 21:01:24 +0000
Subject: [PATCHv4] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <20170228115429.GC23251@nuc>
References: <1487977101-29027-1-git-send-email-abelvesa@linux.com>
 <87r32jiqc9.fsf@d080-213.cis.zmaw.de> <20170228005636.GA23251@nuc>
 <87h93eoa3a.fsf@gmail.com> <20170228112227.GB23251@nuc>
 <20170228114638.GC21222@n2100.armlinux.org.uk>
 <20170228115429.GC23251@nuc>
Message-ID: <20170302210124.GA9391@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 11:54:29AM +0000, Abel Vesa wrote:
> On Tue, Feb 28, 2017 at 11:46:38AM +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 28, 2017 at 11:22:27AM +0000, Abel Vesa wrote:
> > > On Tue, Feb 28, 2017 at 11:58:49AM +0100, Nicolai Stange wrote:
> > > > Hi Abel,
> > > > 
> > > > On Tue, Feb 28 2017, Abel Vesa wrote:
> > > > 
> > > > > On Mon, Feb 27, 2017 at 04:52:06PM +0100, Nicolai Stange wrote:
> > > > >> On Fri, Feb 24 2017, Abel Vesa wrote:
> > > > >> Wouldn't it be better (and more consistent with other archs) to have
> > > > >> 
> > > > >>   pt_regs->ARM_lr = original lr
> > > > >>   pt_refs->ARM_pc = current lr
> > > > >> 
> > > > >> instead?
> > > > 
> > > > The stack would look like this then
> > > > 
> > > > @ ...           | ARM_ip | ARM_sp | ARM_lr      | ARM_pc      | ...          |
> > > > @ 0  4          48       52       56            60            64    68       72
> > > > @ R0 | R1 | ... | LR     | SP + 4 | original LR | original PC | PSR | OLD_R0 | original LR |
Just to make sure we're on the same page. If we are replacing the LR 
with the original_LR is it worth keeping around the one pushed before 
the ftrace_regs_caller is called?

Another thing, PC needs to be new_LR and then we can restore all 
regs r0 through r15 like this:

	ldmia   sp, {r0-r15}
> > > > 
> > > > I.e. the pt_regs would capture almost the full context of the
> > > > instrumented function (except for ip).
> > > > 
> > > So basicly what you are saying is:
> > > - instead of current LR save original LR (previous one saved in instrumented function epilog)
> > > - instead of current PC save original PC (previous one saved in instrumented function epilog)
> > > 
> > > I still don't see the point of saving the actual value of PC since nobody will ever
> > > restore it. In case of livepatch it will get overwritten anyway. As for LR, I agree,
> > > it could be the original one in pt_regs.
> > > 
> > > I'll look into this sometime today or tomorrow and get back with updates.
> > 
> > Which is exactly what I proposed, with code, on one of the previous
> > iterations of this patch...
> Fair enough. I probably missunderstood your comments then.
> 
> Thanks.
> > 
> > -- 
> > RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> > according to speedtest.net.
