From: bp@alien8.de (Borislav Petkov)
Date: Fri, 30 Oct 2015 18:51:15 +0100
Subject: [PATCH v4] EDAC: Add ARM64 EDAC
In-Reply-To: <20151030170605.GI31073@leverpostej>
References: <1446048829-3359-1-git-send-email-brijeshkumar.singh@amd.com>
 <20151028164053.GG25451@leverpostej> <56339A52.8060701@amd.com>
 <20151030170605.GI31073@leverpostej>
Message-ID: <20151030175115.GI20952@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 05:06:06PM +0000, Mark Rutland wrote:
> > * Correctable errors does not generate any interrupt:
> >   If we have to implement error parsing inside the firmware then work need
> >   to be split between OS and firmware. Maybe OS can call SMC instruction to 
> >   dial into firmware and then firmware can check error syndrome registers; 
> >   if it finds correctable error then build HEST table. This method will introduce
> >   performance issue because it require OS executing SMC every 100ms or so to just
> >   poll for correctable error. If you have any other recommendation then please share it.
> 
> I agree that this is a problem, and is an unfortunate hardware
> limitation.
> 
> I am still wary of making use of IMPLEMENTATION DEFINED features like
> this in the kernel.

Well, you could do all the correctable errors collecting in the firmware
and only report those errors to the OS when they're overflowing/reach a
certain threshold.

The idea behind it being that you don't really want to upset the user
about *every* correctable error happening because it was correctable and
the hardware, well, doh, corrected it. No problem.

But when those errors start repeating and hitting the same DIMM and
addresses in close proximity, there might be a problem which you should
report.

Btw, we have been looking for doing something like that on x86:

https://lkml.kernel.org/r/1404242623-10094-1-git-send-email-bp at alien8.de

and one of those days I'll upstream the damn thing!

:-)

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
