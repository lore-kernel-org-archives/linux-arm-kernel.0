From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Tue, 06 Sep 2016 20:33:20 -0300
Subject: Kexec regression in next-20160906
In-Reply-To: <20160906220936.4txqzodkgknhjiyh@atomide.com>
References: <20160906220936.4txqzodkgknhjiyh@atomide.com>
Message-ID: <2229914.bQjEFCIRgO@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tony,

Am Dienstag, 06 September 2016, 15:09:37 schrieb Tony Lindgren:
> Looks like commit 5c01cdd2d4bc ("kexec_file: allow skipping checksum
> calculation for some segments") makes next-20160916 stop working for
> me at least on ARM.
> 
> I now get "kexec_load failed: Invalid argument error" on loading the
> new kernel to memory with kexec -l.
> 
> Reverting the following two commits makes things work for me again:
> 
> d2bf993afdf1 ("kexec_file: add mechanism to update kexec segments")
> 5c01cdd2d4bc ("kexec_file: allow skipping checksum calculation for
> some segments")

Thanks for reporting the problem and finding the commit that caused it.
The only thing in commit 5c01cdd2d4bc which can affect kexec_load is the 
fact that struct kexec_segment has a new member.

This is probably breaking the ABI on ARM, then. I verified that kexec_load 
kept working on ppc64le with a kexec binary compiled with the original 
struct kexec_segment definition, but apparently I got lucky.

I'll prepare a new version of the kexec buffer hand-over series which 
doesn't touch struct kexec_segment.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
