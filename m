From: joseph@codesourcery.com (Joseph S. Myers)
Date: Wed, 27 Jun 2012 19:17:21 +0000
Subject: Detecting support for trapping floating-point exceptions on ARM
In-Reply-To: <4FEB49B3.2030602@twiddle.net>
References: <Pine.LNX.4.64.1206121900150.1359@digraph.polyomino.org.uk>
 <4FEB49B3.2030602@twiddle.net>
Message-ID: <Pine.LNX.4.64.1206271904570.32296@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jun 2012, Richard Henderson wrote:

> On 06/12/2012 12:11 PM, Joseph S. Myers wrote:
> > ARM VFPv3 and VFPv4 do not support trapping floating-point exceptions; 
> > VFPv2, VFPv3U and VFPv4U do.  The lack of support causes the glibc 
> > math/test-fenv test to fail on VFPv3 and VFPv4 systems.
> > 
> > The natural fix for that would be for fesetenv (FE_NOMASK_ENV) to fail on 
> > hardware not supporting trapping exceptions.  There is, however, no HWCAP 
> > bit to indicate whether trapping floating-point exceptions is supported.  
> > Could one be added to the kernel, or is there a good way fesetenv could 
> > detect this from userspace without a new HWCAP bit?
> 
> I don't suppose those SBZ/RAZ bits just so happen to be ignored in
> actual hardware, so that you can write 1 and read it back and get 0
> to see if exceptions are unsupported?

Good point.  I tested on one VFPv3 system and the bits did read back as 
zero (and on one VFPv2 system and got back the expected 0x1f00).  And 
DDI0406C (page 1552) says "They are reserved, RAZ/WI, on a system that 
implements VFPv3 or VFPv4.", where RAZ/WI is "Read-As-Zero, Writes 
Ignored.  In any implementation, the bit must read as 0, or all 0s for a 
bit field, and writes to the field must be ignored.  Software can rely on 
the bit reading as 0, or all 0s for a bit field, and on writes being 
ignored." (page 2676), so this can be relied upon.  (This is a change in 
the documentation from DDI0406B which said RAZ/SBZP.)  So it is possible 
to test for this in userspace the way you suggest.

-- 
Joseph S. Myers
joseph at codesourcery.com
