From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Dec 2015 10:34:59 +0000
Subject: [RFC] kprobe'ing conditionally executed instructions
In-Reply-To: <1449829633.2815.27.camel@linaro.org>
References: <566A5997.9020908@linaro.org> <1449829633.2815.27.camel@linaro.org>
Message-ID: <20151211103459.GS8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 10:27:13AM +0000, Jon Medhurst (Tixy) wrote:
> On Fri, 2015-12-11 at 00:05 -0500, David Long wrote:
> > There is a moderate amount of code already in kprobes on ARM and the 
> > current ARMv8 patch to deal with conditional execution of instructions. 
> > One aspect of how this is handled is that instructions that fail their 
> > predicate and are not (technically) executed are also not treated as a 
> > hit kprobe. Steve Capper has suggested that the probe handling should 
> > still take place because we stepped through the instruction even if it 
> > was effectively a nop.  This would be a significant change in how it 
> > currently works on 32-bit ARM
> 
> 32-bit ARM uses undefined instructions for kprobe 'breakpoints' and the
> ARM ARM says it's implementation defined behaviour whether these
> generate exceptions or not, i.e. whether the kprobe handler will be
> called.

There are two classes of undefined instructions.  There are those which
fall into the above category, and there are those which are guaranteed
to raise an exception.  We should always be using the guaranteed ones,
not the other set.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
