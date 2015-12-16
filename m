From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 16 Dec 2015 15:36:09 +0800
Subject: [PATCH] clocksource/drivers/pistachio: Fix wrong calculated
 clocksource read value
In-Reply-To: <20151216152807.23491eee@xhacker>
References: <1448466169-5230-1-git-send-email-jszhang@marvell.com>
 <56707F32.3030405@linaro.org>	<20151216151125.1e91b4f4@xhacker>
 <20151216152807.23491eee@xhacker>
Message-ID: <20151216153609.0f09f941@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Dec 2015 15:28:07 +0800 wrote:

> On Wed, 16 Dec 2015 15:11:25 +0800
> Jisheng Zhang  wrote:
> 
> > Dear Daniel,
> > 
> > On Tue, 15 Dec 2015 21:59:30 +0100 Daniel Lezcano wrote:
> >   
> > > On 11/25/2015 04:42 PM, Jisheng Zhang wrote:    
> > > > Let's assume the counter value is 0xf000000, the pistachio clocksource  
> 
> oops, sorry, should be 0xf0000000. Do I need to send a v2 patch?

And in fact, clocksource_mmio_readw_down() also has similar issue, but it masks
with c->mask before return, the c->mask is less than 32 bit (because the
clocksource_mmio_init think number of valid bits > 32 or < 16 is invalid.)
the higher 32 bits are masked off, so we never saw such issue. But we'd better
to fix that, what's your opinion?

Thank you very much,
Jisheng

> 
> > > > read cycles function would return 0xffffffff0fffffff, but it should
> > > > return 0xfffffff.
> > > >
> > > > We fix this issue by calculating bitwise-not counter, then cast to
> > > > cycle_t.
> > > >
> > > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>      
> > > 
> > > Hi Jisheng,
> > > 
> > > I tried to reproduce this behavior on x86_64 but without success.
> > > 
> > > On which architecture did you produce this result ? Do you have a simple 
> > > test program to check with ?    
> > 
> > I have no HW platforms with pistachio, just read the code and run the
> > following test code in x86_64 and x86_32:
> > 
> > #include <stdio.h>
> > unsigned long long pistachio_clocksource_read_cycles()
> > {
> > 	unsigned int counter = 0xf000000;  
> 
> should be unsigned int counter = 0xf0000000;
> 
> > 	return ~(unsigned long long)counter;
> > }
> > int main()
> > {
> > 	printf("%llx\n", pistachio_clocksource_read_cycles());
> > 	return 0;
> > }
> > 
> > Thanks,
> > Jisheng
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel  
> 
