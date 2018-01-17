From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 17 Jan 2018 23:35:08 +0000
Subject: [PATCH RFC v1] arm64: Handle traps from accessing CNTVCT/CNTFRQ
 for CONFIG_COMPAT
In-Reply-To: <20180117204154.GA2935@Asurada-Nvidia>
References: <1515645816-14063-1-git-send-email-nicoleotsuka@gmail.com>
 <e750e380-f06b-dbbf-a61c-4281c0168b05@arm.com>
 <20180116203218.GA6318@Asurada-Nvidia>
 <86r2qpec32.wl-marc.zyngier@arm.com>
 <20180116213745.GA9545@Asurada-Nvidia>
 <20180117021346.GA26166@Asurada-Nvidia>
 <83b9c187-7fbf-3e05-6321-de7fa05fd868@arm.com>
 <20180117204154.GA2935@Asurada-Nvidia>
Message-ID: <20180117233508.45282a7b@m750.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Jan 2018 12:41:56 -0800
Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> On Wed, Jan 17, 2018 at 09:03:48AM +0000, Marc Zyngier wrote:
> 
> > > So ignoring a condition for a Thumb instruction may cause its IT
> > > scope shifting. For ARM mode, the only penalty could be two Rts
> > > getting written -- which shouldn't corrupt userspace execution.
> > > 
> > > Please correct me if I am wrong or not thorough.  
> > 
> > Consider the following:
> > 	
> > 	mov	r0, #0
> > 	mov	r1, #0
> > 	cmp	r1, #3
> > 	mrrceq	r0, r1, cntvct // simplified version
> > 
> > Oh look, you've corrupted r0 and r1, which should never have be
> > changed. Whatever uses the content r0 and r1 after the mrrc will
> > misbehave. How is that an acceptable behaviour? How do you expect
> > userspace to cope with such a brain damage?
> > 
> > If you intend to emulate the CPU, you must emulate it fully, to the
> > letter of the architecture. No ifs, no buts.  
> 
> Thanks for the explain. I see the point here.
> 
> I saw your version for arm64 compat doesn't check if (rt != 31)
> as MRS handler does. Is there any reason for that?

Um, perhaps because it's *compat*? How do you envision an AArch32
MR{R}C instruction targeting r31, exactly? ;)

Robin.
