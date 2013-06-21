From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Jun 2013 10:33:11 +0100
Subject: [PATCH 0/5] Kernel mode NEON for XOR and RAID6
In-Reply-To: <alpine.LFD.2.03.1306072214120.18597@syhkavp.arg>
References: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130606151705.GG16794@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306061156330.18597@syhkavp.arg>
 <20130607175007.GH8111@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306072214120.18597@syhkavp.arg>
Message-ID: <20130621093311.GD6983@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On Sat, Jun 08, 2013 at 04:09:56AM +0100, Nicolas Pitre wrote:
> On Fri, 7 Jun 2013, Will Deacon wrote:
> > > Note that the kernel performs runtime benchmarking of all the different 
> > > implementations it has available at boot time and selects the best one.  
> > > So if this would turn out to make things worse on some cores then the 
> > > Neon code would simply not be used.
> > 
> > That will be all sorts of fun if we try to run this on big.LITTLE...
> > Perhaps we don't care about that either.
> 
> Probably not at the present time.

[...]

> > What's the earliest toolchain we claim to support nowadays? If that can't
> > deal with the intrinsics then we either need to bump the requirement, or
> > write this using hand-coded asm. In the case of the latter, I don't think
> > the maintenance overhead of having two implementations is worth it.
> 
> We have many different minimum toolchain version requirements attached 
> to different features being enabled already, ftrace being one of them if 
> I remember correctly.  For these Neon optimizations the minimum gcc 
> version is v4.6.
> 
> Given that this is going to be interesting mostly to server systems, and 
> given that ARM server deployments are rather new, I don't see the point 
> of compiling a new server environment using an older gcc version.

I've mulled over this, had some discussions with our toolchain guys and
have concluded the following:

  - The intrinsics are actually ok. I was sceptical at first, but I've been
    assured that they should do a reasonable job (echoing your performance
    figures).

  - The current approach is targetting servers and isn't (yet) suitable for
    mobile.

So, given that the patches do the right thing wrt GCC version, the only
remaining point is that we need to keep an eye out for people trying to
re-use this stuff for mobile (likely crypto, as I mentioned earlier). When
that happens, we should consider revisiting the benchmark/power figures.

Will
