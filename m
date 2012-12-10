From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 10 Dec 2012 11:04:05 +0000
Subject: [PATCH] ARM: ftrace: Ensure code modifications are synchronised
 across all cpus
In-Reply-To: <20121207190244.GB29618@mudshark.cambridge.arm.com>
References: <1354872138.3176.15.camel@computer5.home>
 <1354888985.17101.41.camel@gandalf.local.home>
 <1354892111.13000.50.camel@linaro1.home>
 <1354894134.17101.44.camel@gandalf.local.home>
 <20121207162346.GW14363@n2100.arm.linux.org.uk>
 <1354898200.17101.50.camel@gandalf.local.home>
 <20121207164530.GX14363@n2100.arm.linux.org.uk>
 <1354900436.17101.58.camel@gandalf.local.home>
 <20121207181309.GY14363@n2100.arm.linux.org.uk>
 <1354905805.17101.86.camel@gandalf.local.home>
 <20121207190244.GB29618@mudshark.cambridge.arm.com>
Message-ID: <1355137445.3386.7.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-12-07 at 19:02 +0000, Will Deacon wrote:
> For ARMv7, there are small subsets of instructions for ARM and Thumb which
> are guaranteed to be atomic wrt concurrent modification and execution of
> the instruction stream between different processors:
> 
> Thumb:	The 16-bit encodings of the B, NOP, BKPT, and SVC instructions.
> ARM:	The B, BL, NOP, BKPT, SVC, HVC, and SMC instructions.
> 

So this means for things like kprobes which can modify arbitrary kernel
code we are going to need to continue to always use some form of
stop_the_whole_system() function?

Also, kprobes currently uses patch_text() which only uses stop_machine
for Thumb2 instructions which straddle a word boundary, so this needs
changing?

-- 
Tixy
