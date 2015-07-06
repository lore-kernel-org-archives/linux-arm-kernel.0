From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jul 2015 17:02:30 +0100
Subject: weird behavior of get/set_fiq_regs()
In-Reply-To: <CAOpc7mHkynAfmZKJhbwF0q0rco+3t7=wzh9owf6Brz6fmPRHsw@mail.gmail.com>
References: <CAOpc7mHkynAfmZKJhbwF0q0rco+3t7=wzh9owf6Brz6fmPRHsw@mail.gmail.com>
Message-ID: <20150706160230.GG7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 04:48:38PM +0200, Holger Schurig wrote:
> Hi,
> 
> I'm trying to write a FIQ ISR handler. I wanted to use some registers
> to transfer information to/from the the FIQ ISR. But something changes
> the registers:

We should probably make the FIQ code depend on !SMP, or at least complain
if num_online_cpus > 1 and if we're in a schedulable context,  because the
issue you're running into is precisely that.

FIQ registers are not global amongst CPUs.  They're local to the CPU you
execute the code on.  What this means is that when you call set_fiq_regs(),
you are setting the FIQ registers on the CPU which executes set_fiq_regs().
Same goes for get_fiq_regs().

If they happen to be different CPUs, then you'll read a different set of
registers.

So, what you need to do is to ensure that the code which is using FIQs
all runs on the same CPU.

Also note that you'll get into hot water if you try to have FIQ handlers
in module code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
