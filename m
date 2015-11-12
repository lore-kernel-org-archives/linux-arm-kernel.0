From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Nov 2015 10:38:24 +0000
Subject: pj4 -marm breaks thumb ftrace
In-Reply-To: <56446A40.7000304@linaro.org>
References: <20151112095020.GB15032@codeaurora.org>
 <56446A40.7000304@linaro.org>
Message-ID: <20151112103824.GJ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 11:30:24AM +0100, Ard Biesheuvel wrote:
> Compiling pj4-cp0.c in thumb mode fails on the sub instruction in the
> following sequence:
> 
> static void __init pj4_cp_access_write(u32 value)
> {
> u32 temp;
> 
>     __asm__ __volatile__ (
>         "mcr p15, 0, %1, c1, c0, 2\n\t"
>         "mrc p15, 0, %0, c1, c0, 2\n\t"
>         "mov %0, %0\n\t"
>         "sub pc, pc, #4\n\t"
>         : "=r" (temp) : "r" (value));
> }
> 
> I wonder if the sub instruction is simply there to flush the pipeline, but
> let's not get into that.

It is.  The whole "mov %0, %0; sub pc, pc, #4" is a documented requirement
for Xscale and derivatives to ensure that effects of previous instructions
are seen by following instructios.  It predates ARMs barriers.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
