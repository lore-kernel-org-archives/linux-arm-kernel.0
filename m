From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jun 2015 22:30:07 +0100
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
In-Reply-To: <CADhT+wdJX7jMO3_rafrZMeA5ZVMaA6b2U4zkksfJcUjh41mH9A@mail.gmail.com>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
 <CAMuHMdX=T3CsLTT95H_07Si6Kd8SRraBfxADpn+VtAF4GmZ=mw@mail.gmail.com>
 <CAMuHMdUQkm_9PhSdGS8j85Uodm-o0jiki=Xh4h59PBShB=rCXw@mail.gmail.com>
 <20150601105319.GQ2067@n2100.arm.linux.org.uk>
 <CAMuHMdUXCy+87-pwLiJ7ynaM1AeFq0f7R3sJ4prdE3QN09z++w@mail.gmail.com>
 <CADhT+wdJX7jMO3_rafrZMeA5ZVMaA6b2U4zkksfJcUjh41mH9A@mail.gmail.com>
Message-ID: <20150617213006.GC7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 03:35:13PM -0500, Dinh Nguyen wrote:
> On Mon, Jun 1, 2015 at 6:50 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Hi Russell,
> >
> > On Mon, Jun 1, 2015 at 12:53 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Mon, Jun 01, 2015 at 12:41:01PM +0200, Geert Uytterhoeven wrote:
> >>> FWIW, I have the feeling this has a slight influence on boot reliability on
> >>> two of my boards:
> >>>   - r8a7740/armadillo, which is known to suffer from a cache-related bug in
> >>>     its bootloader, seems to have a higher change of booting successfully on
> >>>     cold boot,
> >>>   - sh73a0/kzm9g, which has known cache-issues with secondary CPU boot up,
> >>>     seems to have a lower chance of booting successfully.
> >>>
> >>> No time to spend all week turning this into a statistical significant test
> >>> project... The reset button is my friend...
> >>
> >> Damn it, you sent this right after I merged and pushed out this change in
> >> my for-arm-soc branch, and was just about to send it to the arm-soc people.
> >> What excellent timing you have. :)
> >
> > Don't worry, I didn't send that email to make you postpone this change.
> > Giving the fuzziness of reproduction, and the flakiness (esp. on Armadillo)
> > of the boot loader, and these are old SoCs, please go ahead.
> >
> >> What happens on the kzm9g if you revert the mach-shmobile changes?
> >
> > Seems to make no difference.
> >
> >> For armadillo, do you use the decompressor?  That should be doing all the
> >> cache cleaning already, prior to the kernel being entered.
> >
> > I think so.
> >
> > Corruption pattern ranges from lock up, over "Error: unrecognized/unsupported
> > machine ID", to booting almost completely, but lacking a few devices due to
> > a corrupted DTB. Been like that as long as I remember, i.e. since I got the
> > board ca. 1 year ago. Boots fine (100%) with kexec.
> >
> 
> It seems like this patch is causing the SoCFPGA to not boot with SMP
> reliably. About 1 out of every 10 reboots, I'm seeing the boot failure
> below. The error seems to only happen when I do a cold or warm reboot,
> but never occurs during a power-up. If I revert this patch, or put
> back the call to v7_invalidate_l1 in socfpga_secondary_startup , then
> its able to boot 100% of the time.

It really sucks that you're only just testing this change now, because
I've frozen my tree, and removing it for the next merge window is going
to be an entirely non-trivial matter.  You were copied on the original
patch, which you failed to test... I can't say I have _much_ sympathy
for a bug report at this point in time.

> Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted
> 4.1.0-rc8-next-20150617-00002-gdd1f624 #1
> Hardware name: Altera SOCFPGA
> task: eecaeac0 ti: eecce000 task.ti: eecce000
> PC is at vfp_notifier+0x58/0x12c
> LR is at notifier_call_chain+0x44/0x84

This suggests that access to the VFP coprocessor is still disabled.
However, vfp_hotplug() should have been called for CPU1 before it
gets here, which should call vfp_enable(), which should enable access.

However, what I'm wondering is...

> [<c000a6bc>] (vfp_notifier) from [<c003d134>] (notifier_call_chain+0x44/0x84)
> [<c003d134>] (notifier_call_chain) from [<c003d18c>]
> (__atomic_notifier_call_chain+0x18/0x20)
> [<c003d18c>] (__atomic_notifier_call_chain) from [<c003d1ac>]
> (atomic_notifier_call_chain+0x18/0x20)
> [<c003d1ac>] (atomic_notifier_call_chain) from [<c001369c>]
> (__switch_to+0x34/0x58)

what the rest of the trace is.  Unfortunately, we mark __switch_to() as
"cantunwind" which means the unwinder always stops here.  It would be
really good to know what is responsible for this scheduling event,
whether it's due to a lock which is tried to be taken but is found to
be locked, but I don't think we can modify __switch_to() to allow it
to unwind (and I don't have the unwinder knowledge to hand to hack
something together.)

In order to see what's going on here, we do need to see the rest of the
trace... right now I don't have the time to be able to sort out
__switch_to() to achieve that.

As I say, you should have tested this earlier.  About the only thing I
can do now is to revert the entire original patch, which is going to be
extremely disruptive as it'll cause yet more conflicts between trees -
again, something that we want to be avoiding at this stage in the game.

Please test patches earlier.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
