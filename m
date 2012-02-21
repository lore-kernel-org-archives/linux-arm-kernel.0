From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Feb 2012 15:57:08 +0000
Subject: [PATCH] ARM: perf: do not handle deleted counter in irq handler
 to avoid oops
In-Reply-To: <CACVXFVNrWgeEKjZyrEgugGrKkLz030aeMwwNWd_jwdMA5-=N=Q@mail.gmail.com>
References: <1329799058-27082-1-git-send-email-tom.leiming@gmail.com>
 <20120221133228.GK19696@mudshark.cambridge.arm.com>
 <CACVXFVMxpRDsG_hNn_WaX17uEdZCJmcraOvDwCL6JQ7Xyz5nig@mail.gmail.com>
 <20120221151909.GA23133@mudshark.cambridge.arm.com>
 <CACVXFVOR7oF1nq9p55+3b2at2Appa_YyFEWhD=dF8jGfy0H+OQ@mail.gmail.com>
 <20120221154007.GB23133@mudshark.cambridge.arm.com>
 <CACVXFVNrWgeEKjZyrEgugGrKkLz030aeMwwNWd_jwdMA5-=N=Q@mail.gmail.com>
Message-ID: <20120221155707.GD23133@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 03:49:22PM +0000, Ming Lei wrote:
> On Tue, Feb 21, 2012 at 11:40 PM, Will Deacon <will.deacon@arm.com> wrote:
> > Sure they do. When we read-modify-write the pmcr we &= ~mask, so we end up
> > writing the overflow flags back if they are set, which is sufficient to
> > clear them.
> 
> Sorry for missing it, but looks xscale uses standalone overflow
> register and does not
> clear its overflow flag.

Hmmm, I don't know very much about the xscale PMUs (the perf code is based
on the old OProfile code). The xscale2 overflow handler is certainly doing
something with some overflow flags though, but then it checks the pmnc again
for each counter...

I'd rather not touch that without knowing *exactly* what I'm doing. It may
be that the current code deals with the flag but, even if it doesn't, the
spurious interrupt isn't the end of the world. I have a board at home that
advertises its PMU as xscale2, so I could test that this patch doesn't cause
breakage.

Will
