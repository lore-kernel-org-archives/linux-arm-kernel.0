From: nicoleotsuka@gmail.com (Nicolin Chen)
Date: Tue, 16 Jan 2018 18:13:48 -0800
Subject: [PATCH RFC v1] arm64: Handle traps from accessing CNTVCT/CNTFRQ
 for CONFIG_COMPAT
In-Reply-To: <20180116213745.GA9545@Asurada-Nvidia>
References: <1515645816-14063-1-git-send-email-nicoleotsuka@gmail.com>
 <e750e380-f06b-dbbf-a61c-4281c0168b05@arm.com>
 <20180116203218.GA6318@Asurada-Nvidia>
 <86r2qpec32.wl-marc.zyngier@arm.com>
 <20180116213745.GA9545@Asurada-Nvidia>
Message-ID: <20180117021346.GA26166@Asurada-Nvidia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 01:37:46PM -0800, Nicolin Chen wrote:
> On Tue, Jan 16, 2018 at 09:19:13PM +0000, Marc Zyngier wrote:
> 
> > > I understand that it should take care of the condition field as
> > > a general instruction handler. Just for curiosity: If we confine
> > > the topic to read access of CNTVCT/CNTFRQ, what'd be the penalty
> > > by ignoring the condition field and executing it anyway?
> > 
> > Do you mean, apart from severely corrupting userspace execution?
> > That's a rhetorical question, right?
> 
> I don't quite understand the corrupting userspace execution part.
> What I see for a conditional CNTVCT read is more likely:
> 	if (condition) {	// in this case, if (true)
> 		r1 = lower32(cntvct);
> 		r2 = higher32(cntvct);
> 	}
> 
> Could you please elaborate a bit? Thank you.

I guess I got it now. The concern seems to be Thumb instructions.
So ignoring a condition for a Thumb instruction may cause its IT
scope shifting. For ARM mode, the only penalty could be two Rts
getting written -- which shouldn't corrupt userspace execution.

Please correct me if I am wrong or not thorough.

Thanks
Nicolin
