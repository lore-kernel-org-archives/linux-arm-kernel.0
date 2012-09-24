From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Sep 2012 00:08:36 +0100
Subject: [PATCH v3 RESEND 05/17] ARM: LPAE: support 64-bit virt_to_phys
 patching
In-Reply-To: <5060E456.2060600@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-6-git-send-email-cyril@ti.com>
 <20120924151305.GA14198@arm.com>
 <alpine.LFD.2.02.1209241152540.6667@xanadu.home> <5060C9C6.8080900@ti.com>
 <alpine.LFD.2.02.1209241709200.6667@xanadu.home>
 <CAHkRjk74aHMNZxOVgsQo-NTm33ALZPVeiPAP5amCdBdF4-yjWw@mail.gmail.com>
 <alpine.LFD.2.02.1209241826260.6667@xanadu.home>
 <20120924224021.GJ26454@n2100.arm.linux.org.uk> <5060E456.2060600@ti.com>
Message-ID: <20120924230836.GK26454@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 06:53:10PM -0400, Cyril Chemparathy wrote:
> The existing fixup code runs too early - before we get a chance to  
> switch over from the boot-time sub-4G alias to the real physical address  
> space.  Readability aside, part of the reasoning behind the C  
> re-implementation was to defer the patch application until a later point  
> in the boot process.
>
> That said, we could patch once at boot, and then re-patch at switch  
> over, I guess.  Is that what you're recommending?

That would solve the problem, and probably in the least disruptive
manner too, since the existing solution will continue to work, and
we'd only need to fixup the movw instructions if we're building in
support for the rare 'high-lowmem' situation.

We don't even need any different module marking - the 'high-lowmem'
modules don't need their movw instructions fixed.
