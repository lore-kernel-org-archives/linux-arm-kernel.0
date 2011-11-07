From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Nov 2011 19:14:53 +0000
Subject: 2b034922 breaks kexec on ARM
In-Reply-To: <20111107190314.GS12913@n2100.arm.linux.org.uk>
References: <20111107185125.GA17464@mudshark.cambridge.arm.com>
 <20111107190314.GS12913@n2100.arm.linux.org.uk>
Message-ID: <20111107191453.GC17464@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 07:03:15PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 07, 2011 at 06:51:25PM +0000, Will Deacon wrote:
> > Hello,
> > 
> > I've just finished rebasing and reworking my kexec patches so that they sit
> > nicely on top of Russell's recent reset work. The only problem is that
> > commit 2b034922 ("ARM: 7098/1: kdump: copy kernel relocation code at the
> > kexec prepare stage") is causing kexec to fail.
> > 
> > The symptoms are that the .init.text section is not loaded as part of the
> > new kernel image, so when we try to do the SMP/UP fixups we hit a whole sea
> > of poison left there by the previous kernel.
> > 
> > So my guess is that machine_kexec_prepare *is* too early for preparing the
> > reboot_code_buffer and, unless anybody has a good reason not to, I'd like to
> > revert the patch causing these problems.
> 
> Hmm, having looked at kernel/kexec.c, this patch is clearly wrong.
> There are two kernels which can be loaded into kexec - a crash kernel
> and a default kernel.  These are kept entirely separately (and the
> per-kernel context is stored in 'image').
> 
> However, this patch makes machine_kexec_prepare() store into some
> _global_ variables, which means if you've loaded a crash kernel
> followed by a default kernel, the values for the crash kernel will
> be corrupted.
> 
> So yes, I think a revert of this patch is the right thing.

Great. Would you like me to submit the revert to the patch system or are you
happy just to do it using git?

> I think the only valid thing its doing is moving the copy of the
> reboot code earlier, but I don't see the value of moving just that.

Neither can I. It seems to be happy enough with the patch reverted, so if it
ain't broke...

Will
